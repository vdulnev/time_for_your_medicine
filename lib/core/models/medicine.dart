import 'package:freezed_annotation/freezed_annotation.dart';

import 'dose_time.dart';
import 'pill_kind.dart';

part 'medicine.freezed.dart';
part 'medicine.g.dart';

/// A single medicine / reminder. May be taken several times a day, one
/// [DoseTime] per scheduled slot.
@freezed
abstract class Medicine with _$Medicine {
  const Medicine._();

  const factory Medicine({
    required String id,
    required String name,
    required String dose,

    /// Scheduled dose slots for the day, in the order they were added.
    /// Always non-empty.
    required List<DoseTime> times,
    required bool withFood,
    required PillKind kind,

    /// Primary pill color (ARGB int).
    required int c1,

    /// Soft background tint behind the pill thumbnail (ARGB int).
    required int soft,

    /// Secondary pill color for capsules (ARGB int).
    int? c2,
  }) = _Medicine;

  factory Medicine.fromJson(Map<String, dynamic> json) =>
      _$MedicineFromJson(json);
}
