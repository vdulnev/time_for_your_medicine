import 'package:intl/intl.dart';

/// Date helpers mirroring the design prototype's date logic.
///
/// All dates are handled as local `DateTime` at midnight; the canonical
/// serialized form is an ISO `yyyy-MM-dd` string. Display formatting is
/// locale-aware via `intl`; callers pass the current `BuildContext`'s
/// locale (see `AppLocalizations.localeName` / `Localizations.localeOf`).
abstract final class DayUtils {
  const DayUtils._();

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

  /// Two-letter Ukrainian weekday abbreviations, Mon…Sun. CLDR's "narrow"
  /// (single-letter) form isn't unique in Cyrillic — Пн/Пт and Ср/Сб both
  /// collapse to the same glyph — so this locale uses a fixed short form
  /// instead of `DateFormat('EEEEE', ...)`.
  static const List<String> _ukShortWeekdays = [
    'Пн',
    'Вт',
    'Ср',
    'Чт',
    'Пт',
    'Сб',
    'Нд',
  ];

  /// Narrow weekday glyph for compact UI (single letter in English, e.g.
  /// "M"; a short, unambiguous abbreviation for locales where CLDR's
  /// narrow form collides, e.g. Ukrainian "Пн").
  static String dowNarrow(DateTime d, String locale) {
    if (locale == 'uk') return _ukShortWeekdays[mondayIndex(d)];
    return DateFormat('EEEEE', locale).format(d);
  }

  /// Full weekday, e.g. "Monday" / "вівторок".
  static String weekdayFull(DateTime d, String locale) =>
      DateFormat.EEEE(locale).format(d);

  /// Month + day label, e.g. "June 30" / "30 червня".
  static String dateLabel(DateTime d, String locale) =>
      DateFormat.MMMMd(locale).format(d);

  /// Month + year label, e.g. "June 2026" / "червень 2026".
  static String monthLabel(int year, int month, String locale) =>
      DateFormat.yMMMM(locale).format(DateTime(year, month));

  /// Monday-based weekday index (Mon = 0 … Sun = 6).
  static int mondayIndex(DateTime d) => (d.weekday + 6) % 7;
}
