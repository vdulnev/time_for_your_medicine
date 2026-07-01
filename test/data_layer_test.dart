import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:time_for_your_medicine/core/data/medicine_repository.dart';
import 'package:time_for_your_medicine/core/db/app_database.dart';
import 'package:time_for_your_medicine/core/logging/talker.dart';
import 'package:time_for_your_medicine/core/models/add_draft.dart';
import 'package:time_for_your_medicine/core/models/dose_time.dart';
import 'package:time_for_your_medicine/core/models/medicine.dart';
import 'package:time_for_your_medicine/core/models/period.dart';
import 'package:time_for_your_medicine/core/models/pill_kind.dart';
import 'package:time_for_your_medicine/core/state/providers.dart';
import 'package:time_for_your_medicine/core/util/day_utils.dart';

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
    expect(data.taken, isEmpty);
  });

  test('addMedicine persists a new row', () async {
    final med = _draftToMed(const AddDraft(name: 'Aspirin', dose: '100 mg'));
    await repo.addMedicine(med);
    final data = (await repo.loadAll()).getOrElse((_) => throw StateError('x'));
    expect(data.meds.any((m) => m.name == 'Aspirin'), isTrue);
  });

  test('deleteMedicine removes the med and its dose log', () async {
    final med = _draftToMed(const AddDraft(name: 'Aspirin', dose: '100 mg'));
    await repo.addMedicine(med);
    await repo.setTaken(DayUtils.iso(kToday), med.id, med.times.first.id, true);
    await repo.deleteMedicine(med.id);
    final data = (await repo.loadAll()).getOrElse((_) => throw StateError('x'));
    expect(data.meds.any((m) => m.id == med.id), isFalse);
    expect(data.taken.keys.any((k) => k.split('|')[1] == med.id), isFalse);
  });

  test('addMedicine persists multiple dose times a day', () async {
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
      supply: 30,
      cap: 30,
    );
    await repo.addMedicine(med);
    final data = (await repo.loadAll()).getOrElse((_) => throw StateError('x'));
    final loaded = data.meds.firstWhere((m) => m.id == med.id);
    expect(loaded.times, hasLength(3));

    await repo.setTaken(DayUtils.iso(kToday), med.id, 't0', true);
    final afterOneToggle = (await repo.loadAll()).getOrElse(
      (_) => throw StateError('x'),
    );
    expect(afterOneToggle.isTaken(DayUtils.iso(kToday), med.id, 't0'), isTrue);
    expect(afterOneToggle.isTaken(DayUtils.iso(kToday), med.id, 't1'), isFalse);
  });

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

  test('toggleTaken completing the day returns true', () async {
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

    // Seed state: only m1 is taken today. Toggling m2 and m3 keeps it partial.
    expect(await notifier.toggleTaken(iso, 'm2', 't1'), isFalse);
    expect(await notifier.toggleTaken(iso, 'm3', 't1'), isFalse);
    // The final dose completes the day.
    expect(await notifier.toggleTaken(iso, 'm4', 't1'), isTrue);
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
  supply: 30,
  cap: 30,
);
