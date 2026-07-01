// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_exception.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppException {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppException);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppException()';
}


}

/// @nodoc
class $AppExceptionCopyWith<$Res>  {
$AppExceptionCopyWith(AppException _, $Res Function(AppException) __);
}


/// Adds pattern-matching-related methods to [AppException].
extension AppExceptionPatterns on AppException {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( DatabaseFailure value)?  databaseFailure,TResult Function( NotFoundFailure value)?  notFound,TResult Function( UnknownFailure value)?  unknown,required TResult orElse(),}){
final _that = this;
switch (_that) {
case DatabaseFailure() when databaseFailure != null:
return databaseFailure(_that);case NotFoundFailure() when notFound != null:
return notFound(_that);case UnknownFailure() when unknown != null:
return unknown(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( DatabaseFailure value)  databaseFailure,required TResult Function( NotFoundFailure value)  notFound,required TResult Function( UnknownFailure value)  unknown,}){
final _that = this;
switch (_that) {
case DatabaseFailure():
return databaseFailure(_that);case NotFoundFailure():
return notFound(_that);case UnknownFailure():
return unknown(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( DatabaseFailure value)?  databaseFailure,TResult? Function( NotFoundFailure value)?  notFound,TResult? Function( UnknownFailure value)?  unknown,}){
final _that = this;
switch (_that) {
case DatabaseFailure() when databaseFailure != null:
return databaseFailure(_that);case NotFoundFailure() when notFound != null:
return notFound(_that);case UnknownFailure() when unknown != null:
return unknown(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String message)?  databaseFailure,TResult Function( String id)?  notFound,TResult Function( Object error)?  unknown,required TResult orElse(),}) {final _that = this;
switch (_that) {
case DatabaseFailure() when databaseFailure != null:
return databaseFailure(_that.message);case NotFoundFailure() when notFound != null:
return notFound(_that.id);case UnknownFailure() when unknown != null:
return unknown(_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String message)  databaseFailure,required TResult Function( String id)  notFound,required TResult Function( Object error)  unknown,}) {final _that = this;
switch (_that) {
case DatabaseFailure():
return databaseFailure(_that.message);case NotFoundFailure():
return notFound(_that.id);case UnknownFailure():
return unknown(_that.error);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String message)?  databaseFailure,TResult? Function( String id)?  notFound,TResult? Function( Object error)?  unknown,}) {final _that = this;
switch (_that) {
case DatabaseFailure() when databaseFailure != null:
return databaseFailure(_that.message);case NotFoundFailure() when notFound != null:
return notFound(_that.id);case UnknownFailure() when unknown != null:
return unknown(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class DatabaseFailure extends AppException {
  const DatabaseFailure({required this.message}): super._();
  

 final  String message;

/// Create a copy of AppException
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DatabaseFailureCopyWith<DatabaseFailure> get copyWith => _$DatabaseFailureCopyWithImpl<DatabaseFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DatabaseFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AppException.databaseFailure(message: $message)';
}


}

/// @nodoc
abstract mixin class $DatabaseFailureCopyWith<$Res> implements $AppExceptionCopyWith<$Res> {
  factory $DatabaseFailureCopyWith(DatabaseFailure value, $Res Function(DatabaseFailure) _then) = _$DatabaseFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$DatabaseFailureCopyWithImpl<$Res>
    implements $DatabaseFailureCopyWith<$Res> {
  _$DatabaseFailureCopyWithImpl(this._self, this._then);

  final DatabaseFailure _self;
  final $Res Function(DatabaseFailure) _then;

/// Create a copy of AppException
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(DatabaseFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class NotFoundFailure extends AppException {
  const NotFoundFailure({required this.id}): super._();
  

 final  String id;

/// Create a copy of AppException
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotFoundFailureCopyWith<NotFoundFailure> get copyWith => _$NotFoundFailureCopyWithImpl<NotFoundFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotFoundFailure&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'AppException.notFound(id: $id)';
}


}

/// @nodoc
abstract mixin class $NotFoundFailureCopyWith<$Res> implements $AppExceptionCopyWith<$Res> {
  factory $NotFoundFailureCopyWith(NotFoundFailure value, $Res Function(NotFoundFailure) _then) = _$NotFoundFailureCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class _$NotFoundFailureCopyWithImpl<$Res>
    implements $NotFoundFailureCopyWith<$Res> {
  _$NotFoundFailureCopyWithImpl(this._self, this._then);

  final NotFoundFailure _self;
  final $Res Function(NotFoundFailure) _then;

/// Create a copy of AppException
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(NotFoundFailure(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class UnknownFailure extends AppException {
  const UnknownFailure({required this.error}): super._();
  

 final  Object error;

/// Create a copy of AppException
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnknownFailureCopyWith<UnknownFailure> get copyWith => _$UnknownFailureCopyWithImpl<UnknownFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnknownFailure&&const DeepCollectionEquality().equals(other.error, error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(error));

@override
String toString() {
  return 'AppException.unknown(error: $error)';
}


}

/// @nodoc
abstract mixin class $UnknownFailureCopyWith<$Res> implements $AppExceptionCopyWith<$Res> {
  factory $UnknownFailureCopyWith(UnknownFailure value, $Res Function(UnknownFailure) _then) = _$UnknownFailureCopyWithImpl;
@useResult
$Res call({
 Object error
});




}
/// @nodoc
class _$UnknownFailureCopyWithImpl<$Res>
    implements $UnknownFailureCopyWith<$Res> {
  _$UnknownFailureCopyWithImpl(this._self, this._then);

  final UnknownFailure _self;
  final $Res Function(UnknownFailure) _then;

/// Create a copy of AppException
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(UnknownFailure(
error: null == error ? _self.error : error ,
  ));
}


}

// dart format on
