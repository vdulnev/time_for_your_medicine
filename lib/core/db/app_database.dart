import 'package:clock/clock.dart';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

/// The app's notion of "today", at midnight local time. Backed by
/// `package:clock` so production always reflects the real device date,
/// while tests can pin it to a fixed day via `withClock(Clock.fixed(...))`
/// for deterministic, day-independent assertions.
DateTime get kToday {
  final now = clock.now();
  return DateTime(now.year, now.month, now.day);
}

const _legacyDemoMedicineIds = <String>['m1', 'm2', 'm3', 'm4'];

@DataClassName('MedicineRow')
class Medicines extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get dose => text()();
  BoolColumn get withFood => boolean()();
  TextColumn get kind => text()();
  IntColumn get c1 => integer()();
  IntColumn get c2 => integer().nullable()();
  IntColumn get soft => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// A scheduled dose slot for a medicine — one row per time it's taken each
/// day (e.g. a 3x/day medicine has three rows).
@DataClassName('DoseTimeRow')
class DoseTimes extends Table {
  TextColumn get medId => text()();
  TextColumn get id => text()();
  TextColumn get time => text()();
  TextColumn get period => text()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  @override
  Set<Column<Object>> get primaryKey => {medId, id};
}

@DataClassName('DoseRow')
class DoseLog extends Table {
  TextColumn get iso => text()();
  TextColumn get medId => text()();
  TextColumn get doseTimeId => text().withDefault(const Constant(''))();

  /// A [DoseStatus] name. A row only exists once a dose has been touched —
  /// absence means pending, so this is never actually 'pending' in practice.
  TextColumn get status => text().withDefault(const Constant('pending'))();

  @override
  Set<Column<Object>> get primaryKey => {iso, medId, doseTimeId};
}

/// An append-only ledger of every change to a medicine's pill [supply]:
/// the initial stock on Add, refills (and corrections, which are just a
/// refill whose new total is lower than the current supply), a dose being
/// taken (-1), and a taken dose being reverted (+1).
@DataClassName('SupplyTransactionRow')
class SupplyTransactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get medId => text()();
  IntColumn get delta => integer()();

  /// 'initial' | 'refill' | 'take' | 'revertTake'
  TextColumn get kind => text()();
  DateTimeColumn get createdAt => dateTime()();

  /// Set for 'take' / 'revertTake' transactions, tying them back to the
  /// specific dose that caused them.
  TextColumn get iso => text().nullable()();
  TextColumn get doseTimeId => text().nullable()();
}

@DataClassName('SettingsData')
class SettingsRows extends Table {
  IntColumn get id => integer().withDefault(const Constant(0))();
  BoolColumn get sound => boolean().withDefault(const Constant(true))();
  BoolColumn get vibrate => boolean().withDefault(const Constant(false))();
  BoolColumn get refill => boolean().withDefault(const Constant(true))();

  /// User-chosen language override ("en" / "uk"), or null to follow the
  /// device locale (see `resolveLocale`).
  TextColumn get localeOverride => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('NotifOffRow')
class NotifOffRows extends Table {
  TextColumn get medId => text()();

  @override
  Set<Column<Object>> get primaryKey => {medId};
}

@DataClassName('MedicineRegistryRow')
class MedicineRegistryEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get genericName => text()();
  TextColumn get form => text()();
  TextColumn get searchText => text()();
}

@DataClassName('MedicineRegistryMetaRow')
class MedicineRegistryMeta extends Table {
  IntColumn get id => integer().withDefault(const Constant(0))();
  TextColumn get sourceName => text()();
  DateTimeColumn get importedAt => dateTime()();
  IntColumn get entryCount => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DriftDatabase(
  tables: [
    Medicines,
    DoseTimes,
    DoseLog,
    SupplyTransactions,
    SettingsRows,
    NotifOffRows,
    MedicineRegistryEntries,
    MedicineRegistryMeta,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
    : super(executor ?? driftDatabase(name: 'pillpal'));

  @override
  int get schemaVersion => 9;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      await into(
        settingsRows,
      ).insert(const SettingsRowsCompanion(id: Value(0)));
    },
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.addColumn(settingsRows, settingsRows.localeOverride);
      }
      if (from < 3) {
        await m.createTable(medicineRegistryEntries);
        await m.createTable(medicineRegistryMeta);
      }
      if (from < 4) {
        await (delete(
          doseLog,
        )..where((row) => row.medId.isIn(_legacyDemoMedicineIds))).go();
        await (delete(
          notifOffRows,
        )..where((row) => row.medId.isIn(_legacyDemoMedicineIds))).go();
        await (delete(
          medicines,
        )..where((row) => row.id.isIn(_legacyDemoMedicineIds))).go();
      }
      if (from < 5) {
        // "Medicines" previously carried a single `time`/`period`. Fold
        // each medicine's one slot into the new `DoseTimes` table before
        // dropping those columns, so multi-dose-per-day can be added.
        final legacy = await customSelect(
          'SELECT id, time, period FROM medicines',
        ).get();
        await m.createTable(doseTimes);
        await m.addColumn(doseLog, doseLog.doseTimeId);
        for (final row in legacy) {
          final medId = row.read<String>('id');
          const slotId = 't1';
          await into(doseTimes).insert(
            DoseTimesCompanion.insert(
              medId: medId,
              id: slotId,
              time: row.read<String>('time'),
              period: row.read<String>('period'),
            ),
          );
          await customStatement(
            'UPDATE dose_log SET dose_time_id = ? WHERE med_id = ?',
            [slotId, medId],
          );
        }
        await customStatement('ALTER TABLE medicines DROP COLUMN time');
        await customStatement('ALTER TABLE medicines DROP COLUMN period');
      }
      if (from < 6) {
        // Dose tracking gains a third state (rejected), and pill counts
        // gain an append-only transaction ledger.
        await m.createTable(supplyTransactions);
        await m.addColumn(doseLog, doseLog.status);
        await customStatement(
          "UPDATE dose_log SET status = 'taken' WHERE taken = 1",
        );
        // Rows that were merely toggled back to false carry no information
        // under the new "absence == pending" convention.
        await customStatement('DELETE FROM dose_log WHERE taken = 0');
        await customStatement('ALTER TABLE dose_log DROP COLUMN taken');

        // Seed the ledger with each medicine's current stock as an opening
        // balance, so supply_transactions has a consistent starting point.
        final meds = await customSelect(
          'SELECT id, supply FROM medicines',
        ).get();
        for (final row in meds) {
          final supply = row.read<int>('supply');
          if (supply <= 0) continue;
          await into(supplyTransactions).insert(
            SupplyTransactionsCompanion.insert(
              medId: row.read<String>('id'),
              delta: supply,
              kind: 'initial',
              createdAt: clock.now(),
            ),
          );
        }
      }
      if (from < 7) {
        // `Medicines.supply` is now derived from `SupplyTransactions`
        // instead of stored — the v6 migration already seeded the ledger
        // with a matching opening balance, and every write since has kept
        // both in lockstep, so this is a pure drop with no data loss.
        await customStatement('ALTER TABLE medicines DROP COLUMN supply');
      }
      if (from < 8) {
        // The v4 → v5 migration (`if (from < 5)` above) added
        // `DoseLog.doseTimeId` via `m.addColumn`, which only adds a
        // column — it cannot change a table's PRIMARY KEY. Every real
        // device that migrated through v5 has been physically keyed on
        // just `(iso, med_id)` ever since, even though the Dart table
        // has declared `(iso, med_id, dose_time_id)` since v5.
        // `insertOnConflictUpdate` (used by `setDoseStatus`) generates
        // its ON CONFLICT target from the *declared* key, which SQLite
        // rejects when it doesn't match any actual constraint — so on
        // every such device, marking a dose taken or rejected has been
        // silently throwing inside `MedicineRepository._guard` (caught,
        // logged, never surfaced) and never reaching disk. The
        // optimistic in-memory state looked right until the next
        // restart reloaded from the untouched table. Rebuild the table
        // with the correct primary key, preserving existing rows —
        // there can be at most one legacy row per (iso, med_id), so
        // re-keying to the finer-grained (iso, med_id, dose_time_id)
        // can never collide.
        await customStatement('ALTER TABLE dose_log RENAME TO dose_log_v7');
        await m.createTable(doseLog);
        await customStatement('''
          INSERT INTO dose_log (iso, med_id, dose_time_id, status)
          SELECT iso, med_id, dose_time_id, status FROM dose_log_v7
        ''');
        await customStatement('DROP TABLE dose_log_v7');
      }
      if (from < 9) {
        // `cap` (the "full pack" size, used only to size the Refills
        // screen's progress bar) is gone — that bar is gone too, and
        // `supply` was already ledger-derived, never stored. Nothing
        // reads this column anymore.
        await customStatement('ALTER TABLE medicines DROP COLUMN cap');
      }
    },
  );
}
