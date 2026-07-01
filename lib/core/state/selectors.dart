import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../db/app_database.dart' show kToday;
import '../models/medicine.dart';
import '../models/period.dart';
import '../util/day_utils.dart';
import 'data_state.dart';

/// Pure, testable derivations of view data from [DataState]. Widgets call
/// these rather than computing anything themselves.
///
/// These stay locale-agnostic where possible; where a locale-dependent
/// label is unavoidable (weekday glyphs), it's threaded in as a plain
/// `String` language code rather than a `BuildContext`, so this file has
/// no UI/l10n dependency.

class PeriodSection {
  const PeriodSection({
    required this.period,
    required this.time,
    required this.meds,
  });
  final Period period;
  final String time;
  final List<Medicine> meds;
}

class DoseProgress {
  const DoseProgress({
    required this.taken,
    required this.total,
    required this.pct,
    required this.left,
  });
  final int taken;
  final int total;
  final int pct;
  final int left;

  String get fraction => '$taken/$total';
}

class WeekDay {
  const WeekDay({
    required this.initial,
    required this.day,
    required this.iso,
    required this.active,
  });
  final String initial;
  final int day;
  final String iso;
  final bool active;
}

class CalCell {
  const CalCell({
    required this.blank,
    required this.day,
    required this.iso,
    required this.selected,
    required this.isToday,
  });
  const CalCell.blank()
    : blank = true,
      day = 0,
      iso = '',
      selected = false,
      isToday = false;
  final bool blank;
  final int day;
  final String iso;
  final bool selected;
  final bool isToday;

  bool get showDot => !blank && !selected;
}

class AgendaEntry {
  const AgendaEntry({
    required this.time,
    required this.names,
    required this.accent,
  });
  final String time;
  final String names;
  final Color accent;
}

class DetailDay {
  const DetailDay({
    required this.initial,
    required this.done,
    required this.isSelectedDay,
  });
  final String initial;
  final bool done;
  final bool isSelectedDay;
}

class HistoryBar {
  const HistoryBar({
    required this.initial,
    required this.heightPct,
    required this.full,
    required this.partial,
  });
  final String initial;
  final int heightPct; // 8..100
  final bool full;
  final bool partial;
}

class HistorySummary {
  const HistorySummary({
    required this.bars,
    required this.adherence,
    required this.streak,
    required this.fullDays,
  });
  final List<HistoryBar> bars;
  final int adherence;
  final int streak;
  final int fullDays;

  bool get isExcellent => adherence >= 90;
}

class RefillItem {
  const RefillItem({required this.med, required this.low, required this.pct});
  final Medicine med;
  final bool low;
  final int pct;
}

abstract final class Selectors {
  const Selectors._();

  static String _stripMeridiem(String t) =>
      t.replaceAll(' AM', '').replaceAll(' PM', '');

  static List<PeriodSection> periods(DataState data) {
    final out = <PeriodSection>[];
    for (final k in kPeriodOrder) {
      final list = data.meds.where((m) => m.period == k).toList();
      if (list.isEmpty) continue;
      out.add(PeriodSection(period: k, time: list.first.time, meds: list));
    }
    return out;
  }

  static DoseProgress progress(DataState data, String iso) {
    final total = data.meds.length;
    final taken = data.meds.where((m) => data.isTaken(iso, m.id)).length;
    final pct = total == 0 ? 0 : (taken / total * 100).round();
    return DoseProgress(
      taken: taken,
      total: total,
      pct: pct,
      left: total - taken,
    );
  }

  static List<WeekDay> weekStrip(String iso, String locale) {
    final cur = DayUtils.parse(iso);
    final monday = DayUtils.addDays(cur, -DayUtils.mondayIndex(cur));
    return [
      for (var i = 0; i < 7; i++)
        () {
          final d = DayUtils.addDays(monday, i);
          final dIso = DayUtils.iso(d);
          return WeekDay(
            initial: DayUtils.dowNarrow(d, locale),
            day: d.day,
            iso: dIso,
            active: dIso == iso,
          );
        }(),
    ];
  }

  static List<CalCell> calendarCells(String selectedIso, int year, int month) {
    final first = DateTime(year, month, 1);
    final lead = DayUtils.mondayIndex(first);
    final daysInMonth = DateTime(year, month + 1, 0).day;
    final todayIso = DayUtils.iso(kToday);
    return [
      for (var i = 0; i < lead; i++) const CalCell.blank(),
      for (var day = 1; day <= daysInMonth; day++)
        () {
          final iso = DayUtils.iso(DateTime(year, month, day));
          return CalCell(
            blank: false,
            day: day,
            iso: iso,
            selected: iso == selectedIso,
            isToday: iso == todayIso,
          );
        }(),
    ];
  }

  static List<AgendaEntry> dayAgenda(DataState data) {
    final byTime = <String, List<Medicine>>{};
    for (final m in data.meds) {
      byTime.putIfAbsent(m.time, () => []).add(m);
    }
    const order = ['8:00 AM', '1:00 PM', '9:00 PM'];
    int rank(String t) {
      final i = order.indexOf(t);
      return i < 0 ? 99 : i;
    }

    final times = byTime.keys.toList()..sort((a, b) => rank(a) - rank(b));
    return [
      for (final t in times)
        AgendaEntry(
          time: _stripMeridiem(t),
          names: byTime[t]?.map((m) => m.name).join(', ') ?? '',
          accent: (byTime[t]?.first.period ?? Period.morning).accent,
        ),
    ];
  }

  /// The medicine matching [id], or the first medicine as a fallback.
  static Medicine? medById(DataState data, String? id) {
    if (data.meds.isEmpty) return null;
    for (final m in data.meds) {
      if (m.id == id) return m;
    }
    return data.meds.first;
  }

  static List<DetailDay> detailWeek(
    DataState data,
    Medicine med,
    String iso,
    String locale,
  ) {
    final cur = DayUtils.parse(iso);
    return [
      for (final off in const [6, 5, 4, 3, 2, 1, 0])
        () {
          final d = DayUtils.addDays(cur, -off);
          return DetailDay(
            initial: DayUtils.dowNarrow(d, locale),
            done: data.isTaken(DayUtils.iso(d), med.id),
            isSelectedDay: off == 0,
          );
        }(),
    ];
  }

  static HistorySummary history(
    DataState data,
    String selectedIso,
    String locale,
  ) {
    final total = data.meds.length;
    final bars = <HistoryBar>[
      for (final off in const [6, 5, 4, 3, 2, 1, 0])
        () {
          final d = DayUtils.addDays(kToday, -off);
          final iso = DayUtils.iso(d);
          final count = data.meds.where((m) => data.isTaken(iso, m.id)).length;
          final frac = total == 0 ? 0.0 : count / total;
          final h = math.max(8, (frac * 100).round());
          return HistoryBar(
            initial: DayUtils.dowNarrow(d, locale),
            heightPct: h,
            full: frac >= 1,
            partial: frac > 0 && frac < 1,
          );
        }(),
    ];
    final heights = bars.map((b) => b.heightPct).toList();
    final adherence = heights.isEmpty
        ? 0
        : (heights.reduce((a, b) => a + b) / heights.length).round();
    final fullDays = heights.where((v) => v >= 100).length;
    return HistorySummary(
      bars: bars,
      adherence: adherence,
      streak: streak(data, selectedIso),
      fullDays: fullDays,
    );
  }

  /// Consecutive fully-taken days, counting back from today.
  static int streak(DataState data, String selectedIso) {
    final total = data.meds.length;
    final takenToday = data.meds
        .where((m) => data.isTaken(selectedIso, m.id))
        .length;
    var count = 0;
    for (var off = (takenToday == total) ? 0 : 1; off < 30; off++) {
      final iso = DayUtils.iso(DayUtils.addDays(kToday, -off));
      final all = total > 0 && data.meds.every((m) => data.isTaken(iso, m.id));
      if (all) {
        count++;
      } else {
        break;
      }
    }
    return count;
  }

  static List<RefillItem> refills(DataState data) => [
    for (final m in data.meds)
      RefillItem(
        med: m,
        low: m.isLowSupply,
        pct: math.min(100, (m.supply / m.cap * 100).round()),
      ),
  ];

  static String lowSupplyName(DataState data) {
    for (final m in data.meds) {
      if (m.isLowSupply) return m.name;
    }
    return '';
  }
}
