import 'package:freezed_annotation/freezed_annotation.dart';

import 'period.dart';
import 'pill_kind.dart';

part 'medicine.freezed.dart';
part 'medicine.g.dart';

/// A single medicine / reminder.
@freezed
abstract class Medicine with _$Medicine {
  const Medicine._();

  const factory Medicine({
    required String id,
    required String name,
    required String dose,
    required Period period,

    /// Display time, e.g. "8:00 AM".
    required String time,
    required bool withFood,
    required PillKind kind,

    /// Primary pill color (ARGB int).
    required int c1,

    /// Soft background tint behind the pill thumbnail (ARGB int).
    required int soft,

    /// Remaining supply and full capacity, for refills.
    required int supply,
    required int cap,

    /// Secondary pill color for capsules (ARGB int).
    int? c2,
  }) = _Medicine;

  factory Medicine.fromJson(Map<String, dynamic> json) =>
      _$MedicineFromJson(json);

  bool get isLowSupply => supply <= 7;
}
