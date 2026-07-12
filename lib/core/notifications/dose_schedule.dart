import '../models/dose_status.dart';
import '../state/data_state.dart';
import '../util/day_utils.dart';

/// One dose slot's notification schedule: fires daily at [hour]:[minute],
/// starting from [firstFire].
class DoseSchedule {
  const DoseSchedule({
    required this.medId,
    required this.doseTimeId,
    required this.medName,
    required this.dose,
    required this.displayTime,
    required this.hour,
    required this.minute,
    required this.firstFire,
  });

  final String medId;
  final String doseTimeId;
  final String medName;
  final String dose;

  /// The slot's display time as entered ("8:00 AM") — shown in the
  /// notification body even when [hour]/[minute] came from the period
  /// fallback.
  final String displayTime;
  final int hour;
  final int minute;

  /// The first instant the daily-repeating notification fires: today at
  /// [hour]:[minute] if that's still ahead and today's dose is pending,
  /// otherwise tomorrow — a dose already taken (or rejected) before its
  /// time shouldn't ring today.
  final DateTime firstFire;
}

/// Every notification to schedule for [data] as of [now]: one per dose
/// slot of every reminder-enabled medicine. Slots whose free-text time
/// doesn't parse fall back to their period's default clock time.
List<DoseSchedule> buildDoseSchedules(DataState data, DateTime now) {
  final iso = DayUtils.iso(now);
  final out = <DoseSchedule>[];
  for (final med in data.meds) {
    if (!data.reminderOn(med.id)) continue;
    for (final slot in med.times) {
      final (hour, minute) =
          DayUtils.parseDisplayTime(slot.time) ??
          DayUtils.parseDisplayTime(slot.period.defaultDisplayTime)!;
      final todayAt = DateTime(now.year, now.month, now.day, hour, minute);
      final pendingToday =
          data.statusOf(iso, med.id, slot.id) == DoseStatus.pending;
      final firstFire = todayAt.isAfter(now) && pendingToday
          ? todayAt
          : DateTime(now.year, now.month, now.day + 1, hour, minute);
      out.add(
        DoseSchedule(
          medId: med.id,
          doseTimeId: slot.id,
          medName: med.name,
          dose: med.dose,
          displayTime: slot.time,
          hour: hour,
          minute: minute,
          firstFire: firstFire,
        ),
      );
    }
  }
  return out;
}
