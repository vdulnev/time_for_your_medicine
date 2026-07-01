import 'package:flutter/material.dart';

/// A time-of-day grouping for medicines.
enum Period {
  morning(Color(0xFFD69A5A), Color(0xFFFBF0DF)),
  afternoon(Color(0xFF5AA0D6), Color(0xFFE2F0F8)),
  evening(Color(0xFFA77FD0), Color(0xFFF1ECF9));

  const Period(this.accent, this.bg);

  /// Accent color for dots / times.
  final Color accent;

  /// Soft background tint for the period icon.
  final Color bg;

  static Period fromName(String name) {
    return Period.values.firstWhere(
      (p) => p.name == name,
      orElse: () => Period.morning,
    );
  }
}

/// Ordered periods used to lay out the day.
const List<Period> kPeriodOrder = [
  Period.morning,
  Period.afternoon,
  Period.evening,
];
