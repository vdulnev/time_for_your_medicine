// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'medicine_registry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MedicineRegistryItem {

 String get name; String get genericName; String get form;
/// Create a copy of MedicineRegistryItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MedicineRegistryItemCopyWith<MedicineRegistryItem> get copyWith => _$MedicineRegistryItemCopyWithImpl<MedicineRegistryItem>(this as MedicineRegistryItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MedicineRegistryItem&&(identical(other.name, name) || other.name == name)&&(identical(other.genericName, genericName) || other.genericName == genericName)&&(identical(other.form, form) || other.form == form));
}


@override
int get hashCode => Object.hash(runtimeType,name,genericName,form);

@override
String toString() {
  return 'MedicineRegistryItem(name: $name, genericName: $genericName, form: $form)';
}


}

/// @nodoc
abstract mixin class $MedicineRegistryItemCopyWith<$Res>  {
  factory $MedicineRegistryItemCopyWith(MedicineRegistryItem value, $Res Function(MedicineRegistryItem) _then) = _$MedicineRegistryItemCopyWithImpl;
@useResult
$Res call({
 String name, String genericName, String form
});




}
/// @nodoc
class _$MedicineRegistryItemCopyWithImpl<$Res>
    implements $MedicineRegistryItemCopyWith<$Res> {
  _$MedicineRegistryItemCopyWithImpl(this._self, this._then);

  final MedicineRegistryItem _self;
  final $Res Function(MedicineRegistryItem) _then;

/// Create a copy of MedicineRegistryItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? genericName = null,Object? form = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,genericName: null == genericName ? _self.genericName : genericName // ignore: cast_nullable_to_non_nullable
as String,form: null == form ? _self.form : form // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MedicineRegistryItem].
extension MedicineRegistryItemPatterns on MedicineRegistryItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MedicineRegistryItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MedicineRegistryItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MedicineRegistryItem value)  $default,){
final _that = this;
switch (_that) {
case _MedicineRegistryItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MedicineRegistryItem value)?  $default,){
final _that = this;
switch (_that) {
case _MedicineRegistryItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String genericName,  String form)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MedicineRegistryItem() when $default != null:
return $default(_that.name,_that.genericName,_that.form);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String genericName,  String form)  $default,) {final _that = this;
switch (_that) {
case _MedicineRegistryItem():
return $default(_that.name,_that.genericName,_that.form);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String genericName,  String form)?  $default,) {final _that = this;
switch (_that) {
case _MedicineRegistryItem() when $default != null:
return $default(_that.name,_that.genericName,_that.form);case _:
  return null;

}
}

}

/// @nodoc


class _MedicineRegistryItem implements MedicineRegistryItem {
  const _MedicineRegistryItem({required this.name, required this.genericName, required this.form});
  

@override final  String name;
@override final  String genericName;
@override final  String form;

/// Create a copy of MedicineRegistryItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MedicineRegistryItemCopyWith<_MedicineRegistryItem> get copyWith => __$MedicineRegistryItemCopyWithImpl<_MedicineRegistryItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MedicineRegistryItem&&(identical(other.name, name) || other.name == name)&&(identical(other.genericName, genericName) || other.genericName == genericName)&&(identical(other.form, form) || other.form == form));
}


@override
int get hashCode => Object.hash(runtimeType,name,genericName,form);

@override
String toString() {
  return 'MedicineRegistryItem(name: $name, genericName: $genericName, form: $form)';
}


}

/// @nodoc
abstract mixin class _$MedicineRegistryItemCopyWith<$Res> implements $MedicineRegistryItemCopyWith<$Res> {
  factory _$MedicineRegistryItemCopyWith(_MedicineRegistryItem value, $Res Function(_MedicineRegistryItem) _then) = __$MedicineRegistryItemCopyWithImpl;
@override @useResult
$Res call({
 String name, String genericName, String form
});




}
/// @nodoc
class __$MedicineRegistryItemCopyWithImpl<$Res>
    implements _$MedicineRegistryItemCopyWith<$Res> {
  __$MedicineRegistryItemCopyWithImpl(this._self, this._then);

  final _MedicineRegistryItem _self;
  final $Res Function(_MedicineRegistryItem) _then;

/// Create a copy of MedicineRegistryItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? genericName = null,Object? form = null,}) {
  return _then(_MedicineRegistryItem(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,genericName: null == genericName ? _self.genericName : genericName // ignore: cast_nullable_to_non_nullable
as String,form: null == form ? _self.form : form // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$MedicineRegistryStatus {

 String get sourceName; DateTime get importedAt; int get entryCount;
/// Create a copy of MedicineRegistryStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MedicineRegistryStatusCopyWith<MedicineRegistryStatus> get copyWith => _$MedicineRegistryStatusCopyWithImpl<MedicineRegistryStatus>(this as MedicineRegistryStatus, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MedicineRegistryStatus&&(identical(other.sourceName, sourceName) || other.sourceName == sourceName)&&(identical(other.importedAt, importedAt) || other.importedAt == importedAt)&&(identical(other.entryCount, entryCount) || other.entryCount == entryCount));
}


@override
int get hashCode => Object.hash(runtimeType,sourceName,importedAt,entryCount);

@override
String toString() {
  return 'MedicineRegistryStatus(sourceName: $sourceName, importedAt: $importedAt, entryCount: $entryCount)';
}


}

/// @nodoc
abstract mixin class $MedicineRegistryStatusCopyWith<$Res>  {
  factory $MedicineRegistryStatusCopyWith(MedicineRegistryStatus value, $Res Function(MedicineRegistryStatus) _then) = _$MedicineRegistryStatusCopyWithImpl;
@useResult
$Res call({
 String sourceName, DateTime importedAt, int entryCount
});




}
/// @nodoc
class _$MedicineRegistryStatusCopyWithImpl<$Res>
    implements $MedicineRegistryStatusCopyWith<$Res> {
  _$MedicineRegistryStatusCopyWithImpl(this._self, this._then);

  final MedicineRegistryStatus _self;
  final $Res Function(MedicineRegistryStatus) _then;

/// Create a copy of MedicineRegistryStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sourceName = null,Object? importedAt = null,Object? entryCount = null,}) {
  return _then(_self.copyWith(
sourceName: null == sourceName ? _self.sourceName : sourceName // ignore: cast_nullable_to_non_nullable
as String,importedAt: null == importedAt ? _self.importedAt : importedAt // ignore: cast_nullable_to_non_nullable
as DateTime,entryCount: null == entryCount ? _self.entryCount : entryCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MedicineRegistryStatus].
extension MedicineRegistryStatusPatterns on MedicineRegistryStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MedicineRegistryStatus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MedicineRegistryStatus() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MedicineRegistryStatus value)  $default,){
final _that = this;
switch (_that) {
case _MedicineRegistryStatus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MedicineRegistryStatus value)?  $default,){
final _that = this;
switch (_that) {
case _MedicineRegistryStatus() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String sourceName,  DateTime importedAt,  int entryCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MedicineRegistryStatus() when $default != null:
return $default(_that.sourceName,_that.importedAt,_that.entryCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String sourceName,  DateTime importedAt,  int entryCount)  $default,) {final _that = this;
switch (_that) {
case _MedicineRegistryStatus():
return $default(_that.sourceName,_that.importedAt,_that.entryCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String sourceName,  DateTime importedAt,  int entryCount)?  $default,) {final _that = this;
switch (_that) {
case _MedicineRegistryStatus() when $default != null:
return $default(_that.sourceName,_that.importedAt,_that.entryCount);case _:
  return null;

}
}

}

/// @nodoc


class _MedicineRegistryStatus implements MedicineRegistryStatus {
  const _MedicineRegistryStatus({required this.sourceName, required this.importedAt, required this.entryCount});
  

@override final  String sourceName;
@override final  DateTime importedAt;
@override final  int entryCount;

/// Create a copy of MedicineRegistryStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MedicineRegistryStatusCopyWith<_MedicineRegistryStatus> get copyWith => __$MedicineRegistryStatusCopyWithImpl<_MedicineRegistryStatus>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MedicineRegistryStatus&&(identical(other.sourceName, sourceName) || other.sourceName == sourceName)&&(identical(other.importedAt, importedAt) || other.importedAt == importedAt)&&(identical(other.entryCount, entryCount) || other.entryCount == entryCount));
}


@override
int get hashCode => Object.hash(runtimeType,sourceName,importedAt,entryCount);

@override
String toString() {
  return 'MedicineRegistryStatus(sourceName: $sourceName, importedAt: $importedAt, entryCount: $entryCount)';
}


}

/// @nodoc
abstract mixin class _$MedicineRegistryStatusCopyWith<$Res> implements $MedicineRegistryStatusCopyWith<$Res> {
  factory _$MedicineRegistryStatusCopyWith(_MedicineRegistryStatus value, $Res Function(_MedicineRegistryStatus) _then) = __$MedicineRegistryStatusCopyWithImpl;
@override @useResult
$Res call({
 String sourceName, DateTime importedAt, int entryCount
});




}
/// @nodoc
class __$MedicineRegistryStatusCopyWithImpl<$Res>
    implements _$MedicineRegistryStatusCopyWith<$Res> {
  __$MedicineRegistryStatusCopyWithImpl(this._self, this._then);

  final _MedicineRegistryStatus _self;
  final $Res Function(_MedicineRegistryStatus) _then;

/// Create a copy of MedicineRegistryStatus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sourceName = null,Object? importedAt = null,Object? entryCount = null,}) {
  return _then(_MedicineRegistryStatus(
sourceName: null == sourceName ? _self.sourceName : sourceName // ignore: cast_nullable_to_non_nullable
as String,importedAt: null == importedAt ? _self.importedAt : importedAt // ignore: cast_nullable_to_non_nullable
as DateTime,entryCount: null == entryCount ? _self.entryCount : entryCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
