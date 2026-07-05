import 'package:flutter_test/flutter_test.dart';
import 'package:time_for_your_medicine/core/models/app_settings.dart';
import 'package:time_for_your_medicine/core/models/dose_status.dart';
import 'package:time_for_your_medicine/core/models/dose_time.dart';
import 'package:time_for_your_medicine/core/models/medicine.dart';
import 'package:time_for_your_medicine/core/models/period.dart';
import 'package:time_for_your_medicine/core/models/pill_kind.dart';
import 'package:time_for_your_medicine/core/state/data_state.dart';
import 'package:time_for_your_medicine/core/state/selectors.dart';

/// A medicine with its reminder switched off shouldn't appear in today's
/// dose surfaces (Home list, progress count, Calendar agenda) or block
/// the "all doses taken" celebration — but its data (Detail, Refills,
/// History) is untouched, since disabling a reminder mutes today's
/// tracking rather than deleting the medicine.
void main() {
  final aspirin = Medicine(
    id: 'm1',
    name: 'Aspirin',
    dose: '100 mg',
    times: const [DoseTime(id: 't1', time: '8:00 AM', period: Period.morning)],
    withFood: false,
    kind: PillKind.round,
    c1: 0xFF5566D6,
    soft: 0xFFE7E8FB,
  );
  final vitaminD = Medicine(
    id: 'm2',
    name: 'Vitamin D',
    dose: '1000 IU',
    times: const [DoseTime(id: 't1', time: '8:00 AM', period: Period.morning)],
    withFood: true,
    kind: PillKind.round,
    c1: 0xFFD69A5A,
    soft: 0xFFFBF0DF,
  );

  DataState stateWith({required bool vitaminDReminderOff}) => DataState(
    meds: [aspirin, vitaminD],
    doseStatus: const {},
    settings: const AppSettings(),
    notifOff: vitaminDReminderOff ? const {'m2': true} : const {},
    supplyByMedId: const {'m1': 30, 'm2': 60},
  );

  const iso = '2026-06-30';

  test('periods excludes a disabled-reminder medicine\'s doses', () {
    final withBoth = Selectors.periods(stateWith(vitaminDReminderOff: false));
    expect(withBoth.single.occurrences.map((o) => o.med.id), ['m1', 'm2']);

    final withOneDisabled = Selectors.periods(
      stateWith(vitaminDReminderOff: true),
    );
    expect(withOneDisabled.single.occurrences.map((o) => o.med.id), ['m1']);
  });

  test('progress total excludes a disabled-reminder medicine', () {
    final progress = Selectors.progress(
      stateWith(vitaminDReminderOff: true),
      iso,
    );
    expect(progress.total, 1);
  });

  test('dayAgenda excludes a disabled-reminder medicine', () {
    final agenda = Selectors.dayAgenda(stateWith(vitaminDReminderOff: true));
    expect(agenda.single.names, 'Aspirin');
  });

  test('allTaken ignores a disabled-reminder medicine\'s untaken doses', () {
    final data = stateWith(
      vitaminDReminderOff: true,
    ).copyWith(doseStatus: const {'2026-06-30|m1|t1': DoseStatus.taken});
    // Vitamin D (reminder off) has an untaken dose, but shouldn't block
    // the day from counting as fully taken.
    expect(data.allTaken(iso), isTrue);
  });

  test(
    'allTaken still requires every reminder-enabled medicine to be taken',
    () {
      final data = stateWith(
        vitaminDReminderOff: false,
      ).copyWith(doseStatus: const {'2026-06-30|m1|t1': DoseStatus.taken});
      expect(data.allTaken(iso), isFalse);
    },
  );

  test('refills are unaffected by a disabled reminder', () {
    final data = stateWith(vitaminDReminderOff: true);
    expect(Selectors.refills(data).map((r) => r.med.id), ['m1', 'm2']);
  });
}
