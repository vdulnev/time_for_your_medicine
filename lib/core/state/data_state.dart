import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/app_settings.dart';
import '../models/dose_status.dart';
import '../models/medicine.dart';

part 'data_state.freezed.dart';

/// The persisted domain data, loaded from the database.
@freezed
abstract class DataState with _$DataState {
  const DataState._();

  const factory DataState({
    required List<Medicine> meds,

    /// Dose status keyed by `"iso|medId|doseTimeId"`. Absence means
    /// [DoseStatus.pending] (not yet touched).
    required Map<String, DoseStatus> doseStatus,
    required AppSettings settings,

    /// Per-medicine reminder-off flags (true == reminder disabled).
    required Map<String, bool> notifOff,
  }) = _DataState;

  DoseStatus statusOf(String iso, String medId, String doseTimeId) =>
      doseStatus['$iso|$medId|$doseTimeId'] ?? DoseStatus.pending;

  bool isTaken(String iso, String medId, String doseTimeId) =>
      statusOf(iso, medId, doseTimeId) == DoseStatus.taken;

  /// True when every scheduled dose of every medicine is taken for [iso].
  bool allTaken(String iso) =>
      meds.every((m) => m.times.every((t) => isTaken(iso, m.id, t.id)));

  bool reminderOn(String id) => !(notifOff[id] ?? false);
}
