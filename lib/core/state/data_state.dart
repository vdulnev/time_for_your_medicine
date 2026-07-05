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

    /// Each medicine's current pill count, derived from the
    /// `SupplyTransactions` ledger (see
    /// `MedicineRepository._supplyTotals`) — never stored on [Medicine]
    /// itself, since it changes with every take/refill.
    required Map<String, int> supplyByMedId,
  }) = _DataState;

  DoseStatus statusOf(String iso, String medId, String doseTimeId) =>
      doseStatus['$iso|$medId|$doseTimeId'] ?? DoseStatus.pending;

  int supplyOf(String medId) => supplyByMedId[medId] ?? 0;

  bool isLowSupply(String medId) => supplyOf(medId) <= 7;

  bool isTaken(String iso, String medId, String doseTimeId) =>
      statusOf(iso, medId, doseTimeId) == DoseStatus.taken;

  /// True when every scheduled dose of every *reminder-enabled* medicine
  /// is taken for [iso]. A medicine with its reminder off doesn't
  /// participate in today's tracking, so it can't block the "all taken"
  /// celebration.
  bool allTaken(String iso) => meds
      .where((m) => reminderOn(m.id))
      .every((m) => m.times.every((t) => isTaken(iso, m.id, t.id)));

  bool reminderOn(String id) => !(notifOff[id] ?? false);
}
