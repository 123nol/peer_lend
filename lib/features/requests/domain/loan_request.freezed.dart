// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'loan_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LoanRequest {

 String get id; String get offerId; String get lenderId; String get borrowerId; String get borrowerName; LoanTerms get termsSnapshot; DateTime get createdAt; RequestStatus get status;
/// Create a copy of LoanRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoanRequestCopyWith<LoanRequest> get copyWith => _$LoanRequestCopyWithImpl<LoanRequest>(this as LoanRequest, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoanRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.offerId, offerId) || other.offerId == offerId)&&(identical(other.lenderId, lenderId) || other.lenderId == lenderId)&&(identical(other.borrowerId, borrowerId) || other.borrowerId == borrowerId)&&(identical(other.borrowerName, borrowerName) || other.borrowerName == borrowerName)&&(identical(other.termsSnapshot, termsSnapshot) || other.termsSnapshot == termsSnapshot)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,id,offerId,lenderId,borrowerId,borrowerName,termsSnapshot,createdAt,status);

@override
String toString() {
  return 'LoanRequest(id: $id, offerId: $offerId, lenderId: $lenderId, borrowerId: $borrowerId, borrowerName: $borrowerName, termsSnapshot: $termsSnapshot, createdAt: $createdAt, status: $status)';
}


}

/// @nodoc
abstract mixin class $LoanRequestCopyWith<$Res>  {
  factory $LoanRequestCopyWith(LoanRequest value, $Res Function(LoanRequest) _then) = _$LoanRequestCopyWithImpl;
@useResult
$Res call({
 String id, String offerId, String lenderId, String borrowerId, String borrowerName, LoanTerms termsSnapshot, DateTime createdAt, RequestStatus status
});


$LoanTermsCopyWith<$Res> get termsSnapshot;

}
/// @nodoc
class _$LoanRequestCopyWithImpl<$Res>
    implements $LoanRequestCopyWith<$Res> {
  _$LoanRequestCopyWithImpl(this._self, this._then);

  final LoanRequest _self;
  final $Res Function(LoanRequest) _then;

/// Create a copy of LoanRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? offerId = null,Object? lenderId = null,Object? borrowerId = null,Object? borrowerName = null,Object? termsSnapshot = null,Object? createdAt = null,Object? status = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,offerId: null == offerId ? _self.offerId : offerId // ignore: cast_nullable_to_non_nullable
as String,lenderId: null == lenderId ? _self.lenderId : lenderId // ignore: cast_nullable_to_non_nullable
as String,borrowerId: null == borrowerId ? _self.borrowerId : borrowerId // ignore: cast_nullable_to_non_nullable
as String,borrowerName: null == borrowerName ? _self.borrowerName : borrowerName // ignore: cast_nullable_to_non_nullable
as String,termsSnapshot: null == termsSnapshot ? _self.termsSnapshot : termsSnapshot // ignore: cast_nullable_to_non_nullable
as LoanTerms,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,
  ));
}
/// Create a copy of LoanRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoanTermsCopyWith<$Res> get termsSnapshot {
  
  return $LoanTermsCopyWith<$Res>(_self.termsSnapshot, (value) {
    return _then(_self.copyWith(termsSnapshot: value));
  });
}
}


/// Adds pattern-matching-related methods to [LoanRequest].
extension LoanRequestPatterns on LoanRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LoanRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoanRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LoanRequest value)  $default,){
final _that = this;
switch (_that) {
case _LoanRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LoanRequest value)?  $default,){
final _that = this;
switch (_that) {
case _LoanRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String offerId,  String lenderId,  String borrowerId,  String borrowerName,  LoanTerms termsSnapshot,  DateTime createdAt,  RequestStatus status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoanRequest() when $default != null:
return $default(_that.id,_that.offerId,_that.lenderId,_that.borrowerId,_that.borrowerName,_that.termsSnapshot,_that.createdAt,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String offerId,  String lenderId,  String borrowerId,  String borrowerName,  LoanTerms termsSnapshot,  DateTime createdAt,  RequestStatus status)  $default,) {final _that = this;
switch (_that) {
case _LoanRequest():
return $default(_that.id,_that.offerId,_that.lenderId,_that.borrowerId,_that.borrowerName,_that.termsSnapshot,_that.createdAt,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String offerId,  String lenderId,  String borrowerId,  String borrowerName,  LoanTerms termsSnapshot,  DateTime createdAt,  RequestStatus status)?  $default,) {final _that = this;
switch (_that) {
case _LoanRequest() when $default != null:
return $default(_that.id,_that.offerId,_that.lenderId,_that.borrowerId,_that.borrowerName,_that.termsSnapshot,_that.createdAt,_that.status);case _:
  return null;

}
}

}

/// @nodoc


class _LoanRequest implements LoanRequest {
  const _LoanRequest({required this.id, required this.offerId, required this.lenderId, required this.borrowerId, required this.borrowerName, required this.termsSnapshot, required this.createdAt, this.status = RequestStatus.pending});
  

@override final  String id;
@override final  String offerId;
@override final  String lenderId;
@override final  String borrowerId;
@override final  String borrowerName;
@override final  LoanTerms termsSnapshot;
@override final  DateTime createdAt;
@override@JsonKey() final  RequestStatus status;

/// Create a copy of LoanRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoanRequestCopyWith<_LoanRequest> get copyWith => __$LoanRequestCopyWithImpl<_LoanRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoanRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.offerId, offerId) || other.offerId == offerId)&&(identical(other.lenderId, lenderId) || other.lenderId == lenderId)&&(identical(other.borrowerId, borrowerId) || other.borrowerId == borrowerId)&&(identical(other.borrowerName, borrowerName) || other.borrowerName == borrowerName)&&(identical(other.termsSnapshot, termsSnapshot) || other.termsSnapshot == termsSnapshot)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,id,offerId,lenderId,borrowerId,borrowerName,termsSnapshot,createdAt,status);

@override
String toString() {
  return 'LoanRequest(id: $id, offerId: $offerId, lenderId: $lenderId, borrowerId: $borrowerId, borrowerName: $borrowerName, termsSnapshot: $termsSnapshot, createdAt: $createdAt, status: $status)';
}


}

/// @nodoc
abstract mixin class _$LoanRequestCopyWith<$Res> implements $LoanRequestCopyWith<$Res> {
  factory _$LoanRequestCopyWith(_LoanRequest value, $Res Function(_LoanRequest) _then) = __$LoanRequestCopyWithImpl;
@override @useResult
$Res call({
 String id, String offerId, String lenderId, String borrowerId, String borrowerName, LoanTerms termsSnapshot, DateTime createdAt, RequestStatus status
});


@override $LoanTermsCopyWith<$Res> get termsSnapshot;

}
/// @nodoc
class __$LoanRequestCopyWithImpl<$Res>
    implements _$LoanRequestCopyWith<$Res> {
  __$LoanRequestCopyWithImpl(this._self, this._then);

  final _LoanRequest _self;
  final $Res Function(_LoanRequest) _then;

/// Create a copy of LoanRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? offerId = null,Object? lenderId = null,Object? borrowerId = null,Object? borrowerName = null,Object? termsSnapshot = null,Object? createdAt = null,Object? status = null,}) {
  return _then(_LoanRequest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,offerId: null == offerId ? _self.offerId : offerId // ignore: cast_nullable_to_non_nullable
as String,lenderId: null == lenderId ? _self.lenderId : lenderId // ignore: cast_nullable_to_non_nullable
as String,borrowerId: null == borrowerId ? _self.borrowerId : borrowerId // ignore: cast_nullable_to_non_nullable
as String,borrowerName: null == borrowerName ? _self.borrowerName : borrowerName // ignore: cast_nullable_to_non_nullable
as String,termsSnapshot: null == termsSnapshot ? _self.termsSnapshot : termsSnapshot // ignore: cast_nullable_to_non_nullable
as LoanTerms,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,
  ));
}

/// Create a copy of LoanRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoanTermsCopyWith<$Res> get termsSnapshot {
  
  return $LoanTermsCopyWith<$Res>(_self.termsSnapshot, (value) {
    return _then(_self.copyWith(termsSnapshot: value));
  });
}
}

// dart format on
