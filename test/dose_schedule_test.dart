import 'package:flutter_test/flutter_test.dart';
import 'package:time_for_your_medicine/core/models/app_settings.dart';
import 'package:time_for_your_medicine/core/models/dose_status.dart';
import 'package:time_for_your_medicine/core/models/dose_time.dart';
import 'package:time_for_your_medicine/core/models/medicine.dart';
import 'package:time_for_your_medicine/core/models/period.dart';
import 'package:time_for_your_medicine/core/models/pill_kind.dart';
import 'package:time_for_your_medicine/core/notifications/dose_schedule.dart';
import 'package:time_for_your_medicine/core/state/data_state.dart';

/// The pure scheduling logic behind OS dose notifications: which slots get
/// one, at what clock time, and whether the first instance is today or
/// tomorrow (a dose already handled before its time must not ring today).
void main() {
  Medicine med({
    String id = 'm1',
    List<DoseTime> times = const [
      DoseTime(id: 't1', time: '8:00 AM', period: Period.morning),
    ],
  }) => Medicine(
    id: id,
    name: 'Aspirin',
    dose: '100 mg',
    times: times,
    withFood: false,
    kind: PillKind.round,
    c1: 0xFF5566D6,
    soft: 0xFFE7E8FB,
  );

  DataState stateWith({
    required List<Medicine> meds,
    Map<String, DoseStatus> doseStatus = const {},
    Map<String, bool> notifOff = const {},
  }) => DataState(
    meds: meds,
    doseStatus: doseStatus,
    settings: const AppSettings(),
    notifOff: notifOff,
    supplyByMedId: const {'m1': 30, 'm2': 30},
  );

  // 7:00 AM on 2026-07-10 — one hour before the default morning slot.
  final morning = DateTime(2026, 7, 10, 7, 0);

  test('a pending slot later today fires today at its parsed time', () {
    final schedules = buildDoseSchedules(stateWith(meds: [med()]), morning);
    final s = schedules.single;
    expect((s.hour, s.minute), (8, 0));
    expect(s.firstFire, DateTime(2026, 7, 10, 8, 0));
  });

  test('a slot whose time already passed fires tomorrow', () {
    final afternoon = DateTime(2026, 7, 10, 14, 0);
    final schedules = buildDoseSchedules(stateWith(meds: [med()]), afternoon);
    expect(schedules.single.firstFire, DateTime(2026, 7, 11, 8, 0));
  });

  test('a dose already taken before its time skips today', () {
    final schedules = buildDoseSchedules(
      stateWith(
        meds: [med()],
        doseStatus: const {'2026-07-10|m1|t1': DoseStatus.taken},
      ),
      morning,
    );
    expect(schedules.single.firstFire, DateTime(2026, 7, 11, 8, 0));
  });

  test('a rejected dose skips today the same as a taken one', () {
    final schedules = buildDoseSchedules(
      stateWith(
        meds: [med()],
        doseStatus: const {'2026-07-10|m1|t1': DoseStatus.rejected},
      ),
      morning,
    );
    expect(schedules.single.firstFire, DateTime(2026, 7, 11, 8, 0));
  });

  test('a reminder-off medicine gets no schedules at all', () {
    final schedules = buildDoseSchedules(
      stateWith(
        meds: [
          med(),
          med(id: 'm2'),
        ],
        notifOff: const {'m1': true},
      ),
      morning,
    );
    expect(schedules.map((s) => s.medId), ['m2']);
  });

  test('an unparseable free-text time falls back to the period default', () {
    final schedules = buildDoseSchedules(
      stateWith(
        meds: [
          med(
            times: const [
              DoseTime(id: 't1', time: 'after dinner', period: Period.evening),
            ],
          ),
        ],
      ),
      morning,
    );
    final s = schedules.single;
    expect((s.hour, s.minute), (21, 0)); // Period.evening default, 9:00 PM
    expect(s.displayTime, 'after dinner'); // body still shows what was typed
  });

  test('every slot of a multi-dose medicine gets its own schedule', () {
    final schedules = buildDoseSchedules(
      stateWith(
        meds: [
          med(
            times: const [
              DoseTime(id: 't1', time: '8:00 AM', period: Period.morning),
              DoseTime(id: 't2', time: '9:00 PM', period: Period.evening),
            ],
          ),
        ],
        // Morning already taken; evening still pending.
        doseStatus: const {'2026-07-10|m1|t1': DoseStatus.taken},
      ),
      morning,
    );
    expect(schedules, hasLength(2));
    expect(schedules[0].firstFire, DateTime(2026, 7, 11, 8, 0));
    expect(schedules[1].firstFire, DateTime(2026, 7, 10, 21, 0));
  });
}
