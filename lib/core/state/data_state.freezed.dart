// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'data_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DataState {

 List<Medicine> get meds;/// Dose status keyed by `"iso|medId|doseTimeId"`. Absence means
/// [DoseStatus.pending] (not yet touched).
 Map<String, DoseStatus> get doseStatus; AppSettings get settings;/// Per-medicine reminder-off flags (true == reminder disabled).
 Map<String, bool> get notifOff;
/// Create a copy of DataState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DataStateCopyWith<DataState> get copyWith => _$DataStateCopyWithImpl<DataState>(this as DataState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DataState&&const DeepCollectionEquality().equals(other.meds, meds)&&const DeepCollectionEquality().equals(other.doseStatus, doseStatus)&&(identical(other.settings, settings) || other.settings == settings)&&const DeepCollectionEquality().equals(other.notifOff, notifOff));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(meds),const DeepCollectionEquality().hash(doseStatus),settings,const DeepCollectionEquality().hash(notifOff));

@override
String toString() {
  return 'DataState(meds: $meds, doseStatus: $doseStatus, settings: $settings, notifOff: $notifOff)';
}


}

/// @nodoc
abstract mixin class $DataStateCopyWith<$Res>  {
  factory $DataStateCopyWith(DataState value, $Res Function(DataState) _then) = _$DataStateCopyWithImpl;
@useResult
$Res call({
 List<Medicine> meds, Map<String, DoseStatus> doseStatus, AppSettings settings, Map<String, bool> notifOff
});


$AppSettingsCopyWith<$Res> get settings;

}
/// @nodoc
class _$DataStateCopyWithImpl<$Res>
    implements $DataStateCopyWith<$Res> {
  _$DataStateCopyWithImpl(this._self, this._then);

  final DataState _self;
  final $Res Function(DataState) _then;

/// Create a copy of DataState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? meds = null,Object? doseStatus = null,Object? settings = null,Object? notifOff = null,}) {
  return _then(_self.copyWith(
meds: null == meds ? _self.meds : meds // ignore: cast_nullable_to_non_nullable
as List<Medicine>,doseStatus: null == doseStatus ? _self.doseStatus : doseStatus // ignore: cast_nullable_to_non_nullable
as Map<String, DoseStatus>,settings: null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as AppSettings,notifOff: null == notifOff ? _self.notifOff : notifOff // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,
  ));
}
/// Create a copy of DataState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppSettingsCopyWith<$Res> get settings {
  
  return $AppSettingsCopyWith<$Res>(_self.settings, (value) {
    return _then(_self.copyWith(settings: value));
  });
}
}


/// Adds pattern-matching-related methods to [DataState].
extension DataStatePatterns on DataState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DataState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DataState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DataState value)  $default,){
final _that = this;
switch (_that) {
case _DataState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DataState value)?  $default,){
final _that = this;
switch (_that) {
case _DataState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Medicine> meds,  Map<String, DoseStatus> doseStatus,  AppSettings settings,  Map<String, bool> notifOff)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DataState() when $default != null:
return $default(_that.meds,_that.doseStatus,_that.settings,_that.notifOff);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Medicine> meds,  Map<String, DoseStatus> doseStatus,  AppSettings settings,  Map<String, bool> notifOff)  $default,) {final _that = this;
switch (_that) {
case _DataState():
return $default(_that.meds,_that.doseStatus,_that.settings,_that.notifOff);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Medicine> meds,  Map<String, DoseStatus> doseStatus,  AppSettings settings,  Map<String, bool> notifOff)?  $default,) {final _that = this;
switch (_that) {
case _DataState() when $default != null:
return $default(_that.meds,_that.doseStatus,_that.settings,_that.notifOff);case _:
  return null;

}
}

}

/// @nodoc


class _DataState extends DataState {
  const _DataState({required final  List<Medicine> meds, required final  Map<String, DoseStatus> doseStatus, required this.settings, required final  Map<String, bool> notifOff}): _meds = meds,_doseStatus = doseStatus,_notifOff = notifOff,super._();
  

 final  List<Medicine> _meds;
@override List<Medicine> get meds {
  if (_meds is EqualUnmodifiableListView) return _meds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_meds);
}

/// Dose status keyed by `"iso|medId|doseTimeId"`. Absence means
/// [DoseStatus.pending] (not yet touched).
 final  Map<String, DoseStatus> _doseStatus;
/// Dose status keyed by `"iso|medId|doseTimeId"`. Absence means
/// [DoseStatus.pending] (not yet touched).
@override Map<String, DoseStatus> get doseStatus {
  if (_doseStatus is EqualUnmodifiableMapView) return _doseStatus;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_doseStatus);
}

@override final  AppSettings settings;
/// Per-medicine reminder-off flags (true == reminder disabled).
 final  Map<String, bool> _notifOff;
/// Per-medicine reminder-off flags (true == reminder disabled).
@override Map<String, bool> get notifOff {
  if (_notifOff is EqualUnmodifiableMapView) return _notifOff;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_notifOff);
}


/// Create a copy of DataState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DataStateCopyWith<_DataState> get copyWith => __$DataStateCopyWithImpl<_DataState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DataState&&const DeepCollectionEquality().equals(other._meds, _meds)&&const DeepCollectionEquality().equals(other._doseStatus, _doseStatus)&&(identical(other.settings, settings) || other.settings == settings)&&const DeepCollectionEquality().equals(other._notifOff, _notifOff));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_meds),const DeepCollectionEquality().hash(_doseStatus),settings,const DeepCollectionEquality().hash(_notifOff));

@override
String toString() {
  return 'DataState(meds: $meds, doseStatus: $doseStatus, settings: $settings, notifOff: $notifOff)';
}


}

/// @nodoc
abstract mixin class _$DataStateCopyWith<$Res> implements $DataStateCopyWith<$Res> {
  factory _$DataStateCopyWith(_DataState value, $Res Function(_DataState) _then) = __$DataStateCopyWithImpl;
@override @useResult
$Res call({
 List<Medicine> meds, Map<String, DoseStatus> doseStatus, AppSettings settings, Map<String, bool> notifOff
});


@override $AppSettingsCopyWith<$Res> get settings;

}
/// @nodoc
class __$DataStateCopyWithImpl<$Res>
    implements _$DataStateCopyWith<$Res> {
  __$DataStateCopyWithImpl(this._self, this._then);

  final _DataState _self;
  final $Res Function(_DataState) _then;

/// Create a copy of DataState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? meds = null,Object? doseStatus = null,Object? settings = null,Object? notifOff = null,}) {
  return _then(_DataState(
meds: null == meds ? _self._meds : meds // ignore: cast_nullable_to_non_nullable
as List<Medicine>,doseStatus: null == doseStatus ? _self._doseStatus : doseStatus // ignore: cast_nullable_to_non_nullable
as Map<String, DoseStatus>,settings: null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as AppSettings,notifOff: null == notifOff ? _self._notifOff : notifOff // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,
  ));
}

/// Create a copy of DataState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppSettingsCopyWith<$Res> get settings {
  
  return $AppSettingsCopyWith<$Res>(_self.settings, (value) {
    return _then(_self.copyWith(settings: value));
  });
}
}

// dart format on
