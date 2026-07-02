import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../db/app_database.dart' show SupplyTransactionRow, kToday;
import '../models/dose_status.dart';
import '../models/dose_time.dart';
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

/// A single scheduled dose of a medicine — the pairing of a [Medicine] with
/// one of its [DoseTime] slots. Medicines taken several times a day appear
/// as multiple occurrences, one per slot.
class DoseOccurrence {
  const DoseOccurrence({required this.med, required this.doseTime});
  final Medicine med;
  final DoseTime doseTime;

  String get time => doseTime.time;
  Period get period => doseTime.period;
}

class PeriodSection {
  const PeriodSection({
    required this.period,
    required this.time,
    required this.occurrences,
  });
  final Period period;
  final String time;
  final List<DoseOccurrence> occurrences;
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

/// One of a medicine's dose slots, with its status for a given day.
class MedDoseStatus {
  const MedDoseStatus({required this.doseTime, required this.status});
  final DoseTime doseTime;
  final DoseStatus status;
}

/// Trailing-window presets for the transactions screen's interval filter.
enum TransactionInterval {
  all,
  last7Days,
  last30Days,
  last90Days;

  /// Inclusive cutoff: a transaction at or after this instant matches.
  /// `null` for [all] (no lower bound).
  DateTime? cutoff(DateTime today) => switch (this) {
    TransactionInterval.all => null,
    TransactionInterval.last7Days => DayUtils.addDays(today, -6),
    TransactionInterval.last30Days => DayUtils.addDays(today, -29),
    TransactionInterval.last90Days => DayUtils.addDays(today, -89),
  };
}

/// A ledger row paired with its medicine's display name (`null` if the
/// medicine was since deleted — the ledger keeps its rows regardless).
class TransactionEntry {
  const TransactionEntry({required this.row, required this.medName});
  final SupplyTransactionRow row;
  final String? medName;
}

abstract final class Selectors {
  const Selectors._();

  static String _stripMeridiem(String t) =>
      t.replaceAll(' AM', '').replaceAll(' PM', '');

  /// Every (medicine, doseTime) occurrence, flattened across all medicines.
  static List<DoseOccurrence> _occurrences(DataState data) => [
    for (final m in data.meds)
      for (final t in m.times) DoseOccurrence(med: m, doseTime: t),
  ];

  static List<PeriodSection> periods(DataState data) {
    final all = _occurrences(data);
    final out = <PeriodSection>[];
    for (final k in kPeriodOrder) {
      final list = all.where((o) => o.period == k).toList();
      if (list.isEmpty) continue;
      out.add(
        PeriodSection(period: k, time: list.first.time, occurrences: list),
      );
    }
    return out;
  }

  static DoseProgress progress(DataState data, String iso) {
    final occurrences = _occurrences(data);
    final total = occurrences.length;
    final taken = occurrences
        .where((o) => data.isTaken(iso, o.med.id, o.doseTime.id))
        .length;
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
    final byTime = <String, List<DoseOccurrence>>{};
    for (final o in _occurrences(data)) {
      byTime.putIfAbsent(o.time, () => []).add(o);
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
          names: byTime[t]?.map((o) => o.med.name).join(', ') ?? '',
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

  /// A medicine's own dose count and taken count for [iso] (all its slots
  /// count, so a 3x/day medicine contributes up to 3).
  static (int taken, int total) _medDoseCount(
    DataState data,
    Medicine med,
    String iso,
  ) {
    final total = med.times.length;
    final taken = med.times
        .where((t) => data.isTaken(iso, med.id, t.id))
        .length;
    return (taken, total);
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
          final (taken, total) = _medDoseCount(data, med, DayUtils.iso(d));
          return DetailDay(
            initial: DayUtils.dowNarrow(d, locale),
            done: total > 0 && taken == total,
            isSelectedDay: off == 0,
          );
        }(),
    ];
  }

  /// Today's scheduled dose slots for [med], each with its status.
  static List<MedDoseStatus> medDosesForDay(
    DataState data,
    Medicine med,
    String iso,
  ) => [
    for (final t in med.times)
      MedDoseStatus(doseTime: t, status: data.statusOf(iso, med.id, t.id)),
  ];

  /// The earliest not-yet-taken dose time today, falling back to the first
  /// slot once all are taken. Suffixed with a "+N" count when there's more
  /// than one dose slot, so multi-dose-per-day medicines stay disambiguated.
  static String nextDoseLabel(DataState data, Medicine med, String iso) {
    final untaken = med.times.where((t) => !data.isTaken(iso, med.id, t.id));
    final target = untaken.isNotEmpty ? untaken.first : med.times.first;
    final stripped = _stripMeridiem(target.time);
    return med.times.length > 1
        ? '$stripped +${med.times.length - 1}'
        : stripped;
  }

  static HistorySummary history(
    DataState data,
    String selectedIso,
    String locale,
  ) {
    final total = _occurrences(data).length;
    final bars = <HistoryBar>[
      for (final off in const [6, 5, 4, 3, 2, 1, 0])
        () {
          final d = DayUtils.addDays(kToday, -off);
          final iso = DayUtils.iso(d);
          final count = _occurrences(
            data,
          ).where((o) => data.isTaken(iso, o.med.id, o.doseTime.id)).length;
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
    final takenToday = data.allTaken(selectedIso);
    var count = 0;
    for (var off = takenToday ? 0 : 1; off < 30; off++) {
      final iso = DayUtils.iso(DayUtils.addDays(kToday, -off));
      if (data.meds.isNotEmpty && data.allTaken(iso)) {
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

  /// [rows] joined with each medicine's name and narrowed to [medId] (when
  /// set) and [interval], newest first (the input order, since callers
  /// already load the ledger sorted by `createdAt desc`).
  static List<TransactionEntry> transactions(
    List<SupplyTransactionRow> rows,
    DataState data, {
    String? medId,
    TransactionInterval interval = TransactionInterval.all,
  }) {
    final namesById = {for (final m in data.meds) m.id: m.name};
    final cutoff = interval.cutoff(kToday);
    return [
      for (final r in rows)
        if ((medId == null || r.medId == medId) &&
            (cutoff == null || !r.createdAt.isBefore(cutoff)))
          TransactionEntry(row: r, medName: namesById[r.medId]),
    ];
  }
}
