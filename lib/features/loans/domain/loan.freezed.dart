// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'loan.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Instalment {

 String get id; DateTime get dueDate; int get amountMinor;
/// Create a copy of Instalment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InstalmentCopyWith<Instalment> get copyWith => _$InstalmentCopyWithImpl<Instalment>(this as Instalment, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Instalment&&(identical(other.id, id) || other.id == id)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.amountMinor, amountMinor) || other.amountMinor == amountMinor));
}


@override
int get hashCode => Object.hash(runtimeType,id,dueDate,amountMinor);

@override
String toString() {
  return 'Instalment(id: $id, dueDate: $dueDate, amountMinor: $amountMinor)';
}


}

/// @nodoc
abstract mixin class $InstalmentCopyWith<$Res>  {
  factory $InstalmentCopyWith(Instalment value, $Res Function(Instalment) _then) = _$InstalmentCopyWithImpl;
@useResult
$Res call({
 String id, DateTime dueDate, int amountMinor
});




}
/// @nodoc
class _$InstalmentCopyWithImpl<$Res>
    implements $InstalmentCopyWith<$Res> {
  _$InstalmentCopyWithImpl(this._self, this._then);

  final Instalment _self;
  final $Res Function(Instalment) _then;

/// Create a copy of Instalment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? dueDate = null,Object? amountMinor = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,dueDate: null == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime,amountMinor: null == amountMinor ? _self.amountMinor : amountMinor // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Instalment].
extension InstalmentPatterns on Instalment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Instalment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Instalment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Instalment value)  $default,){
final _that = this;
switch (_that) {
case _Instalment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Instalment value)?  $default,){
final _that = this;
switch (_that) {
case _Instalment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  DateTime dueDate,  int amountMinor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Instalment() when $default != null:
return $default(_that.id,_that.dueDate,_that.amountMinor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  DateTime dueDate,  int amountMinor)  $default,) {final _that = this;
switch (_that) {
case _Instalment():
return $default(_that.id,_that.dueDate,_that.amountMinor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  DateTime dueDate,  int amountMinor)?  $default,) {final _that = this;
switch (_that) {
case _Instalment() when $default != null:
return $default(_that.id,_that.dueDate,_that.amountMinor);case _:
  return null;

}
}

}

/// @nodoc


class _Instalment implements Instalment {
  const _Instalment({required this.id, required this.dueDate, required this.amountMinor});
  

@override final  String id;
@override final  DateTime dueDate;
@override final  int amountMinor;

/// Create a copy of Instalment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InstalmentCopyWith<_Instalment> get copyWith => __$InstalmentCopyWithImpl<_Instalment>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Instalment&&(identical(other.id, id) || other.id == id)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.amountMinor, amountMinor) || other.amountMinor == amountMinor));
}


@override
int get hashCode => Object.hash(runtimeType,id,dueDate,amountMinor);

@override
String toString() {
  return 'Instalment(id: $id, dueDate: $dueDate, amountMinor: $amountMinor)';
}


}

/// @nodoc
abstract mixin class _$InstalmentCopyWith<$Res> implements $InstalmentCopyWith<$Res> {
  factory _$InstalmentCopyWith(_Instalment value, $Res Function(_Instalment) _then) = __$InstalmentCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime dueDate, int amountMinor
});




}
/// @nodoc
class __$InstalmentCopyWithImpl<$Res>
    implements _$InstalmentCopyWith<$Res> {
  __$InstalmentCopyWithImpl(this._self, this._then);

  final _Instalment _self;
  final $Res Function(_Instalment) _then;

/// Create a copy of Instalment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? dueDate = null,Object? amountMinor = null,}) {
  return _then(_Instalment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,dueDate: null == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime,amountMinor: null == amountMinor ? _self.amountMinor : amountMinor // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$Loan {

 String get id; String get requestId; String get lenderId; String get borrowerId; LoanTerms get termsSnapshot; DateTime get startDate; List<Instalment> get instalments;
/// Create a copy of Loan
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoanCopyWith<Loan> get copyWith => _$LoanCopyWithImpl<Loan>(this as Loan, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loan&&(identical(other.id, id) || other.id == id)&&(identical(other.requestId, requestId) || other.requestId == requestId)&&(identical(other.lenderId, lenderId) || other.lenderId == lenderId)&&(identical(other.borrowerId, borrowerId) || other.borrowerId == borrowerId)&&(identical(other.termsSnapshot, termsSnapshot) || other.termsSnapshot == termsSnapshot)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&const DeepCollectionEquality().equals(other.instalments, instalments));
}


@override
int get hashCode => Object.hash(runtimeType,id,requestId,lenderId,borrowerId,termsSnapshot,startDate,const DeepCollectionEquality().hash(instalments));

@override
String toString() {
  return 'Loan(id: $id, requestId: $requestId, lenderId: $lenderId, borrowerId: $borrowerId, termsSnapshot: $termsSnapshot, startDate: $startDate, instalments: $instalments)';
}


}

/// @nodoc
abstract mixin class $LoanCopyWith<$Res>  {
  factory $LoanCopyWith(Loan value, $Res Function(Loan) _then) = _$LoanCopyWithImpl;
@useResult
$Res call({
 String id, String requestId, String lenderId, String borrowerId, LoanTerms termsSnapshot, DateTime startDate, List<Instalment> instalments
});




}
/// @nodoc
class _$LoanCopyWithImpl<$Res>
    implements $LoanCopyWith<$Res> {
  _$LoanCopyWithImpl(this._self, this._then);

  final Loan _self;
  final $Res Function(Loan) _then;

/// Create a copy of Loan
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? requestId = null,Object? lenderId = null,Object? borrowerId = null,Object? termsSnapshot = null,Object? startDate = null,Object? instalments = null,}) {
  return _then(Loan(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,requestId: null == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String,lenderId: null == lenderId ? _self.lenderId : lenderId // ignore: cast_nullable_to_non_nullable
as String,borrowerId: null == borrowerId ? _self.borrowerId : borrowerId // ignore: cast_nullable_to_non_nullable
as String,termsSnapshot: null == termsSnapshot ? _self.termsSnapshot : termsSnapshot // ignore: cast_nullable_to_non_nullable
as LoanTerms,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,instalments: null == instalments ? _self.instalments : instalments // ignore: cast_nullable_to_non_nullable
as List<Instalment>,
  ));
}

}


/// Adds pattern-matching-related methods to [Loan].
extension LoanPatterns on Loan {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({required TResult orElse(),}){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({required TResult orElse(),}) {final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
  return null;

}
}

}

// dart format on
