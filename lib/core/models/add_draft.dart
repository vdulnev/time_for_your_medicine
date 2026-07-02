import 'package:freezed_annotation/freezed_annotation.dart';

import 'period.dart';

part 'add_draft.freezed.dart';

/// One editable time slot in the "Add medicine" form.
@freezed
abstract class DraftTime with _$DraftTime {
  const factory DraftTime({
    @Default('') String time,
    @Default(Period.morning) Period period,
  }) = _DraftTime;
}

/// Draft state for the "Add medicine" form. Not persisted, so no JSON.
@freezed
abstract class AddDraft with _$AddDraft {
  const factory AddDraft({
    @Default('') String name,
    @Default('') String dose,

    /// How many pills the user has on hand right now. Free text so the
    /// field behaves like `dose`/`name`; parsed (and defaulted) on save.
    @Default('') String supply,
    @Default(<DraftTime>[]) List<DraftTime> times,
    @Default(true) bool withFood,
  }) = _AddDraft;
}
