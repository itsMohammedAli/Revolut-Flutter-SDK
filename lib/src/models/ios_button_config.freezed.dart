// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ios_button_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RevolutPayButtonConfigIos {

 String get orderToken; int get amount; String get currency; String get email; bool get shouldRequestShipping; bool get savePaymentMethodForMerchant; String? get returnURL; String? get merchantName; String? get merchantLogoURL; Map<String, dynamic>? get additionalData;
/// Create a copy of RevolutPayButtonConfigIos
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RevolutPayButtonConfigIosCopyWith<RevolutPayButtonConfigIos> get copyWith => _$RevolutPayButtonConfigIosCopyWithImpl<RevolutPayButtonConfigIos>(this as RevolutPayButtonConfigIos, _$identity);

  /// Serializes this RevolutPayButtonConfigIos to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as RevolutPayButtonConfigIos;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RevolutPayButtonConfigIos&&(identical(other.orderToken, _this.orderToken) || other.orderToken == _this.orderToken)&&(identical(other.amount, _this.amount) || other.amount == _this.amount)&&(identical(other.currency, _this.currency) || other.currency == _this.currency)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.shouldRequestShipping, _this.shouldRequestShipping) || other.shouldRequestShipping == _this.shouldRequestShipping)&&(identical(other.savePaymentMethodForMerchant, _this.savePaymentMethodForMerchant) || other.savePaymentMethodForMerchant == _this.savePaymentMethodForMerchant)&&(identical(other.returnURL, _this.returnURL) || other.returnURL == _this.returnURL)&&(identical(other.merchantName, _this.merchantName) || other.merchantName == _this.merchantName)&&(identical(other.merchantLogoURL, _this.merchantLogoURL) || other.merchantLogoURL == _this.merchantLogoURL)&&const DeepCollectionEquality().equals(other.additionalData, _this.additionalData));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RevolutPayButtonConfigIos;
  return Object.hash(runtimeType,_this.orderToken,_this.amount,_this.currency,_this.email,_this.shouldRequestShipping,_this.savePaymentMethodForMerchant,_this.returnURL,_this.merchantName,_this.merchantLogoURL,const DeepCollectionEquality().hash(_this.additionalData));
}

@override
String toString() {
  final _this = this as RevolutPayButtonConfigIos;
  return 'RevolutPayButtonConfigIos(orderToken: ${_this.orderToken}, amount: ${_this.amount}, currency: ${_this.currency}, email: ${_this.email}, shouldRequestShipping: ${_this.shouldRequestShipping}, savePaymentMethodForMerchant: ${_this.savePaymentMethodForMerchant}, returnURL: ${_this.returnURL}, merchantName: ${_this.merchantName}, merchantLogoURL: ${_this.merchantLogoURL}, additionalData: ${_this.additionalData})';
}


}

/// @nodoc
abstract mixin class $RevolutPayButtonConfigIosCopyWith<$Res>  {
  factory $RevolutPayButtonConfigIosCopyWith(RevolutPayButtonConfigIos value, $Res Function(RevolutPayButtonConfigIos) _then) = _$RevolutPayButtonConfigIosCopyWithImpl;
@useResult
$Res call({
 String orderToken, int amount, String currency, String email, bool shouldRequestShipping, bool savePaymentMethodForMerchant, String? returnURL, String? merchantName, String? merchantLogoURL, Map<String, dynamic>? additionalData
});




}
/// @nodoc
class _$RevolutPayButtonConfigIosCopyWithImpl<$Res>
    implements $RevolutPayButtonConfigIosCopyWith<$Res> {
  _$RevolutPayButtonConfigIosCopyWithImpl(this._self, this._then);

  final RevolutPayButtonConfigIos _self;
  final $Res Function(RevolutPayButtonConfigIos) _then;

/// Create a copy of RevolutPayButtonConfigIos
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? orderToken = null,Object? amount = null,Object? currency = null,Object? email = null,Object? shouldRequestShipping = null,Object? savePaymentMethodForMerchant = null,Object? returnURL = freezed,Object? merchantName = freezed,Object? merchantLogoURL = freezed,Object? additionalData = freezed,}) {
  return _then(RevolutPayButtonConfigIos(
orderToken: null == orderToken ? _self.orderToken : orderToken // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,shouldRequestShipping: null == shouldRequestShipping ? _self.shouldRequestShipping : shouldRequestShipping // ignore: cast_nullable_to_non_nullable
as bool,savePaymentMethodForMerchant: null == savePaymentMethodForMerchant ? _self.savePaymentMethodForMerchant : savePaymentMethodForMerchant // ignore: cast_nullable_to_non_nullable
as bool,returnURL: freezed == returnURL ? _self.returnURL : returnURL // ignore: cast_nullable_to_non_nullable
as String?,merchantName: freezed == merchantName ? _self.merchantName : merchantName // ignore: cast_nullable_to_non_nullable
as String?,merchantLogoURL: freezed == merchantLogoURL ? _self.merchantLogoURL : merchantLogoURL // ignore: cast_nullable_to_non_nullable
as String?,additionalData: freezed == additionalData ? _self.additionalData : additionalData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [RevolutPayButtonConfigIos].
extension RevolutPayButtonConfigIosPatterns on RevolutPayButtonConfigIos {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RevolutPayButtonConfigIos value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RevolutPayButtonConfigIos() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RevolutPayButtonConfigIos value)  $default,){
final _that = this;
switch (_that) {
case _RevolutPayButtonConfigIos():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RevolutPayButtonConfigIos value)?  $default,){
final _that = this;
switch (_that) {
case _RevolutPayButtonConfigIos() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String orderToken,  int amount,  String currency,  String email,  bool shouldRequestShipping,  bool savePaymentMethodForMerchant,  String? returnURL,  String? merchantName,  String? merchantLogoURL,  Map<String, dynamic>? additionalData)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RevolutPayButtonConfigIos() when $default != null:
return $default(_that.orderToken,_that.amount,_that.currency,_that.email,_that.shouldRequestShipping,_that.savePaymentMethodForMerchant,_that.returnURL,_that.merchantName,_that.merchantLogoURL,_that.additionalData);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String orderToken,  int amount,  String currency,  String email,  bool shouldRequestShipping,  bool savePaymentMethodForMerchant,  String? returnURL,  String? merchantName,  String? merchantLogoURL,  Map<String, dynamic>? additionalData)  $default,) {final _that = this;
switch (_that) {
case _RevolutPayButtonConfigIos():
return $default(_that.orderToken,_that.amount,_that.currency,_that.email,_that.shouldRequestShipping,_that.savePaymentMethodForMerchant,_that.returnURL,_that.merchantName,_that.merchantLogoURL,_that.additionalData);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String orderToken,  int amount,  String currency,  String email,  bool shouldRequestShipping,  bool savePaymentMethodForMerchant,  String? returnURL,  String? merchantName,  String? merchantLogoURL,  Map<String, dynamic>? additionalData)?  $default,) {final _that = this;
switch (_that) {
case _RevolutPayButtonConfigIos() when $default != null:
return $default(_that.orderToken,_that.amount,_that.currency,_that.email,_that.shouldRequestShipping,_that.savePaymentMethodForMerchant,_that.returnURL,_that.merchantName,_that.merchantLogoURL,_that.additionalData);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RevolutPayButtonConfigIos extends RevolutPayButtonConfigIos {
  const _RevolutPayButtonConfigIos({required this.orderToken, required this.amount, required this.currency, required this.email, this.shouldRequestShipping = false, this.savePaymentMethodForMerchant = false, this.returnURL, this.merchantName, this.merchantLogoURL,  Map<String, dynamic>? additionalData}): _additionalData = additionalData,super._();
  factory _RevolutPayButtonConfigIos.fromJson(Map<String, dynamic> json) => _$RevolutPayButtonConfigIosFromJson(json);

@override final  String orderToken;
@override final  int amount;
@override final  String currency;
@override final  String email;
@override@JsonKey() final  bool shouldRequestShipping;
@override@JsonKey() final  bool savePaymentMethodForMerchant;
@override final  String? returnURL;
@override final  String? merchantName;
@override final  String? merchantLogoURL;
 final  Map<String, dynamic>? _additionalData;
@override Map<String, dynamic>? get additionalData {
  final value = _additionalData;
  if (value == null) return null;
  if (_additionalData is EqualUnmodifiableMapView) return _additionalData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of RevolutPayButtonConfigIos
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RevolutPayButtonConfigIosCopyWith<_RevolutPayButtonConfigIos> get copyWith => __$RevolutPayButtonConfigIosCopyWithImpl<_RevolutPayButtonConfigIos>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RevolutPayButtonConfigIosToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RevolutPayButtonConfigIos&&(identical(other.orderToken, orderToken) || other.orderToken == orderToken)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.email, email) || other.email == email)&&(identical(other.shouldRequestShipping, shouldRequestShipping) || other.shouldRequestShipping == shouldRequestShipping)&&(identical(other.savePaymentMethodForMerchant, savePaymentMethodForMerchant) || other.savePaymentMethodForMerchant == savePaymentMethodForMerchant)&&(identical(other.returnURL, returnURL) || other.returnURL == returnURL)&&(identical(other.merchantName, merchantName) || other.merchantName == merchantName)&&(identical(other.merchantLogoURL, merchantLogoURL) || other.merchantLogoURL == merchantLogoURL)&&const DeepCollectionEquality().equals(other.additionalData, _additionalData));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,orderToken,amount,currency,email,shouldRequestShipping,savePaymentMethodForMerchant,returnURL,merchantName,merchantLogoURL,const DeepCollectionEquality().hash(_additionalData));
}

@override
String toString() {
    return 'RevolutPayButtonConfigIos(orderToken: $orderToken, amount: $amount, currency: $currency, email: $email, shouldRequestShipping: $shouldRequestShipping, savePaymentMethodForMerchant: $savePaymentMethodForMerchant, returnURL: $returnURL, merchantName: $merchantName, merchantLogoURL: $merchantLogoURL, additionalData: $additionalData)';
}


}

/// @nodoc
abstract mixin class _$RevolutPayButtonConfigIosCopyWith<$Res> implements $RevolutPayButtonConfigIosCopyWith<$Res> {
  factory _$RevolutPayButtonConfigIosCopyWith(_RevolutPayButtonConfigIos value, $Res Function(_RevolutPayButtonConfigIos) _then) = __$RevolutPayButtonConfigIosCopyWithImpl;
@override @useResult
$Res call({
 String orderToken, int amount, String currency, String email, bool shouldRequestShipping, bool savePaymentMethodForMerchant, String? returnURL, String? merchantName, String? merchantLogoURL, Map<String, dynamic>? additionalData
});




}
/// @nodoc
class __$RevolutPayButtonConfigIosCopyWithImpl<$Res>
    implements _$RevolutPayButtonConfigIosCopyWith<$Res> {
  __$RevolutPayButtonConfigIosCopyWithImpl(this._self, this._then);

  final _RevolutPayButtonConfigIos _self;
  final $Res Function(_RevolutPayButtonConfigIos) _then;

/// Create a copy of RevolutPayButtonConfigIos
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? orderToken = null,Object? amount = null,Object? currency = null,Object? email = null,Object? shouldRequestShipping = null,Object? savePaymentMethodForMerchant = null,Object? returnURL = freezed,Object? merchantName = freezed,Object? merchantLogoURL = freezed,Object? additionalData = freezed,}) {
  return _then(_RevolutPayButtonConfigIos(
orderToken: null == orderToken ? _self.orderToken : orderToken // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,shouldRequestShipping: null == shouldRequestShipping ? _self.shouldRequestShipping : shouldRequestShipping // ignore: cast_nullable_to_non_nullable
as bool,savePaymentMethodForMerchant: null == savePaymentMethodForMerchant ? _self.savePaymentMethodForMerchant : savePaymentMethodForMerchant // ignore: cast_nullable_to_non_nullable
as bool,returnURL: freezed == returnURL ? _self.returnURL : returnURL // ignore: cast_nullable_to_non_nullable
as String?,merchantName: freezed == merchantName ? _self.merchantName : merchantName // ignore: cast_nullable_to_non_nullable
as String?,merchantLogoURL: freezed == merchantLogoURL ? _self.merchantLogoURL : merchantLogoURL // ignore: cast_nullable_to_non_nullable
as String?,additionalData: freezed == additionalData ? _self._additionalData : additionalData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

// dart format on
