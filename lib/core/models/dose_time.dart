import 'package:freezed_annotation/freezed_annotation.dart';

import 'period.dart';

part 'dose_time.freezed.dart';
part 'dose_time.g.dart';

/// A single scheduled dose slot for a [Medicine] (e.g. "8:00 AM, morning").
/// Medicines taken several times a day have one of these per time.
@freezed
abstract class DoseTime with _$DoseTime {
  const factory DoseTime({
    required String id,

    /// Display time, e.g. "8:00 AM".
    required String time,
    required Period period,
  }) = _DoseTime;

  factory DoseTime.fromJson(Map<String, dynamic> json) =>
      _$DoseTimeFromJson(json);
}
