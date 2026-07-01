import 'package:drift/drift.dart';
import 'package:fpdart/fpdart.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../db/app_database.dart';
import '../error/app_exception.dart';
import '../models/app_settings.dart';
import '../models/medicine.dart';
import '../models/period.dart';
import '../models/pill_kind.dart';
import '../state/data_state.dart';

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
      final doseRows = await _db.select(_db.doseLog).get();
      final settingsRow = await (_db.select(
        _db.settingsRows,
      )..limit(1)).getSingleOrNull();
      final notifRows = await _db.select(_db.notifOffRows).get();

      final taken = <String, bool>{
        for (final d in doseRows)
          if (d.taken) '${d.iso}|${d.medId}': true,
      };
      final notifOff = <String, bool>{for (final n in notifRows) n.medId: true};
      final settings = settingsRow == null
          ? const AppSettings()
          : AppSettings(
              sound: settingsRow.sound,
              vibrate: settingsRow.vibrate,
              refill: settingsRow.refill,
            );

      return DataState(
        meds: [for (final r in medRows) _toMedicine(r)],
        taken: taken,
        settings: settings,
        notifOff: notifOff,
      );
    });
  }

  Future<Either<AppException, Unit>> setTaken(
    String iso,
    String medId,
    bool taken,
  ) {
    return _guard('setTaken', () async {
      await _db
          .into(_db.doseLog)
          .insertOnConflictUpdate(
            DoseLogCompanion(
              iso: Value(iso),
              medId: Value(medId),
              taken: Value(taken),
            ),
          );
      return unit;
    });
  }

  Future<Either<AppException, Unit>> addMedicine(Medicine med) {
    return _guard('addMedicine', () async {
      await _db.into(_db.medicines).insert(_toCompanion(med));
      return unit;
    });
  }

  Future<Either<AppException, Unit>> deleteMedicine(String id) {
    return _guard('deleteMedicine', () async {
      await (_db.delete(_db.medicines)..where((t) => t.id.equals(id))).go();
      await (_db.delete(_db.doseLog)..where((t) => t.medId.equals(id))).go();
      await (_db.delete(
        _db.notifOffRows,
      )..where((t) => t.medId.equals(id))).go();
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

  Medicine _toMedicine(MedicineRow r) => Medicine(
    id: r.id,
    name: r.name,
    dose: r.dose,
    time: r.time,
    period: Period.fromName(r.period),
    withFood: r.withFood,
    kind: PillKind.fromName(r.kind),
    c1: r.c1,
    c2: r.c2,
    soft: r.soft,
    supply: r.supply,
    cap: r.cap,
  );

  MedicinesCompanion _toCompanion(Medicine m) => MedicinesCompanion(
    id: Value(m.id),
    name: Value(m.name),
    dose: Value(m.dose),
    time: Value(m.time),
    period: Value(m.period.name),
    withFood: Value(m.withFood),
    kind: Value(m.kind.name),
    c1: Value(m.c1),
    c2: Value(m.c2),
    soft: Value(m.soft),
    supply: Value(m.supply),
    cap: Value(m.cap),
  );
}
