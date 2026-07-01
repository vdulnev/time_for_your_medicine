import 'package:drift/drift.dart';
import 'package:time_for_your_medicine/core/db/app_database.dart';
import 'package:time_for_your_medicine/core/util/day_utils.dart';

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
      supply: Value(12),
      cap: Value(60),
    ),
    MedicinesCompanion(
      id: Value('m2'),
      name: Value('Vitamin D'),
      dose: Value('1000 IU'),
      withFood: Value(true),
      kind: Value('round'),
      c1: Value(0xFFD69A5A),
      soft: Value(0xFFFBF0DF),
      supply: Value(30),
      cap: Value(60),
    ),
    MedicinesCompanion(
      id: Value('m3'),
      name: Value('Ibuprofen'),
      dose: Value('200 mg'),
      withFood: Value(true),
      kind: Value('round'),
      c1: Value(0xFF5AA0D6),
      soft: Value(0xFFE2F0F8),
      supply: Value(20),
      cap: Value(30),
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
      supply: Value(6),
      cap: Value(30),
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
    final logs = <DoseLogCompanion>[];
    for (var offset = -6; offset <= -1; offset++) {
      final iso = DayUtils.iso(DayUtils.addDays(kToday, offset));
      for (final medicine in medicines) {
        logs.add(
          DoseLogCompanion(
            iso: Value(iso),
            medId: Value(medicine.id.value),
            doseTimeId: const Value('t1'),
            taken: const Value(true),
          ),
        );
      }
    }
    logs.add(
      DoseLogCompanion(
        iso: Value(DayUtils.iso(kToday)),
        medId: const Value('m1'),
        doseTimeId: const Value('t1'),
        taken: const Value(true),
      ),
    );
    batch.insertAll(db.doseLog, logs);
  });
}
