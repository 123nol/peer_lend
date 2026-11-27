// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'repayment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Repayment {

 String get id; String get loanId; String get instalmentId; int get amountMinor; String get recordedBy; DateTime get recordedAt; ConfirmationStatus get status; String get note; bool get hasDemoReceipt;
/// Create a copy of Repayment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RepaymentCopyWith<Repayment> get copyWith => _$RepaymentCopyWithImpl<Repayment>(this as Repayment, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Repayment&&(identical(other.id, id) || other.id == id)&&(identical(other.loanId, loanId) || other.loanId == loanId)&&(identical(other.instalmentId, instalmentId) || other.instalmentId == instalmentId)&&(identical(other.amountMinor, amountMinor) || other.amountMinor == amountMinor)&&(identical(other.recordedBy, recordedBy) || other.recordedBy == recordedBy)&&(identical(other.recordedAt, recordedAt) || other.recordedAt == recordedAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.note, note) || other.note == note)&&(identical(other.hasDemoReceipt, hasDemoReceipt) || other.hasDemoReceipt == hasDemoReceipt));
}


@override
int get hashCode => Object.hash(runtimeType,id,loanId,instalmentId,amountMinor,recordedBy,recordedAt,status,note,hasDemoReceipt);

@override
String toString() {
  return 'Repayment(id: $id, loanId: $loanId, instalmentId: $instalmentId, amountMinor: $amountMinor, recordedBy: $recordedBy, recordedAt: $recordedAt, status: $status, note: $note, hasDemoReceipt: $hasDemoReceipt)';
}


}

/// @nodoc
abstract mixin class $RepaymentCopyWith<$Res>  {
  factory $RepaymentCopyWith(Repayment value, $Res Function(Repayment) _then) = _$RepaymentCopyWithImpl;
@useResult
$Res call({
 String id, String loanId, String instalmentId, int amountMinor, String recordedBy, DateTime recordedAt, ConfirmationStatus status, String note, bool hasDemoReceipt
});




}
/// @nodoc
class _$RepaymentCopyWithImpl<$Res>
    implements $RepaymentCopyWith<$Res> {
  _$RepaymentCopyWithImpl(this._self, this._then);

  final Repayment _self;
  final $Res Function(Repayment) _then;

/// Create a copy of Repayment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? loanId = null,Object? instalmentId = null,Object? amountMinor = null,Object? recordedBy = null,Object? recordedAt = null,Object? status = null,Object? note = null,Object? hasDemoReceipt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,loanId: null == loanId ? _self.loanId : loanId // ignore: cast_nullable_to_non_nullable
as String,instalmentId: null == instalmentId ? _self.instalmentId : instalmentId // ignore: cast_nullable_to_non_nullable
as String,amountMinor: null == amountMinor ? _self.amountMinor : amountMinor // ignore: cast_nullable_to_non_nullable
as int,recordedBy: null == recordedBy ? _self.recordedBy : recordedBy // ignore: cast_nullable_to_non_nullable
as String,recordedAt: null == recordedAt ? _self.recordedAt : recordedAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ConfirmationStatus,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,hasDemoReceipt: null == hasDemoReceipt ? _self.hasDemoReceipt : hasDemoReceipt // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Repayment].
extension RepaymentPatterns on Repayment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Repayment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Repayment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Repayment value)  $default,){
final _that = this;
switch (_that) {
case _Repayment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Repayment value)?  $default,){
final _that = this;
switch (_that) {
case _Repayment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String loanId,  String instalmentId,  int amountMinor,  String recordedBy,  DateTime recordedAt,  ConfirmationStatus status,  String note,  bool hasDemoReceipt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Repayment() when $default != null:
return $default(_that.id,_that.loanId,_that.instalmentId,_that.amountMinor,_that.recordedBy,_that.recordedAt,_that.status,_that.note,_that.hasDemoReceipt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String loanId,  String instalmentId,  int amountMinor,  String recordedBy,  DateTime recordedAt,  ConfirmationStatus status,  String note,  bool hasDemoReceipt)  $default,) {final _that = this;
switch (_that) {
case _Repayment():
return $default(_that.id,_that.loanId,_that.instalmentId,_that.amountMinor,_that.recordedBy,_that.recordedAt,_that.status,_that.note,_that.hasDemoReceipt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String loanId,  String instalmentId,  int amountMinor,  String recordedBy,  DateTime recordedAt,  ConfirmationStatus status,  String note,  bool hasDemoReceipt)?  $default,) {final _that = this;
switch (_that) {
case _Repayment() when $default != null:
return $default(_that.id,_that.loanId,_that.instalmentId,_that.amountMinor,_that.recordedBy,_that.recordedAt,_that.status,_that.note,_that.hasDemoReceipt);case _:
  return null;

}
}

}

/// @nodoc


class _Repayment implements Repayment {
  const _Repayment({required this.id, required this.loanId, required this.instalmentId, required this.amountMinor, required this.recordedBy, required this.recordedAt, this.status = ConfirmationStatus.pending, this.note = '', this.hasDemoReceipt = false});
  

@override final  String id;
@override final  String loanId;
@override final  String instalmentId;
@override final  int amountMinor;
@override final  String recordedBy;
@override final  DateTime recordedAt;
@override@JsonKey() final  ConfirmationStatus status;
@override@JsonKey() final  String note;
@override@JsonKey() final  bool hasDemoReceipt;

/// Create a copy of Repayment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RepaymentCopyWith<_Repayment> get copyWith => __$RepaymentCopyWithImpl<_Repayment>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Repayment&&(identical(other.id, id) || other.id == id)&&(identical(other.loanId, loanId) || other.loanId == loanId)&&(identical(other.instalmentId, instalmentId) || other.instalmentId == instalmentId)&&(identical(other.amountMinor, amountMinor) || other.amountMinor == amountMinor)&&(identical(other.recordedBy, recordedBy) || other.recordedBy == recordedBy)&&(identical(other.recordedAt, recordedAt) || other.recordedAt == recordedAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.note, note) || other.note == note)&&(identical(other.hasDemoReceipt, hasDemoReceipt) || other.hasDemoReceipt == hasDemoReceipt));
}


@override
int get hashCode => Object.hash(runtimeType,id,loanId,instalmentId,amountMinor,recordedBy,recordedAt,status,note,hasDemoReceipt);

@override
String toString() {
  return 'Repayment(id: $id, loanId: $loanId, instalmentId: $instalmentId, amountMinor: $amountMinor, recordedBy: $recordedBy, recordedAt: $recordedAt, status: $status, note: $note, hasDemoReceipt: $hasDemoReceipt)';
}


}

/// @nodoc
abstract mixin class _$RepaymentCopyWith<$Res> implements $RepaymentCopyWith<$Res> {
  factory _$RepaymentCopyWith(_Repayment value, $Res Function(_Repayment) _then) = __$RepaymentCopyWithImpl;
@override @useResult
$Res call({
 String id, String loanId, String instalmentId, int amountMinor, String recordedBy, DateTime recordedAt, ConfirmationStatus status, String note, bool hasDemoReceipt
});




}
/// @nodoc
class __$RepaymentCopyWithImpl<$Res>
    implements _$RepaymentCopyWith<$Res> {
  __$RepaymentCopyWithImpl(this._self, this._then);

  final _Repayment _self;
  final $Res Function(_Repayment) _then;

/// Create a copy of Repayment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? loanId = null,Object? instalmentId = null,Object? amountMinor = null,Object? recordedBy = null,Object? recordedAt = null,Object? status = null,Object? note = null,Object? hasDemoReceipt = null,}) {
  return _then(_Repayment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,loanId: null == loanId ? _self.loanId : loanId // ignore: cast_nullable_to_non_nullable
as String,instalmentId: null == instalmentId ? _self.instalmentId : instalmentId // ignore: cast_nullable_to_non_nullable
as String,amountMinor: null == amountMinor ? _self.amountMinor : amountMinor // ignore: cast_nullable_to_non_nullable
as int,recordedBy: null == recordedBy ? _self.recordedBy : recordedBy // ignore: cast_nullable_to_non_nullable
as String,recordedAt: null == recordedAt ? _self.recordedAt : recordedAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ConfirmationStatus,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,hasDemoReceipt: null == hasDemoReceipt ? _self.hasDemoReceipt : hasDemoReceipt // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
