// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'offer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LoanTerms {

 int get principalMinor; int get annualRateBps; int get termMonths; String get currency;
/// Create a copy of LoanTerms
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoanTermsCopyWith<LoanTerms> get copyWith => _$LoanTermsCopyWithImpl<LoanTerms>(this as LoanTerms, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoanTerms&&(identical(other.principalMinor, principalMinor) || other.principalMinor == principalMinor)&&(identical(other.annualRateBps, annualRateBps) || other.annualRateBps == annualRateBps)&&(identical(other.termMonths, termMonths) || other.termMonths == termMonths)&&(identical(other.currency, currency) || other.currency == currency));
}


@override
int get hashCode => Object.hash(runtimeType,principalMinor,annualRateBps,termMonths,currency);

@override
String toString() {
  return 'LoanTerms(principalMinor: $principalMinor, annualRateBps: $annualRateBps, termMonths: $termMonths, currency: $currency)';
}


}

/// @nodoc
abstract mixin class $LoanTermsCopyWith<$Res>  {
  factory $LoanTermsCopyWith(LoanTerms value, $Res Function(LoanTerms) _then) = _$LoanTermsCopyWithImpl;
@useResult
$Res call({
 int principalMinor, int annualRateBps, int termMonths, String currency
});




}
/// @nodoc
class _$LoanTermsCopyWithImpl<$Res>
    implements $LoanTermsCopyWith<$Res> {
  _$LoanTermsCopyWithImpl(this._self, this._then);

  final LoanTerms _self;
  final $Res Function(LoanTerms) _then;

/// Create a copy of LoanTerms
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? principalMinor = null,Object? annualRateBps = null,Object? termMonths = null,Object? currency = null,}) {
  return _then(_self.copyWith(
principalMinor: null == principalMinor ? _self.principalMinor : principalMinor // ignore: cast_nullable_to_non_nullable
as int,annualRateBps: null == annualRateBps ? _self.annualRateBps : annualRateBps // ignore: cast_nullable_to_non_nullable
as int,termMonths: null == termMonths ? _self.termMonths : termMonths // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LoanTerms].
extension LoanTermsPatterns on LoanTerms {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LoanTerms value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoanTerms() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LoanTerms value)  $default,){
final _that = this;
switch (_that) {
case _LoanTerms():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LoanTerms value)?  $default,){
final _that = this;
switch (_that) {
case _LoanTerms() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int principalMinor,  int annualRateBps,  int termMonths,  String currency)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoanTerms() when $default != null:
return $default(_that.principalMinor,_that.annualRateBps,_that.termMonths,_that.currency);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int principalMinor,  int annualRateBps,  int termMonths,  String currency)  $default,) {final _that = this;
switch (_that) {
case _LoanTerms():
return $default(_that.principalMinor,_that.annualRateBps,_that.termMonths,_that.currency);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int principalMinor,  int annualRateBps,  int termMonths,  String currency)?  $default,) {final _that = this;
switch (_that) {
case _LoanTerms() when $default != null:
return $default(_that.principalMinor,_that.annualRateBps,_that.termMonths,_that.currency);case _:
  return null;

}
}

}

/// @nodoc


class _LoanTerms implements LoanTerms {
  const _LoanTerms({required this.principalMinor, required this.annualRateBps, required this.termMonths, this.currency = 'ETB'});
  

@override final  int principalMinor;
@override final  int annualRateBps;
@override final  int termMonths;
@override@JsonKey() final  String currency;

/// Create a copy of LoanTerms
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoanTermsCopyWith<_LoanTerms> get copyWith => __$LoanTermsCopyWithImpl<_LoanTerms>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoanTerms&&(identical(other.principalMinor, principalMinor) || other.principalMinor == principalMinor)&&(identical(other.annualRateBps, annualRateBps) || other.annualRateBps == annualRateBps)&&(identical(other.termMonths, termMonths) || other.termMonths == termMonths)&&(identical(other.currency, currency) || other.currency == currency));
}


@override
int get hashCode => Object.hash(runtimeType,principalMinor,annualRateBps,termMonths,currency);

@override
String toString() {
  return 'LoanTerms(principalMinor: $principalMinor, annualRateBps: $annualRateBps, termMonths: $termMonths, currency: $currency)';
}


}

/// @nodoc
abstract mixin class _$LoanTermsCopyWith<$Res> implements $LoanTermsCopyWith<$Res> {
  factory _$LoanTermsCopyWith(_LoanTerms value, $Res Function(_LoanTerms) _then) = __$LoanTermsCopyWithImpl;
@override @useResult
$Res call({
 int principalMinor, int annualRateBps, int termMonths, String currency
});




}
/// @nodoc
class __$LoanTermsCopyWithImpl<$Res>
    implements _$LoanTermsCopyWith<$Res> {
  __$LoanTermsCopyWithImpl(this._self, this._then);

  final _LoanTerms _self;
  final $Res Function(_LoanTerms) _then;

/// Create a copy of LoanTerms
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? principalMinor = null,Object? annualRateBps = null,Object? termMonths = null,Object? currency = null,}) {
  return _then(_LoanTerms(
principalMinor: null == principalMinor ? _self.principalMinor : principalMinor // ignore: cast_nullable_to_non_nullable
as int,annualRateBps: null == annualRateBps ? _self.annualRateBps : annualRateBps // ignore: cast_nullable_to_non_nullable
as int,termMonths: null == termMonths ? _self.termMonths : termMonths // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$Offer {

 String get id; String get lenderId; String get lenderName; LoanTerms get terms; OfferStatus get status; int get version;
/// Create a copy of Offer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OfferCopyWith<Offer> get copyWith => _$OfferCopyWithImpl<Offer>(this as Offer, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Offer&&(identical(other.id, id) || other.id == id)&&(identical(other.lenderId, lenderId) || other.lenderId == lenderId)&&(identical(other.lenderName, lenderName) || other.lenderName == lenderName)&&(identical(other.terms, terms) || other.terms == terms)&&(identical(other.status, status) || other.status == status)&&(identical(other.version, version) || other.version == version));
}


@override
int get hashCode => Object.hash(runtimeType,id,lenderId,lenderName,terms,status,version);

@override
String toString() {
  return 'Offer(id: $id, lenderId: $lenderId, lenderName: $lenderName, terms: $terms, status: $status, version: $version)';
}


}

/// @nodoc
abstract mixin class $OfferCopyWith<$Res>  {
  factory $OfferCopyWith(Offer value, $Res Function(Offer) _then) = _$OfferCopyWithImpl;
@useResult
$Res call({
 String id, String lenderId, String lenderName, LoanTerms terms, OfferStatus status, int version
});


$LoanTermsCopyWith<$Res> get terms;

}
/// @nodoc
class _$OfferCopyWithImpl<$Res>
    implements $OfferCopyWith<$Res> {
  _$OfferCopyWithImpl(this._self, this._then);

  final Offer _self;
  final $Res Function(Offer) _then;

/// Create a copy of Offer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? lenderId = null,Object? lenderName = null,Object? terms = null,Object? status = null,Object? version = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,lenderId: null == lenderId ? _self.lenderId : lenderId // ignore: cast_nullable_to_non_nullable
as String,lenderName: null == lenderName ? _self.lenderName : lenderName // ignore: cast_nullable_to_non_nullable
as String,terms: null == terms ? _self.terms : terms // ignore: cast_nullable_to_non_nullable
as LoanTerms,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OfferStatus,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of Offer
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoanTermsCopyWith<$Res> get terms {
  
  return $LoanTermsCopyWith<$Res>(_self.terms, (value) {
    return _then(_self.copyWith(terms: value));
  });
}
}


/// Adds pattern-matching-related methods to [Offer].
extension OfferPatterns on Offer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Offer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Offer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Offer value)  $default,){
final _that = this;
switch (_that) {
case _Offer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Offer value)?  $default,){
final _that = this;
switch (_that) {
case _Offer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String lenderId,  String lenderName,  LoanTerms terms,  OfferStatus status,  int version)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Offer() when $default != null:
return $default(_that.id,_that.lenderId,_that.lenderName,_that.terms,_that.status,_that.version);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String lenderId,  String lenderName,  LoanTerms terms,  OfferStatus status,  int version)  $default,) {final _that = this;
switch (_that) {
case _Offer():
return $default(_that.id,_that.lenderId,_that.lenderName,_that.terms,_that.status,_that.version);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String lenderId,  String lenderName,  LoanTerms terms,  OfferStatus status,  int version)?  $default,) {final _that = this;
switch (_that) {
case _Offer() when $default != null:
return $default(_that.id,_that.lenderId,_that.lenderName,_that.terms,_that.status,_that.version);case _:
  return null;

}
}

}

/// @nodoc


class _Offer implements Offer {
  const _Offer({required this.id, required this.lenderId, required this.lenderName, required this.terms, this.status = OfferStatus.available, this.version = 1});
  

@override final  String id;
@override final  String lenderId;
@override final  String lenderName;
@override final  LoanTerms terms;
@override@JsonKey() final  OfferStatus status;
@override@JsonKey() final  int version;

/// Create a copy of Offer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OfferCopyWith<_Offer> get copyWith => __$OfferCopyWithImpl<_Offer>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Offer&&(identical(other.id, id) || other.id == id)&&(identical(other.lenderId, lenderId) || other.lenderId == lenderId)&&(identical(other.lenderName, lenderName) || other.lenderName == lenderName)&&(identical(other.terms, terms) || other.terms == terms)&&(identical(other.status, status) || other.status == status)&&(identical(other.version, version) || other.version == version));
}


@override
int get hashCode => Object.hash(runtimeType,id,lenderId,lenderName,terms,status,version);

@override
String toString() {
  return 'Offer(id: $id, lenderId: $lenderId, lenderName: $lenderName, terms: $terms, status: $status, version: $version)';
}


}

/// @nodoc
abstract mixin class _$OfferCopyWith<$Res> implements $OfferCopyWith<$Res> {
  factory _$OfferCopyWith(_Offer value, $Res Function(_Offer) _then) = __$OfferCopyWithImpl;
@override @useResult
$Res call({
 String id, String lenderId, String lenderName, LoanTerms terms, OfferStatus status, int version
});


@override $LoanTermsCopyWith<$Res> get terms;

}
/// @nodoc
class __$OfferCopyWithImpl<$Res>
    implements _$OfferCopyWith<$Res> {
  __$OfferCopyWithImpl(this._self, this._then);

  final _Offer _self;
  final $Res Function(_Offer) _then;

/// Create a copy of Offer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? lenderId = null,Object? lenderName = null,Object? terms = null,Object? status = null,Object? version = null,}) {
  return _then(_Offer(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,lenderId: null == lenderId ? _self.lenderId : lenderId // ignore: cast_nullable_to_non_nullable
as String,lenderName: null == lenderName ? _self.lenderName : lenderName // ignore: cast_nullable_to_non_nullable
as String,terms: null == terms ? _self.terms : terms // ignore: cast_nullable_to_non_nullable
as LoanTerms,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OfferStatus,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of Offer
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoanTermsCopyWith<$Res> get terms {
  
  return $LoanTermsCopyWith<$Res>(_self.terms, (value) {
    return _then(_self.copyWith(terms: value));
  });
}
}

// dart format on
