// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_draft.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AddDraft {

 String get name; String get dose; String get time; Period get period; bool get withFood;
/// Create a copy of AddDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddDraftCopyWith<AddDraft> get copyWith => _$AddDraftCopyWithImpl<AddDraft>(this as AddDraft, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddDraft&&(identical(other.name, name) || other.name == name)&&(identical(other.dose, dose) || other.dose == dose)&&(identical(other.time, time) || other.time == time)&&(identical(other.period, period) || other.period == period)&&(identical(other.withFood, withFood) || other.withFood == withFood));
}


@override
int get hashCode => Object.hash(runtimeType,name,dose,time,period,withFood);

@override
String toString() {
  return 'AddDraft(name: $name, dose: $dose, time: $time, period: $period, withFood: $withFood)';
}


}

/// @nodoc
abstract mixin class $AddDraftCopyWith<$Res>  {
  factory $AddDraftCopyWith(AddDraft value, $Res Function(AddDraft) _then) = _$AddDraftCopyWithImpl;
@useResult
$Res call({
 String name, String dose, String time, Period period, bool withFood
});




}
/// @nodoc
class _$AddDraftCopyWithImpl<$Res>
    implements $AddDraftCopyWith<$Res> {
  _$AddDraftCopyWithImpl(this._self, this._then);

  final AddDraft _self;
  final $Res Function(AddDraft) _then;

/// Create a copy of AddDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? dose = null,Object? time = null,Object? period = null,Object? withFood = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,dose: null == dose ? _self.dose : dose // ignore: cast_nullable_to_non_nullable
as String,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as Period,withFood: null == withFood ? _self.withFood : withFood // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AddDraft].
extension AddDraftPatterns on AddDraft {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AddDraft value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AddDraft() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AddDraft value)  $default,){
final _that = this;
switch (_that) {
case _AddDraft():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AddDraft value)?  $default,){
final _that = this;
switch (_that) {
case _AddDraft() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String dose,  String time,  Period period,  bool withFood)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AddDraft() when $default != null:
return $default(_that.name,_that.dose,_that.time,_that.period,_that.withFood);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String dose,  String time,  Period period,  bool withFood)  $default,) {final _that = this;
switch (_that) {
case _AddDraft():
return $default(_that.name,_that.dose,_that.time,_that.period,_that.withFood);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String dose,  String time,  Period period,  bool withFood)?  $default,) {final _that = this;
switch (_that) {
case _AddDraft() when $default != null:
return $default(_that.name,_that.dose,_that.time,_that.period,_that.withFood);case _:
  return null;

}
}

}

/// @nodoc


class _AddDraft implements AddDraft {
  const _AddDraft({this.name = '', this.dose = '', this.time = '', this.period = Period.morning, this.withFood = true});
  

@override@JsonKey() final  String name;
@override@JsonKey() final  String dose;
@override@JsonKey() final  String time;
@override@JsonKey() final  Period period;
@override@JsonKey() final  bool withFood;

/// Create a copy of AddDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddDraftCopyWith<_AddDraft> get copyWith => __$AddDraftCopyWithImpl<_AddDraft>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddDraft&&(identical(other.name, name) || other.name == name)&&(identical(other.dose, dose) || other.dose == dose)&&(identical(other.time, time) || other.time == time)&&(identical(other.period, period) || other.period == period)&&(identical(other.withFood, withFood) || other.withFood == withFood));
}


@override
int get hashCode => Object.hash(runtimeType,name,dose,time,period,withFood);

@override
String toString() {
  return 'AddDraft(name: $name, dose: $dose, time: $time, period: $period, withFood: $withFood)';
}


}

/// @nodoc
abstract mixin class _$AddDraftCopyWith<$Res> implements $AddDraftCopyWith<$Res> {
  factory _$AddDraftCopyWith(_AddDraft value, $Res Function(_AddDraft) _then) = __$AddDraftCopyWithImpl;
@override @useResult
$Res call({
 String name, String dose, String time, Period period, bool withFood
});




}
/// @nodoc
class __$AddDraftCopyWithImpl<$Res>
    implements _$AddDraftCopyWith<$Res> {
  __$AddDraftCopyWithImpl(this._self, this._then);

  final _AddDraft _self;
  final $Res Function(_AddDraft) _then;

/// Create a copy of AddDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? dose = null,Object? time = null,Object? period = null,Object? withFood = null,}) {
  return _then(_AddDraft(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,dose: null == dose ? _self.dose : dose // ignore: cast_nullable_to_non_nullable
as String,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as Period,withFood: null == withFood ? _self.withFood : withFood // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
