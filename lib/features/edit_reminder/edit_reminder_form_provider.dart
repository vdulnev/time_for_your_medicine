import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/add_draft.dart';
import '../../core/models/period.dart';

/// Page-scoped draft of staged new reminder times for a single medicine,
/// keyed by `medId` so each Detail page's Edit Reminder screen gets its own
/// fresh draft. Existing times aren't part of this state — this screen only
/// ever adds.
class EditReminderFormNotifier
    extends AutoDisposeFamilyNotifier<List<DraftTime>, String> {
  @override
  List<DraftTime> build(String medId) => const [DraftTime()];

  void setTimeAt(int index, String value) {
    final times = [...state];
    times[index] = times[index].copyWith(time: value);
    state = times;
  }

  void setPeriodAt(int index, Period period) {
    final times = [...state];
    times[index] = times[index].copyWith(period: period);
    state = times;
  }

  void addTimeSlot() => state = [...state, const DraftTime()];

  void removeTimeSlotAt(int index) {
    if (state.length <= 1) return;
    state = [...state]..removeAt(index);
  }
}

final editReminderFormProvider =
    AutoDisposeNotifierProviderFamily<
      EditReminderFormNotifier,
      List<DraftTime>,
      String
    >(EditReminderFormNotifier.new);
