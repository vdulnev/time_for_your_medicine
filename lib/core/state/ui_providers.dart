import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../db/app_database.dart';
import '../util/day_utils.dart';

/// The currently viewed day (ISO `yyyy-MM-dd`). Shared UI state, not persisted.
class SelectedDayNotifier extends Notifier<String> {
  @override
  String build() => DayUtils.iso(kToday);

  void set(String iso) => state = iso;

  void setDay(DateTime day) => state = DayUtils.iso(day);

  void shift(int days) {
    state = DayUtils.iso(DayUtils.addDays(DayUtils.parse(state), days));
  }
}

final selectedDayProvider = NotifierProvider<SelectedDayNotifier, String>(
  SelectedDayNotifier.new,
);

/// The month shown on the Calendar screen (year + 1-based month).
typedef CalendarMonth = ({int year, int month});

class CalendarMonthNotifier extends Notifier<CalendarMonth> {
  @override
  CalendarMonth build() => (year: kToday.year, month: kToday.month);

  void prev() {
    final month = state.month == 1 ? 12 : state.month - 1;
    final year = state.month == 1 ? state.year - 1 : state.year;
    state = (year: year, month: month);
  }

  void next() {
    final month = state.month == 12 ? 1 : state.month + 1;
    final year = state.month == 12 ? state.year + 1 : state.year;
    state = (year: year, month: month);
  }
}

final calendarMonthProvider =
    NotifierProvider<CalendarMonthNotifier, CalendarMonth>(
      CalendarMonthNotifier.new,
    );
