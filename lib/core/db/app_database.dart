import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import '../util/day_utils.dart';

part 'app_database.g.dart';

/// The fixed "today" the design is anchored to (June 30, 2026).
final DateTime kToday = DateTime(2026, 6, 30);

@DataClassName('MedicineRow')
class Medicines extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get dose => text()();
  TextColumn get time => text()();
  TextColumn get period => text()();
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

@DataClassName('DoseRow')
class DoseLog extends Table {
  TextColumn get iso => text()();
  TextColumn get medId => text()();
  BoolColumn get taken => boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {iso, medId};
}

@DataClassName('SettingsData')
class SettingsRows extends Table {
  IntColumn get id => integer().withDefault(const Constant(0))();
  BoolColumn get sound => boolean().withDefault(const Constant(true))();
  BoolColumn get vibrate => boolean().withDefault(const Constant(false))();
  BoolColumn get refill => boolean().withDefault(const Constant(true))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('NotifOffRow')
class NotifOffRows extends Table {
  TextColumn get medId => text()();

  @override
  Set<Column<Object>> get primaryKey => {medId};
}

@DriftDatabase(tables: [Medicines, DoseLog, SettingsRows, NotifOffRows])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
    : super(executor ?? driftDatabase(name: 'pillpal'));

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      await _seed();
    },
  );

  Future<void> _seed() async {
    await batch((b) {
      b.insertAll(medicines, _seedMedicines);
      b.insert(settingsRows, const SettingsRowsCompanion(id: Value(0)));
      final logs = <DoseLogCompanion>[];
      for (var off = -6; off <= -1; off++) {
        final iso = DayUtils.iso(DayUtils.addDays(kToday, off));
        for (final med in _seedMedicines) {
          logs.add(
            DoseLogCompanion(
              iso: Value(iso),
              medId: Value(med.id.value),
              taken: const Value(true),
            ),
          );
        }
      }
      logs.add(
        DoseLogCompanion(
          iso: Value(DayUtils.iso(kToday)),
          medId: const Value('m1'),
          taken: const Value(true),
        ),
      );
      b.insertAll(doseLog, logs);
    });
  }
}

/// Seed medicines matching the design prototype.
final List<MedicinesCompanion> _seedMedicines = [
  const MedicinesCompanion(
    id: Value('m1'),
    name: Value('Metformin'),
    dose: Value('500 mg'),
    time: Value('8:00 AM'),
    period: Value('morning'),
    withFood: Value(true),
    kind: Value('capsule'),
    c1: Value(0xFF5566D6),
    c2: Value(0xFFA6B0EE),
    soft: Value(0xFFE7E8FB),
    supply: Value(12),
    cap: Value(60),
  ),
  const MedicinesCompanion(
    id: Value('m2'),
    name: Value('Vitamin D'),
    dose: Value('1000 IU'),
    time: Value('8:00 AM'),
    period: Value('morning'),
    withFood: Value(true),
    kind: Value('round'),
    c1: Value(0xFFD69A5A),
    soft: Value(0xFFFBF0DF),
    supply: Value(30),
    cap: Value(60),
  ),
  const MedicinesCompanion(
    id: Value('m3'),
    name: Value('Ibuprofen'),
    dose: Value('200 mg'),
    time: Value('1:00 PM'),
    period: Value('afternoon'),
    withFood: Value(true),
    kind: Value('round'),
    c1: Value(0xFF5AA0D6),
    soft: Value(0xFFE2F0F8),
    supply: Value(20),
    cap: Value(30),
  ),
  const MedicinesCompanion(
    id: Value('m4'),
    name: Value('Atorvastatin'),
    dose: Value('20 mg'),
    time: Value('9:00 PM'),
    period: Value('evening'),
    withFood: Value(false),
    kind: Value('capsule'),
    c1: Value(0xFFA77FD0),
    c2: Value(0xFFCDB6E6),
    soft: Value(0xFFF1ECF9),
    supply: Value(6),
    cap: Value(30),
  ),
];
