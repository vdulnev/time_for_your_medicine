// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'medicine.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Medicine {

 String get id; String get name; String get dose;/// Scheduled dose slots for the day, in the order they were added.
/// Always non-empty.
 List<DoseTime> get times; bool get withFood; PillKind get kind;/// Primary pill color (ARGB int).
 int get c1;/// Soft background tint behind the pill thumbnail (ARGB int).
 int get soft;/// Secondary pill color for capsules (ARGB int).
 int? get c2;
/// Create a copy of Medicine
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MedicineCopyWith<Medicine> get copyWith => _$MedicineCopyWithImpl<Medicine>(this as Medicine, _$identity);

  /// Serializes this Medicine to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Medicine&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.dose, dose) || other.dose == dose)&&const DeepCollectionEquality().equals(other.times, times)&&(identical(other.withFood, withFood) || other.withFood == withFood)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.c1, c1) || other.c1 == c1)&&(identical(other.soft, soft) || other.soft == soft)&&(identical(other.c2, c2) || other.c2 == c2));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,dose,const DeepCollectionEquality().hash(times),withFood,kind,c1,soft,c2);

@override
String toString() {
  return 'Medicine(id: $id, name: $name, dose: $dose, times: $times, withFood: $withFood, kind: $kind, c1: $c1, soft: $soft, c2: $c2)';
}


}

/// @nodoc
abstract mixin class $MedicineCopyWith<$Res>  {
  factory $MedicineCopyWith(Medicine value, $Res Function(Medicine) _then) = _$MedicineCopyWithImpl;
@useResult
$Res call({
 String id, String name, String dose, List<DoseTime> times, bool withFood, PillKind kind, int c1, int soft, int? c2
});




}
/// @nodoc
class _$MedicineCopyWithImpl<$Res>
    implements $MedicineCopyWith<$Res> {
  _$MedicineCopyWithImpl(this._self, this._then);

  final Medicine _self;
  final $Res Function(Medicine) _then;

/// Create a copy of Medicine
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? dose = null,Object? times = null,Object? withFood = null,Object? kind = null,Object? c1 = null,Object? soft = null,Object? c2 = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,dose: null == dose ? _self.dose : dose // ignore: cast_nullable_to_non_nullable
as String,times: null == times ? _self.times : times // ignore: cast_nullable_to_non_nullable
as List<DoseTime>,withFood: null == withFood ? _self.withFood : withFood // ignore: cast_nullable_to_non_nullable
as bool,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as PillKind,c1: null == c1 ? _self.c1 : c1 // ignore: cast_nullable_to_non_nullable
as int,soft: null == soft ? _self.soft : soft // ignore: cast_nullable_to_non_nullable
as int,c2: freezed == c2 ? _self.c2 : c2 // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [Medicine].
extension MedicinePatterns on Medicine {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Medicine value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Medicine() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Medicine value)  $default,){
final _that = this;
switch (_that) {
case _Medicine():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Medicine value)?  $default,){
final _that = this;
switch (_that) {
case _Medicine() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String dose,  List<DoseTime> times,  bool withFood,  PillKind kind,  int c1,  int soft,  int? c2)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Medicine() when $default != null:
return $default(_that.id,_that.name,_that.dose,_that.times,_that.withFood,_that.kind,_that.c1,_that.soft,_that.c2);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String dose,  List<DoseTime> times,  bool withFood,  PillKind kind,  int c1,  int soft,  int? c2)  $default,) {final _that = this;
switch (_that) {
case _Medicine():
return $default(_that.id,_that.name,_that.dose,_that.times,_that.withFood,_that.kind,_that.c1,_that.soft,_that.c2);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String dose,  List<DoseTime> times,  bool withFood,  PillKind kind,  int c1,  int soft,  int? c2)?  $default,) {final _that = this;
switch (_that) {
case _Medicine() when $default != null:
return $default(_that.id,_that.name,_that.dose,_that.times,_that.withFood,_that.kind,_that.c1,_that.soft,_that.c2);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Medicine extends Medicine {
  const _Medicine({required this.id, required this.name, required this.dose, required final  List<DoseTime> times, required this.withFood, required this.kind, required this.c1, required this.soft, this.c2}): _times = times,super._();
  factory _Medicine.fromJson(Map<String, dynamic> json) => _$MedicineFromJson(json);

@override final  String id;
@override final  String name;
@override final  String dose;
/// Scheduled dose slots for the day, in the order they were added.
/// Always non-empty.
 final  List<DoseTime> _times;
/// Scheduled dose slots for the day, in the order they were added.
/// Always non-empty.
@override List<DoseTime> get times {
  if (_times is EqualUnmodifiableListView) return _times;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_times);
}

@override final  bool withFood;
@override final  PillKind kind;
/// Primary pill color (ARGB int).
@override final  int c1;
/// Soft background tint behind the pill thumbnail (ARGB int).
@override final  int soft;
/// Secondary pill color for capsules (ARGB int).
@override final  int? c2;

/// Create a copy of Medicine
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MedicineCopyWith<_Medicine> get copyWith => __$MedicineCopyWithImpl<_Medicine>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MedicineToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Medicine&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.dose, dose) || other.dose == dose)&&const DeepCollectionEquality().equals(other._times, _times)&&(identical(other.withFood, withFood) || other.withFood == withFood)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.c1, c1) || other.c1 == c1)&&(identical(other.soft, soft) || other.soft == soft)&&(identical(other.c2, c2) || other.c2 == c2));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,dose,const DeepCollectionEquality().hash(_times),withFood,kind,c1,soft,c2);

@override
String toString() {
  return 'Medicine(id: $id, name: $name, dose: $dose, times: $times, withFood: $withFood, kind: $kind, c1: $c1, soft: $soft, c2: $c2)';
}


}

/// @nodoc
abstract mixin class _$MedicineCopyWith<$Res> implements $MedicineCopyWith<$Res> {
  factory _$MedicineCopyWith(_Medicine value, $Res Function(_Medicine) _then) = __$MedicineCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String dose, List<DoseTime> times, bool withFood, PillKind kind, int c1, int soft, int? c2
});




}
/// @nodoc
class __$MedicineCopyWithImpl<$Res>
    implements _$MedicineCopyWith<$Res> {
  __$MedicineCopyWithImpl(this._self, this._then);

  final _Medicine _self;
  final $Res Function(_Medicine) _then;

/// Create a copy of Medicine
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? dose = null,Object? times = null,Object? withFood = null,Object? kind = null,Object? c1 = null,Object? soft = null,Object? c2 = freezed,}) {
  return _then(_Medicine(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,dose: null == dose ? _self.dose : dose // ignore: cast_nullable_to_non_nullable
as String,times: null == times ? _self._times : times // ignore: cast_nullable_to_non_nullable
as List<DoseTime>,withFood: null == withFood ? _self.withFood : withFood // ignore: cast_nullable_to_non_nullable
as bool,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as PillKind,c1: null == c1 ? _self.c1 : c1 // ignore: cast_nullable_to_non_nullable
as int,soft: null == soft ? _self.soft : soft // ignore: cast_nullable_to_non_nullable
as int,c2: freezed == c2 ? _self.c2 : c2 // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
