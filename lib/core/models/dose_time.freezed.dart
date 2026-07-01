// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dose_time.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DoseTime {

 String get id;/// Display time, e.g. "8:00 AM".
 String get time; Period get period;
/// Create a copy of DoseTime
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DoseTimeCopyWith<DoseTime> get copyWith => _$DoseTimeCopyWithImpl<DoseTime>(this as DoseTime, _$identity);

  /// Serializes this DoseTime to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DoseTime&&(identical(other.id, id) || other.id == id)&&(identical(other.time, time) || other.time == time)&&(identical(other.period, period) || other.period == period));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,time,period);

@override
String toString() {
  return 'DoseTime(id: $id, time: $time, period: $period)';
}


}

/// @nodoc
abstract mixin class $DoseTimeCopyWith<$Res>  {
  factory $DoseTimeCopyWith(DoseTime value, $Res Function(DoseTime) _then) = _$DoseTimeCopyWithImpl;
@useResult
$Res call({
 String id, String time, Period period
});




}
/// @nodoc
class _$DoseTimeCopyWithImpl<$Res>
    implements $DoseTimeCopyWith<$Res> {
  _$DoseTimeCopyWithImpl(this._self, this._then);

  final DoseTime _self;
  final $Res Function(DoseTime) _then;

/// Create a copy of DoseTime
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? time = null,Object? period = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as Period,
  ));
}

}


/// Adds pattern-matching-related methods to [DoseTime].
extension DoseTimePatterns on DoseTime {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DoseTime value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DoseTime() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DoseTime value)  $default,){
final _that = this;
switch (_that) {
case _DoseTime():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DoseTime value)?  $default,){
final _that = this;
switch (_that) {
case _DoseTime() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String time,  Period period)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DoseTime() when $default != null:
return $default(_that.id,_that.time,_that.period);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String time,  Period period)  $default,) {final _that = this;
switch (_that) {
case _DoseTime():
return $default(_that.id,_that.time,_that.period);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String time,  Period period)?  $default,) {final _that = this;
switch (_that) {
case _DoseTime() when $default != null:
return $default(_that.id,_that.time,_that.period);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DoseTime implements DoseTime {
  const _DoseTime({required this.id, required this.time, required this.period});
  factory _DoseTime.fromJson(Map<String, dynamic> json) => _$DoseTimeFromJson(json);

@override final  String id;
/// Display time, e.g. "8:00 AM".
@override final  String time;
@override final  Period period;

/// Create a copy of DoseTime
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DoseTimeCopyWith<_DoseTime> get copyWith => __$DoseTimeCopyWithImpl<_DoseTime>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DoseTimeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DoseTime&&(identical(other.id, id) || other.id == id)&&(identical(other.time, time) || other.time == time)&&(identical(other.period, period) || other.period == period));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,time,period);

@override
String toString() {
  return 'DoseTime(id: $id, time: $time, period: $period)';
}


}

/// @nodoc
abstract mixin class _$DoseTimeCopyWith<$Res> implements $DoseTimeCopyWith<$Res> {
  factory _$DoseTimeCopyWith(_DoseTime value, $Res Function(_DoseTime) _then) = __$DoseTimeCopyWithImpl;
@override @useResult
$Res call({
 String id, String time, Period period
});




}
/// @nodoc
class __$DoseTimeCopyWithImpl<$Res>
    implements _$DoseTimeCopyWith<$Res> {
  __$DoseTimeCopyWithImpl(this._self, this._then);

  final _DoseTime _self;
  final $Res Function(_DoseTime) _then;

/// Create a copy of DoseTime
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? time = null,Object? period = null,}) {
  return _then(_DoseTime(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as Period,
  ));
}


}

// dart format on
