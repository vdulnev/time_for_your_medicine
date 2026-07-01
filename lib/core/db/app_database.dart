import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

/// The fixed "today" the design is anchored to (June 30, 2026).
final DateTime kToday = DateTime(2026, 6, 30);
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
  IntColumn get supply => integer()();
  IntColumn get cap => integer()();

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
  BoolColumn get taken => boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {iso, medId, doseTimeId};
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
  int get schemaVersion => 5;

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
    },
  );
}
