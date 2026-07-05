import 'package:clock/clock.dart';
import 'package:drift/drift.dart';
import 'package:time_for_your_medicine/core/db/app_database.dart';
import 'package:time_for_your_medicine/core/util/day_utils.dart';

/// Opening pill counts for the seeded medicines, seeded as 'initial'
/// [SupplyTransactions] rows rather than a stored column (see
/// `MedicineRepository._currentSupply`).
const _initialSupply = {'m1': 12, 'm2': 30, 'm3': 20, 'm4': 6};

Future<void> seedTestMedicines(AppDatabase db) async {
  const medicines = <MedicinesCompanion>[
    MedicinesCompanion(
      id: Value('m1'),
      name: Value('Metformin'),
      dose: Value('500 mg'),
      withFood: Value(true),
      kind: Value('capsule'),
      c1: Value(0xFF5566D6),
      c2: Value(0xFFA6B0EE),
      soft: Value(0xFFE7E8FB),
    ),
    MedicinesCompanion(
      id: Value('m2'),
      name: Value('Vitamin D'),
      dose: Value('1000 IU'),
      withFood: Value(true),
      kind: Value('round'),
      c1: Value(0xFFD69A5A),
      soft: Value(0xFFFBF0DF),
    ),
    MedicinesCompanion(
      id: Value('m3'),
      name: Value('Ibuprofen'),
      dose: Value('200 mg'),
      withFood: Value(true),
      kind: Value('round'),
      c1: Value(0xFF5AA0D6),
      soft: Value(0xFFE2F0F8),
    ),
    MedicinesCompanion(
      id: Value('m4'),
      name: Value('Atorvastatin'),
      dose: Value('20 mg'),
      withFood: Value(false),
      kind: Value('capsule'),
      c1: Value(0xFFA77FD0),
      c2: Value(0xFFCDB6E6),
      soft: Value(0xFFF1ECF9),
    ),
  ];

  const doseTimes = <DoseTimesCompanion>[
    DoseTimesCompanion(
      medId: Value('m1'),
      id: Value('t1'),
      time: Value('8:00 AM'),
      period: Value('morning'),
    ),
    DoseTimesCompanion(
      medId: Value('m2'),
      id: Value('t1'),
      time: Value('8:00 AM'),
      period: Value('morning'),
    ),
    DoseTimesCompanion(
      medId: Value('m3'),
      id: Value('t1'),
      time: Value('1:00 PM'),
      period: Value('afternoon'),
    ),
    DoseTimesCompanion(
      medId: Value('m4'),
      id: Value('t1'),
      time: Value('9:00 PM'),
      period: Value('evening'),
    ),
  ];

  await db.batch((batch) {
    batch.insertAll(db.medicines, medicines);
    batch.insertAll(db.doseTimes, doseTimes);
    batch.insertAll(db.supplyTransactions, [
      for (final medicine in medicines)
        SupplyTransactionsCompanion.insert(
          medId: medicine.id.value,
          delta: _initialSupply[medicine.id.value] ?? 0,
          kind: 'initial',
          createdAt: clock.now(),
        ),
    ]);
    final logs = <DoseLogCompanion>[];
    for (var offset = -6; offset <= -1; offset++) {
      final iso = DayUtils.iso(DayUtils.addDays(kToday, offset));
      for (final medicine in medicines) {
        logs.add(
          DoseLogCompanion(
            iso: Value(iso),
            medId: Value(medicine.id.value),
            doseTimeId: const Value('t1'),
            status: const Value('taken'),
          ),
        );
      }
    }
    logs.add(
      DoseLogCompanion(
        iso: Value(DayUtils.iso(kToday)),
        medId: const Value('m1'),
        doseTimeId: const Value('t1'),
        status: const Value('taken'),
      ),
    );
    batch.insertAll(db.doseLog, logs);
  });
}
