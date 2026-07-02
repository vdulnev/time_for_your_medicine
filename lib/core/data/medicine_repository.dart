import 'dart:convert';
import 'dart:io';

import 'package:clock/clock.dart';
import 'package:drift/drift.dart';
import 'package:fpdart/fpdart.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../db/app_database.dart';
import '../error/app_exception.dart';
import '../models/app_settings.dart';
import '../models/dose_status.dart';
import '../models/dose_time.dart';
import '../models/medicine.dart';
import '../models/medicine_registry.dart';
import '../models/period.dart';
import '../models/pill_kind.dart';
import '../state/data_state.dart';
import '../util/medicine_registry_csv.dart';
import 'medicine_registry_seed.dart';

/// The only gateway to the drift database. Returns `Either<AppException, T>`
/// and logs all operations through [Talker].
class MedicineRepository {
  MedicineRepository(this._db, this._talker);

  final AppDatabase _db;
  final Talker _talker;

  Future<Either<AppException, T>> _guard<T>(
    String op,
    Future<T> Function() body,
  ) async {
    try {
      final result = await body();
      _talker.debug('db: $op ok');
      return Right(result);
    } on Object catch (error, st) {
      _talker.handle(error, st, 'db: $op failed');
      final failure = error is AppException
          ? error
          : AppException.databaseFailure(message: error.toString());
      return Left(failure);
    }
  }

  Future<Either<AppException, DataState>> loadAll() {
    return _guard('loadAll', () async {
      final medRows = await _db.select(_db.medicines).get();
      final doseTimeRows = await (_db.select(
        _db.doseTimes,
      )..orderBy([(t) => OrderingTerm.asc(t.sortOrder)])).get();
      final doseRows = await _db.select(_db.doseLog).get();
      final settingsRow = await (_db.select(
        _db.settingsRows,
      )..limit(1)).getSingleOrNull();
      final notifRows = await _db.select(_db.notifOffRows).get();

      final timesByMed = <String, List<DoseTimeRow>>{};
      for (final t in doseTimeRows) {
        timesByMed.putIfAbsent(t.medId, () => []).add(t);
      }
      final doseStatus = <String, DoseStatus>{
        for (final d in doseRows)
          '${d.iso}|${d.medId}|${d.doseTimeId}': DoseStatus.fromName(d.status),
      };
      final notifOff = <String, bool>{for (final n in notifRows) n.medId: true};
      final settings = settingsRow == null
          ? const AppSettings()
          : AppSettings(
              sound: settingsRow.sound,
              vibrate: settingsRow.vibrate,
              refill: settingsRow.refill,
              localeOverride: settingsRow.localeOverride,
            );
      final supplyTotals = await _supplyTotals();

      return DataState(
        meds: [
          for (final r in medRows)
            _toMedicine(
              r,
              timesByMed[r.id] ?? const [],
              supplyTotals[r.id] ?? 0,
            ),
        ],
        doseStatus: doseStatus,
        settings: settings,
        notifOff: notifOff,
      );
    });
  }

  /// Every medicine's current pill count, derived from the sum of its
  /// [SupplyTransactions] deltas — nothing stores a running total.
  Future<Map<String, int>> _supplyTotals() async {
    final rows = await _db.select(_db.supplyTransactions).get();
    final totals = <String, int>{};
    for (final r in rows) {
      totals[r.medId] = (totals[r.medId] ?? 0) + r.delta;
    }
    return totals;
  }

  Future<int> _currentSupply(String medId) async {
    final rows = await (_db.select(
      _db.supplyTransactions,
    )..where((t) => t.medId.equals(medId))).get();
    return rows.fold<int>(0, (sum, r) => sum + r.delta);
  }

  /// The full supply-transaction ledger, newest first. Filtering (by
  /// medicine, date range) happens client-side in `Selectors` — the app's
  /// data volume is small enough that loading it all is simpler than
  /// threading filter params through the query.
  Future<Either<AppException, List<SupplyTransactionRow>>> loadTransactions() {
    return _guard('loadTransactions', () async {
      return (_db.select(
        _db.supplyTransactions,
      )..orderBy([(t) => OrderingTerm.desc(t.createdAt)])).get();
    });
  }

  /// Sets a dose's status. [DoseStatus.pending] deletes the row (absence
  /// means pending); [DoseStatus.taken] / [DoseStatus.rejected] upsert it.
  /// Does not touch pill supply — see [recordTake]/[recordRevertTake].
  Future<Either<AppException, Unit>> setDoseStatus(
    String iso,
    String medId,
    String doseTimeId,
    DoseStatus status,
  ) {
    return _guard('setDoseStatus', () async {
      if (status == DoseStatus.pending) {
        await (_db.delete(_db.doseLog)..where(
              (t) =>
                  t.iso.equals(iso) &
                  t.medId.equals(medId) &
                  t.doseTimeId.equals(doseTimeId),
            ))
            .go();
      } else {
        await _db
            .into(_db.doseLog)
            .insertOnConflictUpdate(
              DoseLogCompanion(
                iso: Value(iso),
                medId: Value(medId),
                doseTimeId: Value(doseTimeId),
                status: Value(status.name),
              ),
            );
      }
      return unit;
    });
  }

  /// Records a dose being marked taken: consumes one pill and logs a
  /// 'take' transaction.
  Future<Either<AppException, Unit>> recordTake(
    String medId, {
    required String iso,
    required String doseTimeId,
  }) {
    return _guard('recordTake', () async {
      await _logSupplyTransaction(
        medId,
        -1,
        'take',
        iso: iso,
        doseTimeId: doseTimeId,
      );
      return unit;
    });
  }

  /// Records a taken dose being reverted: restores the pill and logs a
  /// 'revertTake' transaction.
  Future<Either<AppException, Unit>> recordRevertTake(
    String medId, {
    required String iso,
    required String doseTimeId,
  }) {
    return _guard('recordRevertTake', () async {
      await _logSupplyTransaction(
        medId,
        1,
        'revertTake',
        iso: iso,
        doseTimeId: doseTimeId,
      );
      return unit;
    });
  }

  Future<void> _logSupplyTransaction(
    String medId,
    int delta,
    String kind, {
    String? iso,
    String? doseTimeId,
  }) async {
    await _db
        .into(_db.supplyTransactions)
        .insert(
          SupplyTransactionsCompanion.insert(
            medId: medId,
            delta: delta,
            kind: kind,
            createdAt: clock.now(),
            iso: Value(iso),
            doseTimeId: Value(doseTimeId),
          ),
        );
  }

  Future<Either<AppException, Unit>> addMedicine(Medicine med) {
    return _guard('addMedicine', () async {
      await _db.transaction(() async {
        await _db.into(_db.medicines).insert(_toCompanion(med));
        await _db.batch((batch) {
          batch.insertAll(_db.doseTimes, [
            for (var i = 0; i < med.times.length; i++)
              DoseTimesCompanion.insert(
                medId: med.id,
                id: med.times[i].id,
                time: med.times[i].time,
                period: med.times[i].period.name,
                sortOrder: Value(i),
              ),
          ]);
        });
        if (med.supply > 0) {
          await _db
              .into(_db.supplyTransactions)
              .insert(
                SupplyTransactionsCompanion.insert(
                  medId: med.id,
                  delta: med.supply,
                  kind: 'initial',
                  createdAt: clock.now(),
                ),
              );
        }
      });
      return unit;
    });
  }

  Future<Either<AppException, Unit>> deleteMedicine(String id) {
    return _guard('deleteMedicine', () async {
      await (_db.delete(_db.medicines)..where((t) => t.id.equals(id))).go();
      await (_db.delete(_db.doseTimes)..where((t) => t.medId.equals(id))).go();
      await (_db.delete(_db.doseLog)..where((t) => t.medId.equals(id))).go();
      await (_db.delete(
        _db.supplyTransactions,
      )..where((t) => t.medId.equals(id))).go();
      await (_db.delete(
        _db.notifOffRows,
      )..where((t) => t.medId.equals(id))).go();
      return unit;
    });
  }

  /// Sets a medicine's pill count to [newTotal] (both the running supply
  /// and the "full pack" cap), logging the signed difference as a 'refill'
  /// transaction. A total lower than the current supply logs a negative
  /// delta — this doubles as the error-correction path.
  Future<Either<AppException, Unit>> refillMedicine(
    String medId,
    int newTotal,
  ) {
    return _guard('refillMedicine', () async {
      await _db.transaction(() async {
        final currentSupply = await _currentSupply(medId);
        final delta = newTotal - currentSupply;
        await (_db.update(_db.medicines)..where((t) => t.id.equals(medId)))
            .write(MedicinesCompanion(cap: Value(newTotal)));
        await _db
            .into(_db.supplyTransactions)
            .insert(
              SupplyTransactionsCompanion.insert(
                medId: medId,
                delta: delta,
                kind: 'refill',
                createdAt: clock.now(),
              ),
            );
      });
      return unit;
    });
  }

  Future<Either<AppException, Unit>> saveSettings(AppSettings settings) {
    return _guard('saveSettings', () async {
      await _db
          .into(_db.settingsRows)
          .insertOnConflictUpdate(
            SettingsRowsCompanion(
              id: const Value(0),
              sound: Value(settings.sound),
              vibrate: Value(settings.vibrate),
              refill: Value(settings.refill),
              localeOverride: Value(settings.localeOverride),
            ),
          );
      return unit;
    });
  }

  Future<Either<AppException, Unit>> setNotifOff(String medId, bool off) {
    return _guard('setNotifOff', () async {
      if (off) {
        await _db
            .into(_db.notifOffRows)
            .insertOnConflictUpdate(NotifOffRowsCompanion(medId: Value(medId)));
      } else {
        await (_db.delete(
          _db.notifOffRows,
        )..where((t) => t.medId.equals(medId))).go();
      }
      return unit;
    });
  }

  Future<Either<AppException, MedicineRegistryStatus>>
  ensureMedicineRegistry() {
    return _guard('ensureMedicineRegistry', () async {
      final existing = await (_db.select(
        _db.medicineRegistryMeta,
      )..limit(1)).getSingleOrNull();
      if (existing != null) return _toRegistryStatus(existing);

      final compressed = base64.decode(medicineRegistrySeedBase64);
      final csvBytes = Uint8List.fromList(gzip.decode(compressed));
      final items = await parseMedicineRegistryBytes(csvBytes);
      return _replaceMedicineRegistry(
        items,
        medicineRegistrySeedSource,
        DateTime.parse(medicineRegistrySeedGeneratedAt),
      );
    });
  }

  Future<Either<AppException, List<MedicineRegistryItem>>>
  searchMedicineRegistry(String query, {int limit = 30}) {
    return _guard('searchMedicineRegistry', () async {
      final normalized = query.trim().toLowerCase();
      if (normalized.length < 2) return const <MedicineRegistryItem>[];
      final rows =
          await (_db.select(_db.medicineRegistryEntries)
                ..where((row) => row.searchText.contains(normalized))
                ..orderBy([(row) => OrderingTerm.asc(row.name)])
                ..limit(limit))
              .get();
      return [
        for (final row in rows)
          MedicineRegistryItem(
            name: row.name,
            genericName: row.genericName,
            form: row.form,
          ),
      ];
    });
  }

  Future<Either<AppException, MedicineRegistryStatus>>
  replaceMedicineRegistryFromCsv(
    Stream<List<int>> bytes,
    String sourceName,
  ) async {
    try {
      final items = await parseMedicineRegistryCsv(bytes);
      return _guard('replaceMedicineRegistryFromCsv', () {
        return _replaceMedicineRegistry(items, sourceName, DateTime.now());
      });
    } on FormatException catch (error, st) {
      _talker.handle(error, st, 'registry: invalid CSV');
      return Left(AppException.invalidRegistryFile(message: error.message));
    } on Object catch (error, st) {
      _talker.handle(error, st, 'registry: import failed');
      return Left(AppException.unknown(error: error));
    }
  }

  Future<MedicineRegistryStatus> _replaceMedicineRegistry(
    List<MedicineRegistryItem> items,
    String sourceName,
    DateTime importedAt,
  ) async {
    await _db.transaction(() async {
      await _db.delete(_db.medicineRegistryEntries).go();
      await _db.batch((batch) {
        batch.insertAll(_db.medicineRegistryEntries, [
          for (final item in items)
            MedicineRegistryEntriesCompanion.insert(
              name: item.name,
              genericName: item.genericName,
              form: item.form,
              searchText: _registrySearchText(item),
            ),
        ]);
        batch.insert(
          _db.medicineRegistryMeta,
          MedicineRegistryMetaCompanion.insert(
            id: const Value(0),
            sourceName: sourceName,
            importedAt: importedAt,
            entryCount: items.length,
          ),
          mode: InsertMode.insertOrReplace,
        );
      });
    });
    return MedicineRegistryStatus(
      sourceName: sourceName,
      importedAt: importedAt,
      entryCount: items.length,
    );
  }

  MedicineRegistryStatus _toRegistryStatus(MedicineRegistryMetaRow row) {
    return MedicineRegistryStatus(
      sourceName: row.sourceName,
      importedAt: row.importedAt,
      entryCount: row.entryCount,
    );
  }

  String _registrySearchText(MedicineRegistryItem item) {
    return '${item.name} ${item.genericName} ${item.form}'.toLowerCase();
  }

  /// [rawSupply] is the ledger sum for this medicine, clamped to
  /// `0..cap` for display (the ledger itself is never clamped).
  Medicine _toMedicine(MedicineRow r, List<DoseTimeRow> times, int rawSupply) =>
      Medicine(
        id: r.id,
        name: r.name,
        dose: r.dose,
        times: [
          for (final t in times)
            DoseTime(id: t.id, time: t.time, period: Period.fromName(t.period)),
        ],
        withFood: r.withFood,
        kind: PillKind.fromName(r.kind),
        c1: r.c1,
        c2: r.c2,
        soft: r.soft,
        supply: rawSupply.clamp(0, r.cap),
        cap: r.cap,
      );

  MedicinesCompanion _toCompanion(Medicine m) => MedicinesCompanion(
    id: Value(m.id),
    name: Value(m.name),
    dose: Value(m.dose),
    withFood: Value(m.withFood),
    kind: Value(m.kind.name),
    c1: Value(m.c1),
    c2: Value(m.c2),
    soft: Value(m.soft),
    cap: Value(m.cap),
  );
}
