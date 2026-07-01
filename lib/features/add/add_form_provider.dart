import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/add_draft.dart';
import '../../core/models/period.dart';

/// Page-scoped draft for the Add-medicine form. Auto-disposed when the page
/// leaves the stack, so each open starts blank.
class AddFormNotifier extends AutoDisposeNotifier<AddDraft> {
  @override
  AddDraft build() => const AddDraft();

  void setName(String value) => state = state.copyWith(name: value);
  void setDose(String value) => state = state.copyWith(dose: value);
  void setTime(String value) => state = state.copyWith(time: value);
  void setPeriod(Period period) => state = state.copyWith(period: period);
  void setFood(bool withFood) => state = state.copyWith(withFood: withFood);
}

final addFormProvider = AutoDisposeNotifierProvider<AddFormNotifier, AddDraft>(
  AddFormNotifier.new,
);
