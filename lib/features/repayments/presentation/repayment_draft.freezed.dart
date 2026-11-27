// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'repayment_draft.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RepaymentDraft {

 String? get instalmentId; String get amount; String get paymentDate; String get note; bool get hasDemoReceipt;
/// Create a copy of RepaymentDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RepaymentDraftCopyWith<RepaymentDraft> get copyWith => _$RepaymentDraftCopyWithImpl<RepaymentDraft>(this as RepaymentDraft, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RepaymentDraft&&(identical(other.instalmentId, instalmentId) || other.instalmentId == instalmentId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.paymentDate, paymentDate) || other.paymentDate == paymentDate)&&(identical(other.note, note) || other.note == note)&&(identical(other.hasDemoReceipt, hasDemoReceipt) || other.hasDemoReceipt == hasDemoReceipt));
}


@override
int get hashCode => Object.hash(runtimeType,instalmentId,amount,paymentDate,note,hasDemoReceipt);

@override
String toString() {
  return 'RepaymentDraft(instalmentId: $instalmentId, amount: $amount, paymentDate: $paymentDate, note: $note, hasDemoReceipt: $hasDemoReceipt)';
}


}

/// @nodoc
abstract mixin class $RepaymentDraftCopyWith<$Res>  {
  factory $RepaymentDraftCopyWith(RepaymentDraft value, $Res Function(RepaymentDraft) _then) = _$RepaymentDraftCopyWithImpl;
@useResult
$Res call({
 String? instalmentId, String amount, String paymentDate, String note, bool hasDemoReceipt
});




}
/// @nodoc
class _$RepaymentDraftCopyWithImpl<$Res>
    implements $RepaymentDraftCopyWith<$Res> {
  _$RepaymentDraftCopyWithImpl(this._self, this._then);

  final RepaymentDraft _self;
  final $Res Function(RepaymentDraft) _then;

/// Create a copy of RepaymentDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? instalmentId = freezed,Object? amount = null,Object? paymentDate = null,Object? note = null,Object? hasDemoReceipt = null,}) {
  return _then(_self.copyWith(
instalmentId: freezed == instalmentId ? _self.instalmentId : instalmentId // ignore: cast_nullable_to_non_nullable
as String?,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,paymentDate: null == paymentDate ? _self.paymentDate : paymentDate // ignore: cast_nullable_to_non_nullable
as String,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,hasDemoReceipt: null == hasDemoReceipt ? _self.hasDemoReceipt : hasDemoReceipt // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [RepaymentDraft].
extension RepaymentDraftPatterns on RepaymentDraft {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RepaymentDraft value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RepaymentDraft() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RepaymentDraft value)  $default,){
final _that = this;
switch (_that) {
case _RepaymentDraft():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RepaymentDraft value)?  $default,){
final _that = this;
switch (_that) {
case _RepaymentDraft() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? instalmentId,  String amount,  String paymentDate,  String note,  bool hasDemoReceipt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RepaymentDraft() when $default != null:
return $default(_that.instalmentId,_that.amount,_that.paymentDate,_that.note,_that.hasDemoReceipt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? instalmentId,  String amount,  String paymentDate,  String note,  bool hasDemoReceipt)  $default,) {final _that = this;
switch (_that) {
case _RepaymentDraft():
return $default(_that.instalmentId,_that.amount,_that.paymentDate,_that.note,_that.hasDemoReceipt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? instalmentId,  String amount,  String paymentDate,  String note,  bool hasDemoReceipt)?  $default,) {final _that = this;
switch (_that) {
case _RepaymentDraft() when $default != null:
return $default(_that.instalmentId,_that.amount,_that.paymentDate,_that.note,_that.hasDemoReceipt);case _:
  return null;

}
}

}

/// @nodoc


class _RepaymentDraft implements RepaymentDraft {
  const _RepaymentDraft({this.instalmentId, this.amount = '', required this.paymentDate, this.note = '', this.hasDemoReceipt = false});


@override final  String? instalmentId;
@override@JsonKey() final  String amount;
@override final  String paymentDate;
@override@JsonKey() final  String note;
@override@JsonKey() final  bool hasDemoReceipt;

/// Create a copy of RepaymentDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RepaymentDraftCopyWith<_RepaymentDraft> get copyWith => __$RepaymentDraftCopyWithImpl<_RepaymentDraft>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RepaymentDraft&&(identical(other.instalmentId, instalmentId) || other.instalmentId == instalmentId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.paymentDate, paymentDate) || other.paymentDate == paymentDate)&&(identical(other.note, note) || other.note == note)&&(identical(other.hasDemoReceipt, hasDemoReceipt) || other.hasDemoReceipt == hasDemoReceipt));
}


@override
int get hashCode => Object.hash(runtimeType,instalmentId,amount,paymentDate,note,hasDemoReceipt);

@override
String toString() {
  return 'RepaymentDraft(instalmentId: $instalmentId, amount: $amount, paymentDate: $paymentDate, note: $note, hasDemoReceipt: $hasDemoReceipt)';
}


}

/// @nodoc
abstract mixin class _$RepaymentDraftCopyWith<$Res> implements $RepaymentDraftCopyWith<$Res> {
  factory _$RepaymentDraftCopyWith(_RepaymentDraft value, $Res Function(_RepaymentDraft) _then) = __$RepaymentDraftCopyWithImpl;
@override @useResult
$Res call({
 String? instalmentId, String amount, String paymentDate, String note, bool hasDemoReceipt
});




}
/// @nodoc
class __$RepaymentDraftCopyWithImpl<$Res>
    implements _$RepaymentDraftCopyWith<$Res> {
  __$RepaymentDraftCopyWithImpl(this._self, this._then);

  final _RepaymentDraft _self;
  final $Res Function(_RepaymentDraft) _then;

/// Create a copy of RepaymentDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? instalmentId = freezed,Object? amount = null,Object? paymentDate = null,Object? note = null,Object? hasDemoReceipt = null,}) {
  return _then(_RepaymentDraft(
instalmentId: freezed == instalmentId ? _self.instalmentId : instalmentId // ignore: cast_nullable_to_non_nullable
as String?,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,paymentDate: null == paymentDate ? _self.paymentDate : paymentDate // ignore: cast_nullable_to_non_nullable
as String,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,hasDemoReceipt: null == hasDemoReceipt ? _self.hasDemoReceipt : hasDemoReceipt // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
