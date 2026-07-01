import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/add_draft.dart';
import '../../core/models/period.dart';

/// Page-scoped draft for the Add-medicine form. Auto-disposed when the page
/// leaves the stack, so each open starts blank.
class AddFormNotifier extends AutoDisposeNotifier<AddDraft> {
  @override
  AddDraft build() => const AddDraft(times: [DraftTime()]);

  void setName(String value) => state = state.copyWith(name: value);
  void setDose(String value) => state = state.copyWith(dose: value);
  void setFood(bool withFood) => state = state.copyWith(withFood: withFood);

  void setTimeAt(int index, String value) {
    final times = [...state.times];
    times[index] = times[index].copyWith(time: value);
    state = state.copyWith(times: times);
  }

  void setPeriodAt(int index, Period period) {
    final times = [...state.times];
    times[index] = times[index].copyWith(period: period);
    state = state.copyWith(times: times);
  }

  void addTimeSlot() =>
      state = state.copyWith(times: [...state.times, const DraftTime()]);

  void removeTimeSlotAt(int index) {
    if (state.times.length <= 1) return;
    final times = [...state.times]..removeAt(index);
    state = state.copyWith(times: times);
  }
}

final addFormProvider = AutoDisposeNotifierProvider<AddFormNotifier, AddDraft>(
  AddFormNotifier.new,
);
