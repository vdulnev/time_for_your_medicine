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

    /// Taken flags keyed by `"iso|medId"`.
    required Map<String, bool> taken,
    required AppSettings settings,

    /// Per-medicine reminder-off flags (true == reminder disabled).
    required Map<String, bool> notifOff,
  }) = _DataState;

  bool isTaken(String iso, String id) => taken['$iso|$id'] ?? false;

  bool reminderOn(String id) => !(notifOff[id] ?? false);
}
