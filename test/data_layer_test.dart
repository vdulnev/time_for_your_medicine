import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:time_for_your_medicine/core/data/medicine_repository.dart';
import 'package:time_for_your_medicine/core/db/app_database.dart';
import 'package:time_for_your_medicine/core/logging/talker.dart';
import 'package:time_for_your_medicine/core/models/add_draft.dart';
import 'package:time_for_your_medicine/core/models/medicine.dart';
import 'package:time_for_your_medicine/core/models/pill_kind.dart';
import 'package:time_for_your_medicine/core/state/providers.dart';
import 'package:time_for_your_medicine/core/util/day_utils.dart';

void main() {
  late AppDatabase db;
  late MedicineRepository repo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = MedicineRepository(db, Talker());
  });

  tearDown(() => db.close());

  test('seeds four medicines on first load', () async {
    final result = await repo.loadAll();
    final data = result.getOrElse((_) => throw StateError('load failed'));
    expect(data.meds.length, 4);
    expect(data.meds.first.name, 'Metformin');
  });

  test('addMedicine persists a new row', () async {
    final med = _draftToMed(const AddDraft(name: 'Aspirin', dose: '100 mg'));
    await repo.addMedicine(med);
    final data = (await repo.loadAll()).getOrElse((_) => throw StateError('x'));
    expect(data.meds.any((m) => m.name == 'Aspirin'), isTrue);
  });

  test('deleteMedicine removes the med and its dose log', () async {
    await repo.deleteMedicine('m1');
    final data = (await repo.loadAll()).getOrElse((_) => throw StateError('x'));
    expect(data.meds.any((m) => m.id == 'm1'), isFalse);
    expect(data.taken.keys.any((k) => k.endsWith('|m1')), isFalse);
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

  test('toggleTaken completing the day returns true', () async {
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
    expect(await notifier.toggleTaken(iso, 'm2'), isFalse);
    expect(await notifier.toggleTaken(iso, 'm3'), isFalse);
    // The final dose completes the day.
    expect(await notifier.toggleTaken(iso, 'm4'), isTrue);
  });
}

Medicine _draftToMed(AddDraft draft) => Medicine(
  id: 'test-${draft.name}',
  name: draft.name,
  dose: draft.dose,
  period: draft.period,
  time: '8:00 AM',
  withFood: draft.withFood,
  kind: PillKind.round,
  c1: 0xFF5566D6,
  soft: 0xFFE7E8FB,
  supply: 30,
  cap: 30,
);
