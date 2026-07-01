import 'package:freezed_annotation/freezed_annotation.dart';

import 'period.dart';

part 'add_draft.freezed.dart';

/// Draft state for the "Add medicine" form. Not persisted, so no JSON.
@freezed
abstract class AddDraft with _$AddDraft {
  const factory AddDraft({
    @Default('') String name,
    @Default('') String dose,
    @Default('') String time,
    @Default(Period.morning) Period period,
    @Default(true) bool withFood,
  }) = _AddDraft;
}
