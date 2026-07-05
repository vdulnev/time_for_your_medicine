import 'package:clock/clock.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:time_for_your_medicine/core/data/medicine_repository.dart';
import 'package:time_for_your_medicine/core/db/app_database.dart';
import 'package:time_for_your_medicine/core/logging/talker.dart';
import 'package:time_for_your_medicine/core/models/add_draft.dart';
import 'package:time_for_your_medicine/core/models/dose_status.dart';
import 'package:time_for_your_medicine/core/models/dose_time.dart';
import 'package:time_for_your_medicine/core/models/medicine.dart';
import 'package:time_for_your_medicine/core/models/period.dart';
import 'package:time_for_your_medicine/core/models/pill_kind.dart';
import 'package:time_for_your_medicine/core/state/providers.dart';
import 'package:time_for_your_medicine/core/util/day_utils.dart';

import 'support/fixed_clock.dart';
import 'support/seed_test_data.dart';

void main() {
  late AppDatabase db;
  late MedicineRepository repo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = MedicineRepository(db, Talker());
  });

  tearDown(() => db.close());

  test('starts with no medicines or dose history', () async {
    final result = await repo.loadAll();
    final data = result.getOrElse((_) => throw StateError('load failed'));
    expect(data.meds, isEmpty);
    expect(data.doseStatus, isEmpty);
  });

  test('addMedicine persists a new row', () async {
    final med = _draftToMed(const AddDraft(name: 'Aspirin', dose: '100 mg'));
    await repo.addMedicine(med, 30);
    final data = (await repo.loadAll()).getOrElse((_) => throw StateError('x'));
    expect(data.meds.any((m) => m.name == 'Aspirin'), isTrue);
  });

  test('deleteMedicine removes the med and its dose log', () async {
    await withFixedToday(() async {
      final med = _draftToMed(const AddDraft(name: 'Aspirin', dose: '100 mg'));
      await repo.addMedicine(med, 30);
      await repo.setDoseStatus(
        DayUtils.iso(kToday),
        med.id,
        med.times.first.id,
        DoseStatus.taken,
      );
      await repo.deleteMedicine(med.id);
      final data = (await repo.loadAll()).getOrElse(
        (_) => throw StateError('x'),
      );
      expect(data.meds.any((m) => m.id == med.id), isFalse);
      expect(
        data.doseStatus.keys.any((k) => k.split('|')[1] == med.id),
        isFalse,
      );
    });
  });

  test('addMedicine persists multiple dose times a day', () async {
    await withFixedToday(() async {
      final med = Medicine(
        id: 'test-multi',
        name: 'Amoxicillin',
        dose: '500 mg',
        times: const [
          DoseTime(id: 't0', time: '8:00 AM', period: Period.morning),
          DoseTime(id: 't1', time: '2:00 PM', period: Period.afternoon),
          DoseTime(id: 't2', time: '9:00 PM', period: Period.evening),
        ],
        withFood: true,
        kind: PillKind.round,
        c1: 0xFF5566D6,
        soft: 0xFFE7E8FB,
      );
      await repo.addMedicine(med, 30);
      final data = (await repo.loadAll()).getOrElse(
        (_) => throw StateError('x'),
      );
      final loaded = data.meds.firstWhere((m) => m.id == med.id);
      expect(loaded.times, hasLength(3));

      await repo.setDoseStatus(
        DayUtils.iso(kToday),
        med.id,
        't0',
        DoseStatus.taken,
      );
      final afterOneToggle = (await repo.loadAll()).getOrElse(
        (_) => throw StateError('x'),
      );
      expect(
        afterOneToggle.isTaken(DayUtils.iso(kToday), med.id, 't0'),
        isTrue,
      );
      expect(
        afterOneToggle.isTaken(DayUtils.iso(kToday), med.id, 't1'),
        isFalse,
      );
    });
  });

  test('addReminderTimes appends new slots with fresh unique ids after '
      'existing ones, leaving the existing slot untouched', () async {
    final med = _draftToMed(const AddDraft(name: 'Aspirin', dose: '100 mg'));
    await repo.addMedicine(med, 30);

    final container = ProviderContainer(
      overrides: [
        databaseProvider.overrideWithValue(db),
        talkerProvider.overrideWithValue(Talker()),
      ],
    );
    addTearDown(container.dispose);

    await container.read(dataProvider.future);
    final notifier = container.read(dataProvider.notifier);

    await notifier.addReminderTimes(med.id, const [
      DraftTime(time: '2:00 PM', period: Period.afternoon),
      DraftTime(time: '9:00 PM', period: Period.evening),
    ]);

    final data = (await repo.loadAll()).getOrElse((_) => throw StateError('x'));
    final loaded = data.meds.singleWhere((m) => m.id == med.id);
    expect(loaded.times, hasLength(3));
    expect(loaded.times[0].id, 't1');
    expect(loaded.times[0].time, '8:00 AM');
    expect(loaded.times[1].time, '2:00 PM');
    expect(loaded.times[2].time, '9:00 PM');
    expect(loaded.times[1].id, isNot('t1'));
    expect(loaded.times[2].id, isNot('t1'));
    expect(loaded.times[1].id, isNot(loaded.times[2].id));
  });

  test('addReminderTimes falls back to the per-period default time when left '
      'blank', () async {
    final med = _draftToMed(const AddDraft(name: 'Aspirin', dose: '100 mg'));
    await repo.addMedicine(med, 30);

    final container = ProviderContainer(
      overrides: [
        databaseProvider.overrideWithValue(db),
        talkerProvider.overrideWithValue(Talker()),
      ],
    );
    addTearDown(container.dispose);

    await container.read(dataProvider.future);
    final notifier = container.read(dataProvider.notifier);

    await notifier.addReminderTimes(med.id, const [
      DraftTime(period: Period.evening),
    ]);

    final data = (await repo.loadAll()).getOrElse((_) => throw StateError('x'));
    final loaded = data.meds.singleWhere((m) => m.id == med.id);
    expect(loaded.times.last.time, Period.evening.defaultDisplayTime);
  });

  test(
    'addReminderTimes rejects a slot duplicating an existing time',
    () async {
      final med = _draftToMed(const AddDraft(name: 'Aspirin', dose: '100 mg'));
      await repo.addMedicine(med, 30); // existing slot: 8:00 AM, morning

      final container = ProviderContainer(
        overrides: [
          databaseProvider.overrideWithValue(db),
          talkerProvider.overrideWithValue(Talker()),
        ],
      );
      addTearDown(container.dispose);

      await container.read(dataProvider.future);
      final notifier = container.read(dataProvider.notifier);

      await notifier.addReminderTimes(med.id, const [
        DraftTime(time: '8:00 AM', period: Period.morning),
      ]);

      final data = (await repo.loadAll()).getOrElse(
        (_) => throw StateError('x'),
      );
      final loaded = data.meds.singleWhere((m) => m.id == med.id);
      expect(loaded.times, hasLength(1));
    },
  );

  test(
    'addReminderTimes rejects two staged slots that duplicate each other',
    () async {
      final med = _draftToMed(const AddDraft(name: 'Aspirin', dose: '100 mg'));
      await repo.addMedicine(med, 30);

      final container = ProviderContainer(
        overrides: [
          databaseProvider.overrideWithValue(db),
          talkerProvider.overrideWithValue(Talker()),
        ],
      );
      addTearDown(container.dispose);

      await container.read(dataProvider.future);
      final notifier = container.read(dataProvider.notifier);

      await notifier.addReminderTimes(med.id, const [
        DraftTime(time: '2:00 PM', period: Period.afternoon),
        DraftTime(time: '2:00 PM', period: Period.afternoon),
      ]);

      final data = (await repo.loadAll()).getOrElse(
        (_) => throw StateError('x'),
      );
      final loaded = data.meds.singleWhere((m) => m.id == med.id);
      expect(loaded.times, hasLength(1));
    },
  );

  test('localeOverride persists across save/load', () async {
    final loaded = (await repo.loadAll()).getOrElse(
      (_) => throw StateError('x'),
    );
    expect(loaded.settings.localeOverride, isNull);

    await repo.saveSettings(loaded.settings.copyWith(localeOverride: 'uk'));
    final withOverride = (await repo.loadAll()).getOrElse(
      (_) => throw StateError('x'),
    );
    expect(withOverride.settings.localeOverride, 'uk');

    // Explicitly clearing back to "System" must persist null, not skip it.
    await repo.saveSettings(
      withOverride.settings.copyWith(localeOverride: null),
    );
    final cleared = (await repo.loadAll()).getOrElse(
      (_) => throw StateError('x'),
    );
    expect(cleared.settings.localeOverride, isNull);
  });

  test(
    'addMedicine keeps every time slot even when none has typed text',
    () async {
      final container = ProviderContainer(
        overrides: [
          databaseProvider.overrideWithValue(db),
          talkerProvider.overrideWithValue(Talker()),
        ],
      );
      addTearDown(container.dispose);

      await container.read(dataProvider.future);
      final notifier = container.read(dataProvider.notifier);

      // User only picks a time-of-day per slot (Morning, then Evening) and
      // never types into either TIME field — both slots must still be
      // saved, each with a sensible default time for its own period.
      await notifier.addMedicine(
        const AddDraft(
          name: 'Ibuprofen',
          supply: '30',
          times: [
            DraftTime(period: Period.morning),
            DraftTime(period: Period.evening),
          ],
        ),
      );

      final data = (await repo.loadAll()).getOrElse(
        (_) => throw StateError('x'),
      );
      final med = data.meds.singleWhere((m) => m.name == 'Ibuprofen');
      expect(med.times, hasLength(2));
      expect(med.times[0].period, Period.morning);
      expect(med.times[1].period, Period.evening);
      expect(med.times[0].time, isNot(med.times[1].time));
    },
  );

  test('addMedicine persists the user-entered pill count', () async {
    final container = ProviderContainer(
      overrides: [
        databaseProvider.overrideWithValue(db),
        talkerProvider.overrideWithValue(Talker()),
      ],
    );
    addTearDown(container.dispose);

    await container.read(dataProvider.future);
    final notifier = container.read(dataProvider.notifier);

    await notifier.addMedicine(
      const AddDraft(name: 'Lisinopril', supply: '60'),
    );
    await notifier.addMedicine(
      const AddDraft(name: 'Metoprolol', supply: 'not a number'),
    );

    final data = (await repo.loadAll()).getOrElse((_) => throw StateError('x'));
    final withCount = data.meds.singleWhere((m) => m.name == 'Lisinopril');
    expect(data.supplyOf(withCount.id), 60);

    // Blank/invalid input is not silently defaulted — the medicine isn't
    // added at all, same as an empty name.
    expect(data.meds.any((m) => m.name == 'Metoprolol'), isFalse);
  });

  test('refillMedicine updates the ledger-derived supply', () async {
    final med = _draftToMed(const AddDraft(name: 'Aspirin', dose: '100 mg'));
    await repo.addMedicine(med, 30);

    final container = ProviderContainer(
      overrides: [
        databaseProvider.overrideWithValue(db),
        talkerProvider.overrideWithValue(Talker()),
      ],
    );
    addTearDown(container.dispose);

    await container.read(dataProvider.future);
    final notifier = container.read(dataProvider.notifier);

    await notifier.refillMedicine(med.id, 45);

    final data = (await repo.loadAll()).getOrElse((_) => throw StateError('x'));
    expect(data.supplyOf(med.id), 45);
  });

  test('markTaken completing the day returns true', () async {
    await withFixedToday(() async {
      await seedTestMedicines(db);
      final container = ProviderContainer(
        overrides: [
          databaseProvider.overrideWithValue(db),
          talkerProvider.overrideWithValue(Talker()),
        ],
      );
      addTearDown(container.dispose);

      await container.read(dataProvider.future);
      final notifier = container.read(dataProvider.notifier);
      final iso = DayUtils.iso(kToday);

      // Seed state: only m1 is taken today. Marking m2/m3 keeps it partial.
      expect(await notifier.markTaken(iso, 'm2', 't1'), isFalse);
      expect(await notifier.markTaken(iso, 'm3', 't1'), isFalse);
      // The final dose completes the day.
      expect(await notifier.markTaken(iso, 'm4', 't1'), isTrue);
    });
  });

  test('markTaken consumes a pill; revertDose credits it back', () async {
    await withFixedToday(() async {
      await seedTestMedicines(db);
      final container = ProviderContainer(
        overrides: [
          databaseProvider.overrideWithValue(db),
          talkerProvider.overrideWithValue(Talker()),
        ],
      );
      addTearDown(container.dispose);

      await container.read(dataProvider.future);
      final notifier = container.read(dataProvider.notifier);
      final iso = DayUtils.iso(kToday);

      // m2 starts with supply 30 and no dose taken yet today.
      await notifier.markTaken(iso, 'm2', 't1');
      var data = (await repo.loadAll()).getOrElse((_) => throw StateError('x'));
      expect(data.supplyOf('m2'), 29);
      expect(data.isTaken(iso, 'm2', 't1'), isTrue);

      await notifier.revertDose(iso, 'm2', 't1');
      data = (await repo.loadAll()).getOrElse((_) => throw StateError('x'));
      expect(data.supplyOf('m2'), 30);
      expect(data.statusOf(iso, 'm2', 't1'), DoseStatus.pending);
    });
  });

  test('markTaken is a no-op when supply is 0', () async {
    await withFixedToday(() async {
      final med = Medicine(
        id: 'test-empty',
        name: 'EmptyStock',
        dose: '10 mg',
        times: const [
          DoseTime(id: 't1', time: '8:00 AM', period: Period.morning),
        ],
        withFood: false,
        kind: PillKind.round,
        c1: 0xFF5566D6,
        soft: 0xFFE7E8FB,
      );
      await repo.addMedicine(med, 0);

      final container = ProviderContainer(
        overrides: [
          databaseProvider.overrideWithValue(db),
          talkerProvider.overrideWithValue(Talker()),
        ],
      );
      addTearDown(container.dispose);

      await container.read(dataProvider.future);
      final notifier = container.read(dataProvider.notifier);
      final iso = DayUtils.iso(kToday);

      expect(await notifier.markTaken(iso, med.id, 't1'), isFalse);
      final data = (await repo.loadAll()).getOrElse(
        (_) => throw StateError('x'),
      );
      expect(data.statusOf(iso, med.id, 't1'), DoseStatus.pending);
      expect(data.supplyOf(med.id), 0);
    });
  });

  test('markRejected does not touch supply', () async {
    await withFixedToday(() async {
      await seedTestMedicines(db);
      final container = ProviderContainer(
        overrides: [
          databaseProvider.overrideWithValue(db),
          talkerProvider.overrideWithValue(Talker()),
        ],
      );
      addTearDown(container.dispose);

      await container.read(dataProvider.future);
      final notifier = container.read(dataProvider.notifier);
      final iso = DayUtils.iso(kToday);

      await notifier.markRejected(iso, 'm3', 't1');
      final data = (await repo.loadAll()).getOrElse(
        (_) => throw StateError('x'),
      );
      expect(data.supplyOf('m3'), 20);
      expect(data.statusOf(iso, 'm3', 't1'), DoseStatus.rejected);
      expect(data.isTaken(iso, 'm3', 't1'), isFalse);
    });
  });

  test(
    'refillMedicine logs a negative delta when correcting downward',
    () async {
      final med = _draftToMed(const AddDraft(name: 'Aspirin', dose: '100 mg'));
      await repo.addMedicine(med, 30); // supply starts at 30

      final container = ProviderContainer(
        overrides: [
          databaseProvider.overrideWithValue(db),
          talkerProvider.overrideWithValue(Talker()),
        ],
      );
      addTearDown(container.dispose);

      await container.read(dataProvider.future);
      final notifier = container.read(dataProvider.notifier);

      await notifier.refillMedicine(med.id, 20);

      final rows = await db.select(db.supplyTransactions).get();
      final correction = rows.singleWhere((r) => r.kind == 'refill');
      expect(correction.delta, -10);
    },
  );

  test('loadTransactions returns the ledger newest first', () async {
    final med = _draftToMed(const AddDraft(name: 'Aspirin', dose: '100 mg'));
    // Pinned, distinct timestamps so ordering is deterministic rather than
    // relying on both calls landing in different clock ticks.
    await withClock(Clock.fixed(DateTime(2026, 6, 1)), () async {
      await repo.addMedicine(med, 30); // logs an 'initial' transaction
    });
    await withClock(Clock.fixed(DateTime(2026, 6, 15)), () async {
      await repo.refillMedicine(med.id, 40); // logs a 'refill' transaction
    });

    final result = await repo.loadTransactions();
    final rows = result.getOrElse((_) => throw StateError('load failed'));

    expect(rows.map((r) => r.kind), ['refill', 'initial']);
  });
}

Medicine _draftToMed(AddDraft draft) => Medicine(
  id: 'test-${draft.name}',
  name: draft.name,
  dose: draft.dose,
  times: const [DoseTime(id: 't1', time: '8:00 AM', period: Period.morning)],
  withFood: draft.withFood,
  kind: PillKind.round,
  c1: 0xFF5566D6,
  soft: 0xFFE7E8FB,
);
