/// Date helpers mirroring the design prototype's date logic.
///
/// All dates are handled as local `DateTime` at midnight; the canonical
/// serialized form is an ISO `yyyy-MM-dd` string.
abstract final class DayUtils {
  const DayUtils._();

  static const List<String> monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  static const List<String> _dowShort = [
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
  ];

  static const List<String> _weekdayFull = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  static String iso(DateTime d) {
    final m = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    return '${d.year}-$m-$day';
  }

  static DateTime parse(String s) {
    final p = s.split('-');
    return DateTime(int.parse(p[0]), int.parse(p[1]), int.parse(p[2]));
  }

  static DateTime addDays(DateTime d, int n) =>
      DateTime(d.year, d.month, d.day + n);

  /// Three-letter weekday, e.g. "Mon".
  static String dow(DateTime d) => _dowShort[d.weekday % 7];

  /// Full weekday, e.g. "Monday".
  static String weekdayFull(DateTime d) => _weekdayFull[d.weekday % 7];

  /// Month + day label, e.g. "June 30".
  static String dateLabel(DateTime d) => '${monthNames[d.month - 1]} ${d.day}';

  /// Month + year label, e.g. "June 2026".
  static String monthLabel(int year, int month) =>
      '${monthNames[month - 1]} $year';

  /// Monday-based weekday index (Mon = 0 … Sun = 6).
  static int mondayIndex(DateTime d) => (d.weekday + 6) % 7;
}
