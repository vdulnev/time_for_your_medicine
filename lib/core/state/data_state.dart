import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/app_settings.dart';
import '../models/medicine.dart';

part 'data_state.freezed.dart';

/// The persisted domain data, loaded from the database.
@freezed
abstract class DataState with _$DataState {
  const DataState._();

  const factory DataState({
    required List<Medicine> meds,

    /// Taken flags keyed by `"iso|medId|doseTimeId"`.
    required Map<String, bool> taken,
    required AppSettings settings,

    /// Per-medicine reminder-off flags (true == reminder disabled).
    required Map<String, bool> notifOff,
  }) = _DataState;

  bool isTaken(String iso, String medId, String doseTimeId) =>
      taken['$iso|$medId|$doseTimeId'] ?? false;

  /// True when every scheduled dose of every medicine is taken for [iso].
  bool allTaken(String iso) =>
      meds.every((m) => m.times.every((t) => isTaken(iso, m.id, t.id)));

  bool reminderOn(String id) => !(notifOff[id] ?? false);
}
