// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'revolut_pay_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CustomerData {

 String? get name; String? get email; String? get phone; DateOfBirthData? get dateOfBirth; String? get country;
/// Create a copy of CustomerData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomerDataCopyWith<CustomerData> get copyWith => _$CustomerDataCopyWithImpl<CustomerData>(this as CustomerData, _$identity);

  /// Serializes this CustomerData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CustomerData;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomerData&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.phone, _this.phone) || other.phone == _this.phone)&&(identical(other.dateOfBirth, _this.dateOfBirth) || other.dateOfBirth == _this.dateOfBirth)&&(identical(other.country, _this.country) || other.country == _this.country));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CustomerData;
  return Object.hash(runtimeType,_this.name,_this.email,_this.phone,_this.dateOfBirth,_this.country);
}

@override
String toString() {
  final _this = this as CustomerData;
  return 'CustomerData(name: ${_this.name}, email: ${_this.email}, phone: ${_this.phone}, dateOfBirth: ${_this.dateOfBirth}, country: ${_this.country})';
}


}

/// @nodoc
abstract mixin class $CustomerDataCopyWith<$Res>  {
  factory $CustomerDataCopyWith(CustomerData value, $Res Function(CustomerData) _then) = _$CustomerDataCopyWithImpl;
@useResult
$Res call({
 String? name, String? email, String? phone, DateOfBirthData? dateOfBirth, String? country
});


$DateOfBirthDataCopyWith<$Res>? get dateOfBirth;

}
/// @nodoc
class _$CustomerDataCopyWithImpl<$Res>
    implements $CustomerDataCopyWith<$Res> {
  _$CustomerDataCopyWithImpl(this._self, this._then);

  final CustomerData _self;
  final $Res Function(CustomerData) _then;

/// Create a copy of CustomerData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = freezed,Object? email = freezed,Object? phone = freezed,Object? dateOfBirth = freezed,Object? country = freezed,}) {
  return _then(CustomerData(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as DateOfBirthData?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of CustomerData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DateOfBirthDataCopyWith<$Res>? get dateOfBirth {
    if (_self.dateOfBirth == null) {
    return null;
  }

  return $DateOfBirthDataCopyWith<$Res>(_self.dateOfBirth!, (value) {
    return _then(_self.copyWith(dateOfBirth: value));
  });
}
}


/// Adds pattern-matching-related methods to [CustomerData].
extension CustomerDataPatterns on CustomerData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CustomerData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CustomerData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CustomerData value)  $default,){
final _that = this;
switch (_that) {
case _CustomerData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CustomerData value)?  $default,){
final _that = this;
switch (_that) {
case _CustomerData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? name,  String? email,  String? phone,  DateOfBirthData? dateOfBirth,  String? country)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CustomerData() when $default != null:
return $default(_that.name,_that.email,_that.phone,_that.dateOfBirth,_that.country);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? name,  String? email,  String? phone,  DateOfBirthData? dateOfBirth,  String? country)  $default,) {final _that = this;
switch (_that) {
case _CustomerData():
return $default(_that.name,_that.email,_that.phone,_that.dateOfBirth,_that.country);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? name,  String? email,  String? phone,  DateOfBirthData? dateOfBirth,  String? country)?  $default,) {final _that = this;
switch (_that) {
case _CustomerData() when $default != null:
return $default(_that.name,_that.email,_that.phone,_that.dateOfBirth,_that.country);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CustomerData extends CustomerData {
  const _CustomerData({this.name, this.email, this.phone, this.dateOfBirth, this.country}): super._();
  factory _CustomerData.fromJson(Map<String, dynamic> json) => _$CustomerDataFromJson(json);

@override final  String? name;
@override final  String? email;
@override final  String? phone;
@override final  DateOfBirthData? dateOfBirth;
@override final  String? country;

/// Create a copy of CustomerData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomerDataCopyWith<_CustomerData> get copyWith => __$CustomerDataCopyWithImpl<_CustomerData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CustomerDataToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CustomerData&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.country, country) || other.country == country));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,name,email,phone,dateOfBirth,country);
}

@override
String toString() {
    return 'CustomerData(name: $name, email: $email, phone: $phone, dateOfBirth: $dateOfBirth, country: $country)';
}


}

/// @nodoc
abstract mixin class _$CustomerDataCopyWith<$Res> implements $CustomerDataCopyWith<$Res> {
  factory _$CustomerDataCopyWith(_CustomerData value, $Res Function(_CustomerData) _then) = __$CustomerDataCopyWithImpl;
@override @useResult
$Res call({
 String? name, String? email, String? phone, DateOfBirthData? dateOfBirth, String? country
});


@override $DateOfBirthDataCopyWith<$Res>? get dateOfBirth;

}
/// @nodoc
class __$CustomerDataCopyWithImpl<$Res>
    implements _$CustomerDataCopyWith<$Res> {
  __$CustomerDataCopyWithImpl(this._self, this._then);

  final _CustomerData _self;
  final $Res Function(_CustomerData) _then;

/// Create a copy of CustomerData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = freezed,Object? email = freezed,Object? phone = freezed,Object? dateOfBirth = freezed,Object? country = freezed,}) {
  return _then(_CustomerData(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as DateOfBirthData?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of CustomerData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DateOfBirthDataCopyWith<$Res>? get dateOfBirth {
    if (_self.dateOfBirth == null) {
    return null;
  }

  return $DateOfBirthDataCopyWith<$Res>(_self.dateOfBirth!, (value) {
    return _then(_self.copyWith(dateOfBirth: value));
  });
}
}


/// @nodoc
mixin _$DateOfBirthData {

 int get day; int get month; int get year;
/// Create a copy of DateOfBirthData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DateOfBirthDataCopyWith<DateOfBirthData> get copyWith => _$DateOfBirthDataCopyWithImpl<DateOfBirthData>(this as DateOfBirthData, _$identity);

  /// Serializes this DateOfBirthData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DateOfBirthData;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DateOfBirthData&&(identical(other.day, _this.day) || other.day == _this.day)&&(identical(other.month, _this.month) || other.month == _this.month)&&(identical(other.year, _this.year) || other.year == _this.year));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DateOfBirthData;
  return Object.hash(runtimeType,_this.day,_this.month,_this.year);
}

@override
String toString() {
  final _this = this as DateOfBirthData;
  return 'DateOfBirthData(day: ${_this.day}, month: ${_this.month}, year: ${_this.year})';
}


}

/// @nodoc
abstract mixin class $DateOfBirthDataCopyWith<$Res>  {
  factory $DateOfBirthDataCopyWith(DateOfBirthData value, $Res Function(DateOfBirthData) _then) = _$DateOfBirthDataCopyWithImpl;
@useResult
$Res call({
 int day, int month, int year
});




}
/// @nodoc
class _$DateOfBirthDataCopyWithImpl<$Res>
    implements $DateOfBirthDataCopyWith<$Res> {
  _$DateOfBirthDataCopyWithImpl(this._self, this._then);

  final DateOfBirthData _self;
  final $Res Function(DateOfBirthData) _then;

/// Create a copy of DateOfBirthData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? day = null,Object? month = null,Object? year = null,}) {
  return _then(DateOfBirthData(
day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DateOfBirthData].
extension DateOfBirthDataPatterns on DateOfBirthData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DateOfBirthData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DateOfBirthData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DateOfBirthData value)  $default,){
final _that = this;
switch (_that) {
case _DateOfBirthData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DateOfBirthData value)?  $default,){
final _that = this;
switch (_that) {
case _DateOfBirthData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int day,  int month,  int year)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DateOfBirthData() when $default != null:
return $default(_that.day,_that.month,_that.year);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int day,  int month,  int year)  $default,) {final _that = this;
switch (_that) {
case _DateOfBirthData():
return $default(_that.day,_that.month,_that.year);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int day,  int month,  int year)?  $default,) {final _that = this;
switch (_that) {
case _DateOfBirthData() when $default != null:
return $default(_that.day,_that.month,_that.year);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DateOfBirthData extends DateOfBirthData {
  const _DateOfBirthData({required this.day, required this.month, required this.year}): super._();
  factory _DateOfBirthData.fromJson(Map<String, dynamic> json) => _$DateOfBirthDataFromJson(json);

@override final  int day;
@override final  int month;
@override final  int year;

/// Create a copy of DateOfBirthData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DateOfBirthDataCopyWith<_DateOfBirthData> get copyWith => __$DateOfBirthDataCopyWithImpl<_DateOfBirthData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DateOfBirthDataToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DateOfBirthData&&(identical(other.day, day) || other.day == day)&&(identical(other.month, month) || other.month == month)&&(identical(other.year, year) || other.year == year));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,day,month,year);
}

@override
String toString() {
    return 'DateOfBirthData(day: $day, month: $month, year: $year)';
}


}

/// @nodoc
abstract mixin class _$DateOfBirthDataCopyWith<$Res> implements $DateOfBirthDataCopyWith<$Res> {
  factory _$DateOfBirthDataCopyWith(_DateOfBirthData value, $Res Function(_DateOfBirthData) _then) = __$DateOfBirthDataCopyWithImpl;
@override @useResult
$Res call({
 int day, int month, int year
});




}
/// @nodoc
class __$DateOfBirthDataCopyWithImpl<$Res>
    implements _$DateOfBirthDataCopyWith<$Res> {
  __$DateOfBirthDataCopyWithImpl(this._self, this._then);

  final _DateOfBirthData _self;
  final $Res Function(_DateOfBirthData) _then;

/// Create a copy of DateOfBirthData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? day = null,Object? month = null,Object? year = null,}) {
  return _then(_DateOfBirthData(
day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ButtonParamsData {

@JsonKey(unknownEnumValue: ButtonRadius.medium) ButtonRadius get radius;@JsonKey(unknownEnumValue: ButtonSize.large) ButtonSize get size;@JsonKey(unknownEnumValue: BoxText.none) BoxText get boxText; String? get boxTextCurrency; VariantModesData? get variantModes;
/// Create a copy of ButtonParamsData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ButtonParamsDataCopyWith<ButtonParamsData> get copyWith => _$ButtonParamsDataCopyWithImpl<ButtonParamsData>(this as ButtonParamsData, _$identity);

  /// Serializes this ButtonParamsData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ButtonParamsData;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ButtonParamsData&&(identical(other.radius, _this.radius) || other.radius == _this.radius)&&(identical(other.size, _this.size) || other.size == _this.size)&&(identical(other.boxText, _this.boxText) || other.boxText == _this.boxText)&&(identical(other.boxTextCurrency, _this.boxTextCurrency) || other.boxTextCurrency == _this.boxTextCurrency)&&(identical(other.variantModes, _this.variantModes) || other.variantModes == _this.variantModes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ButtonParamsData;
  return Object.hash(runtimeType,_this.radius,_this.size,_this.boxText,_this.boxTextCurrency,_this.variantModes);
}

@override
String toString() {
  final _this = this as ButtonParamsData;
  return 'ButtonParamsData(radius: ${_this.radius}, size: ${_this.size}, boxText: ${_this.boxText}, boxTextCurrency: ${_this.boxTextCurrency}, variantModes: ${_this.variantModes})';
}


}

/// @nodoc
abstract mixin class $ButtonParamsDataCopyWith<$Res>  {
  factory $ButtonParamsDataCopyWith(ButtonParamsData value, $Res Function(ButtonParamsData) _then) = _$ButtonParamsDataCopyWithImpl;
@useResult
$Res call({
@JsonKey(unknownEnumValue: ButtonRadius.medium) ButtonRadius radius,@JsonKey(unknownEnumValue: ButtonSize.large) ButtonSize size,@JsonKey(unknownEnumValue: BoxText.none) BoxText boxText, String? boxTextCurrency, VariantModesData? variantModes
});


$VariantModesDataCopyWith<$Res>? get variantModes;

}
/// @nodoc
class _$ButtonParamsDataCopyWithImpl<$Res>
    implements $ButtonParamsDataCopyWith<$Res> {
  _$ButtonParamsDataCopyWithImpl(this._self, this._then);

  final ButtonParamsData _self;
  final $Res Function(ButtonParamsData) _then;

/// Create a copy of ButtonParamsData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? radius = null,Object? size = null,Object? boxText = null,Object? boxTextCurrency = freezed,Object? variantModes = freezed,}) {
  return _then(ButtonParamsData(
radius: null == radius ? _self.radius : radius // ignore: cast_nullable_to_non_nullable
as ButtonRadius,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as ButtonSize,boxText: null == boxText ? _self.boxText : boxText // ignore: cast_nullable_to_non_nullable
as BoxText,boxTextCurrency: freezed == boxTextCurrency ? _self.boxTextCurrency : boxTextCurrency // ignore: cast_nullable_to_non_nullable
as String?,variantModes: freezed == variantModes ? _self.variantModes : variantModes // ignore: cast_nullable_to_non_nullable
as VariantModesData?,
  ));
}
/// Create a copy of ButtonParamsData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VariantModesDataCopyWith<$Res>? get variantModes {
    if (_self.variantModes == null) {
    return null;
  }

  return $VariantModesDataCopyWith<$Res>(_self.variantModes!, (value) {
    return _then(_self.copyWith(variantModes: value));
  });
}
}


/// Adds pattern-matching-related methods to [ButtonParamsData].
extension ButtonParamsDataPatterns on ButtonParamsData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ButtonParamsData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ButtonParamsData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ButtonParamsData value)  $default,){
final _that = this;
switch (_that) {
case _ButtonParamsData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ButtonParamsData value)?  $default,){
final _that = this;
switch (_that) {
case _ButtonParamsData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(unknownEnumValue: ButtonRadius.medium)  ButtonRadius radius, @JsonKey(unknownEnumValue: ButtonSize.large)  ButtonSize size, @JsonKey(unknownEnumValue: BoxText.none)  BoxText boxText,  String? boxTextCurrency,  VariantModesData? variantModes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ButtonParamsData() when $default != null:
return $default(_that.radius,_that.size,_that.boxText,_that.boxTextCurrency,_that.variantModes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(unknownEnumValue: ButtonRadius.medium)  ButtonRadius radius, @JsonKey(unknownEnumValue: ButtonSize.large)  ButtonSize size, @JsonKey(unknownEnumValue: BoxText.none)  BoxText boxText,  String? boxTextCurrency,  VariantModesData? variantModes)  $default,) {final _that = this;
switch (_that) {
case _ButtonParamsData():
return $default(_that.radius,_that.size,_that.boxText,_that.boxTextCurrency,_that.variantModes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(unknownEnumValue: ButtonRadius.medium)  ButtonRadius radius, @JsonKey(unknownEnumValue: ButtonSize.large)  ButtonSize size, @JsonKey(unknownEnumValue: BoxText.none)  BoxText boxText,  String? boxTextCurrency,  VariantModesData? variantModes)?  $default,) {final _that = this;
switch (_that) {
case _ButtonParamsData() when $default != null:
return $default(_that.radius,_that.size,_that.boxText,_that.boxTextCurrency,_that.variantModes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ButtonParamsData extends ButtonParamsData {
  const _ButtonParamsData({@JsonKey(unknownEnumValue: ButtonRadius.medium) this.radius = ButtonRadius.medium, @JsonKey(unknownEnumValue: ButtonSize.large) this.size = ButtonSize.large, @JsonKey(unknownEnumValue: BoxText.none) this.boxText = BoxText.none, this.boxTextCurrency, this.variantModes}): super._();
  factory _ButtonParamsData.fromJson(Map<String, dynamic> json) => _$ButtonParamsDataFromJson(json);

@override@JsonKey(unknownEnumValue: ButtonRadius.medium) final  ButtonRadius radius;
@override@JsonKey(unknownEnumValue: ButtonSize.large) final  ButtonSize size;
@override@JsonKey(unknownEnumValue: BoxText.none) final  BoxText boxText;
@override final  String? boxTextCurrency;
@override final  VariantModesData? variantModes;

/// Create a copy of ButtonParamsData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ButtonParamsDataCopyWith<_ButtonParamsData> get copyWith => __$ButtonParamsDataCopyWithImpl<_ButtonParamsData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ButtonParamsDataToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ButtonParamsData&&(identical(other.radius, radius) || other.radius == radius)&&(identical(other.size, size) || other.size == size)&&(identical(other.boxText, boxText) || other.boxText == boxText)&&(identical(other.boxTextCurrency, boxTextCurrency) || other.boxTextCurrency == boxTextCurrency)&&(identical(other.variantModes, variantModes) || other.variantModes == variantModes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,radius,size,boxText,boxTextCurrency,variantModes);
}

@override
String toString() {
    return 'ButtonParamsData(radius: $radius, size: $size, boxText: $boxText, boxTextCurrency: $boxTextCurrency, variantModes: $variantModes)';
}


}

/// @nodoc
abstract mixin class _$ButtonParamsDataCopyWith<$Res> implements $ButtonParamsDataCopyWith<$Res> {
  factory _$ButtonParamsDataCopyWith(_ButtonParamsData value, $Res Function(_ButtonParamsData) _then) = __$ButtonParamsDataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(unknownEnumValue: ButtonRadius.medium) ButtonRadius radius,@JsonKey(unknownEnumValue: ButtonSize.large) ButtonSize size,@JsonKey(unknownEnumValue: BoxText.none) BoxText boxText, String? boxTextCurrency, VariantModesData? variantModes
});


@override $VariantModesDataCopyWith<$Res>? get variantModes;

}
/// @nodoc
class __$ButtonParamsDataCopyWithImpl<$Res>
    implements _$ButtonParamsDataCopyWith<$Res> {
  __$ButtonParamsDataCopyWithImpl(this._self, this._then);

  final _ButtonParamsData _self;
  final $Res Function(_ButtonParamsData) _then;

/// Create a copy of ButtonParamsData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? radius = null,Object? size = null,Object? boxText = null,Object? boxTextCurrency = freezed,Object? variantModes = freezed,}) {
  return _then(_ButtonParamsData(
radius: null == radius ? _self.radius : radius // ignore: cast_nullable_to_non_nullable
as ButtonRadius,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as ButtonSize,boxText: null == boxText ? _self.boxText : boxText // ignore: cast_nullable_to_non_nullable
as BoxText,boxTextCurrency: freezed == boxTextCurrency ? _self.boxTextCurrency : boxTextCurrency // ignore: cast_nullable_to_non_nullable
as String?,variantModes: freezed == variantModes ? _self.variantModes : variantModes // ignore: cast_nullable_to_non_nullable
as VariantModesData?,
  ));
}

/// Create a copy of ButtonParamsData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VariantModesDataCopyWith<$Res>? get variantModes {
    if (_self.variantModes == null) {
    return null;
  }

  return $VariantModesDataCopyWith<$Res>(_self.variantModes!, (value) {
    return _then(_self.copyWith(variantModes: value));
  });
}
}


/// @nodoc
mixin _$VariantModesData {

@JsonKey(unknownEnumValue: ButtonVariant.dark) ButtonVariant get darkTheme;@JsonKey(unknownEnumValue: ButtonVariant.light) ButtonVariant get lightTheme;
/// Create a copy of VariantModesData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VariantModesDataCopyWith<VariantModesData> get copyWith => _$VariantModesDataCopyWithImpl<VariantModesData>(this as VariantModesData, _$identity);

  /// Serializes this VariantModesData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as VariantModesData;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VariantModesData&&(identical(other.darkTheme, _this.darkTheme) || other.darkTheme == _this.darkTheme)&&(identical(other.lightTheme, _this.lightTheme) || other.lightTheme == _this.lightTheme));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as VariantModesData;
  return Object.hash(runtimeType,_this.darkTheme,_this.lightTheme);
}

@override
String toString() {
  final _this = this as VariantModesData;
  return 'VariantModesData(darkTheme: ${_this.darkTheme}, lightTheme: ${_this.lightTheme})';
}


}

/// @nodoc
abstract mixin class $VariantModesDataCopyWith<$Res>  {
  factory $VariantModesDataCopyWith(VariantModesData value, $Res Function(VariantModesData) _then) = _$VariantModesDataCopyWithImpl;
@useResult
$Res call({
@JsonKey(unknownEnumValue: ButtonVariant.dark) ButtonVariant darkTheme,@JsonKey(unknownEnumValue: ButtonVariant.light) ButtonVariant lightTheme
});




}
/// @nodoc
class _$VariantModesDataCopyWithImpl<$Res>
    implements $VariantModesDataCopyWith<$Res> {
  _$VariantModesDataCopyWithImpl(this._self, this._then);

  final VariantModesData _self;
  final $Res Function(VariantModesData) _then;

/// Create a copy of VariantModesData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? darkTheme = null,Object? lightTheme = null,}) {
  return _then(VariantModesData(
darkTheme: null == darkTheme ? _self.darkTheme : darkTheme // ignore: cast_nullable_to_non_nullable
as ButtonVariant,lightTheme: null == lightTheme ? _self.lightTheme : lightTheme // ignore: cast_nullable_to_non_nullable
as ButtonVariant,
  ));
}

}


/// Adds pattern-matching-related methods to [VariantModesData].
extension VariantModesDataPatterns on VariantModesData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VariantModesData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VariantModesData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VariantModesData value)  $default,){
final _that = this;
switch (_that) {
case _VariantModesData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VariantModesData value)?  $default,){
final _that = this;
switch (_that) {
case _VariantModesData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(unknownEnumValue: ButtonVariant.dark)  ButtonVariant darkTheme, @JsonKey(unknownEnumValue: ButtonVariant.light)  ButtonVariant lightTheme)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VariantModesData() when $default != null:
return $default(_that.darkTheme,_that.lightTheme);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(unknownEnumValue: ButtonVariant.dark)  ButtonVariant darkTheme, @JsonKey(unknownEnumValue: ButtonVariant.light)  ButtonVariant lightTheme)  $default,) {final _that = this;
switch (_that) {
case _VariantModesData():
return $default(_that.darkTheme,_that.lightTheme);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(unknownEnumValue: ButtonVariant.dark)  ButtonVariant darkTheme, @JsonKey(unknownEnumValue: ButtonVariant.light)  ButtonVariant lightTheme)?  $default,) {final _that = this;
switch (_that) {
case _VariantModesData() when $default != null:
return $default(_that.darkTheme,_that.lightTheme);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VariantModesData extends VariantModesData {
  const _VariantModesData({@JsonKey(unknownEnumValue: ButtonVariant.dark) this.darkTheme = ButtonVariant.dark, @JsonKey(unknownEnumValue: ButtonVariant.light) this.lightTheme = ButtonVariant.light}): super._();
  factory _VariantModesData.fromJson(Map<String, dynamic> json) => _$VariantModesDataFromJson(json);

@override@JsonKey(unknownEnumValue: ButtonVariant.dark) final  ButtonVariant darkTheme;
@override@JsonKey(unknownEnumValue: ButtonVariant.light) final  ButtonVariant lightTheme;

/// Create a copy of VariantModesData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VariantModesDataCopyWith<_VariantModesData> get copyWith => __$VariantModesDataCopyWithImpl<_VariantModesData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VariantModesDataToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _VariantModesData&&(identical(other.darkTheme, darkTheme) || other.darkTheme == darkTheme)&&(identical(other.lightTheme, lightTheme) || other.lightTheme == lightTheme));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,darkTheme,lightTheme);
}

@override
String toString() {
    return 'VariantModesData(darkTheme: $darkTheme, lightTheme: $lightTheme)';
}


}

/// @nodoc
abstract mixin class _$VariantModesDataCopyWith<$Res> implements $VariantModesDataCopyWith<$Res> {
  factory _$VariantModesDataCopyWith(_VariantModesData value, $Res Function(_VariantModesData) _then) = __$VariantModesDataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(unknownEnumValue: ButtonVariant.dark) ButtonVariant darkTheme,@JsonKey(unknownEnumValue: ButtonVariant.light) ButtonVariant lightTheme
});




}
/// @nodoc
class __$VariantModesDataCopyWithImpl<$Res>
    implements _$VariantModesDataCopyWith<$Res> {
  __$VariantModesDataCopyWithImpl(this._self, this._then);

  final _VariantModesData _self;
  final $Res Function(_VariantModesData) _then;

/// Create a copy of VariantModesData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? darkTheme = null,Object? lightTheme = null,}) {
  return _then(_VariantModesData(
darkTheme: null == darkTheme ? _self.darkTheme : darkTheme // ignore: cast_nullable_to_non_nullable
as ButtonVariant,lightTheme: null == lightTheme ? _self.lightTheme : lightTheme // ignore: cast_nullable_to_non_nullable
as ButtonVariant,
  ));
}


}


/// @nodoc
mixin _$PromoBannerParamsData {

 String get transactionId; int get paymentAmount;@JsonKey(unknownEnumValue: RevolutCurrency.gbp) RevolutCurrency get currency; CustomerData? get customer;
/// Create a copy of PromoBannerParamsData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PromoBannerParamsDataCopyWith<PromoBannerParamsData> get copyWith => _$PromoBannerParamsDataCopyWithImpl<PromoBannerParamsData>(this as PromoBannerParamsData, _$identity);

  /// Serializes this PromoBannerParamsData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PromoBannerParamsData;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PromoBannerParamsData&&(identical(other.transactionId, _this.transactionId) || other.transactionId == _this.transactionId)&&(identical(other.paymentAmount, _this.paymentAmount) || other.paymentAmount == _this.paymentAmount)&&(identical(other.currency, _this.currency) || other.currency == _this.currency)&&(identical(other.customer, _this.customer) || other.customer == _this.customer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PromoBannerParamsData;
  return Object.hash(runtimeType,_this.transactionId,_this.paymentAmount,_this.currency,_this.customer);
}

@override
String toString() {
  final _this = this as PromoBannerParamsData;
  return 'PromoBannerParamsData(transactionId: ${_this.transactionId}, paymentAmount: ${_this.paymentAmount}, currency: ${_this.currency}, customer: ${_this.customer})';
}


}

/// @nodoc
abstract mixin class $PromoBannerParamsDataCopyWith<$Res>  {
  factory $PromoBannerParamsDataCopyWith(PromoBannerParamsData value, $Res Function(PromoBannerParamsData) _then) = _$PromoBannerParamsDataCopyWithImpl;
@useResult
$Res call({
 String transactionId, int paymentAmount,@JsonKey(unknownEnumValue: RevolutCurrency.gbp) RevolutCurrency currency, CustomerData? customer
});


$CustomerDataCopyWith<$Res>? get customer;

}
/// @nodoc
class _$PromoBannerParamsDataCopyWithImpl<$Res>
    implements $PromoBannerParamsDataCopyWith<$Res> {
  _$PromoBannerParamsDataCopyWithImpl(this._self, this._then);

  final PromoBannerParamsData _self;
  final $Res Function(PromoBannerParamsData) _then;

/// Create a copy of PromoBannerParamsData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? transactionId = null,Object? paymentAmount = null,Object? currency = null,Object? customer = freezed,}) {
  return _then(PromoBannerParamsData(
transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String,paymentAmount: null == paymentAmount ? _self.paymentAmount : paymentAmount // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as RevolutCurrency,customer: freezed == customer ? _self.customer : customer // ignore: cast_nullable_to_non_nullable
as CustomerData?,
  ));
}
/// Create a copy of PromoBannerParamsData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CustomerDataCopyWith<$Res>? get customer {
    if (_self.customer == null) {
    return null;
  }

  return $CustomerDataCopyWith<$Res>(_self.customer!, (value) {
    return _then(_self.copyWith(customer: value));
  });
}
}


/// Adds pattern-matching-related methods to [PromoBannerParamsData].
extension PromoBannerParamsDataPatterns on PromoBannerParamsData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PromoBannerParamsData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PromoBannerParamsData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PromoBannerParamsData value)  $default,){
final _that = this;
switch (_that) {
case _PromoBannerParamsData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PromoBannerParamsData value)?  $default,){
final _that = this;
switch (_that) {
case _PromoBannerParamsData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String transactionId,  int paymentAmount, @JsonKey(unknownEnumValue: RevolutCurrency.gbp)  RevolutCurrency currency,  CustomerData? customer)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PromoBannerParamsData() when $default != null:
return $default(_that.transactionId,_that.paymentAmount,_that.currency,_that.customer);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String transactionId,  int paymentAmount, @JsonKey(unknownEnumValue: RevolutCurrency.gbp)  RevolutCurrency currency,  CustomerData? customer)  $default,) {final _that = this;
switch (_that) {
case _PromoBannerParamsData():
return $default(_that.transactionId,_that.paymentAmount,_that.currency,_that.customer);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String transactionId,  int paymentAmount, @JsonKey(unknownEnumValue: RevolutCurrency.gbp)  RevolutCurrency currency,  CustomerData? customer)?  $default,) {final _that = this;
switch (_that) {
case _PromoBannerParamsData() when $default != null:
return $default(_that.transactionId,_that.paymentAmount,_that.currency,_that.customer);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PromoBannerParamsData extends PromoBannerParamsData {
  const _PromoBannerParamsData({required this.transactionId, required this.paymentAmount, @JsonKey(unknownEnumValue: RevolutCurrency.gbp) required this.currency, this.customer}): super._();
  factory _PromoBannerParamsData.fromJson(Map<String, dynamic> json) => _$PromoBannerParamsDataFromJson(json);

@override final  String transactionId;
@override final  int paymentAmount;
@override@JsonKey(unknownEnumValue: RevolutCurrency.gbp) final  RevolutCurrency currency;
@override final  CustomerData? customer;

/// Create a copy of PromoBannerParamsData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PromoBannerParamsDataCopyWith<_PromoBannerParamsData> get copyWith => __$PromoBannerParamsDataCopyWithImpl<_PromoBannerParamsData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PromoBannerParamsDataToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PromoBannerParamsData&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.paymentAmount, paymentAmount) || other.paymentAmount == paymentAmount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.customer, customer) || other.customer == customer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,transactionId,paymentAmount,currency,customer);
}

@override
String toString() {
    return 'PromoBannerParamsData(transactionId: $transactionId, paymentAmount: $paymentAmount, currency: $currency, customer: $customer)';
}


}

/// @nodoc
abstract mixin class _$PromoBannerParamsDataCopyWith<$Res> implements $PromoBannerParamsDataCopyWith<$Res> {
  factory _$PromoBannerParamsDataCopyWith(_PromoBannerParamsData value, $Res Function(_PromoBannerParamsData) _then) = __$PromoBannerParamsDataCopyWithImpl;
@override @useResult
$Res call({
 String transactionId, int paymentAmount,@JsonKey(unknownEnumValue: RevolutCurrency.gbp) RevolutCurrency currency, CustomerData? customer
});


@override $CustomerDataCopyWith<$Res>? get customer;

}
/// @nodoc
class __$PromoBannerParamsDataCopyWithImpl<$Res>
    implements _$PromoBannerParamsDataCopyWith<$Res> {
  __$PromoBannerParamsDataCopyWithImpl(this._self, this._then);

  final _PromoBannerParamsData _self;
  final $Res Function(_PromoBannerParamsData) _then;

/// Create a copy of PromoBannerParamsData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? transactionId = null,Object? paymentAmount = null,Object? currency = null,Object? customer = freezed,}) {
  return _then(_PromoBannerParamsData(
transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String,paymentAmount: null == paymentAmount ? _self.paymentAmount : paymentAmount // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as RevolutCurrency,customer: freezed == customer ? _self.customer : customer // ignore: cast_nullable_to_non_nullable
as CustomerData?,
  ));
}

/// Create a copy of PromoBannerParamsData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CustomerDataCopyWith<$Res>? get customer {
    if (_self.customer == null) {
    return null;
  }

  return $CustomerDataCopyWith<$Res>(_self.customer!, (value) {
    return _then(_self.copyWith(customer: value));
  });
}
}


/// @nodoc
mixin _$OrderResultData {

 bool get success; String? get orderId; String? get error; String? get cause;
/// Create a copy of OrderResultData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderResultDataCopyWith<OrderResultData> get copyWith => _$OrderResultDataCopyWithImpl<OrderResultData>(this as OrderResultData, _$identity);

  /// Serializes this OrderResultData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as OrderResultData;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderResultData&&(identical(other.success, _this.success) || other.success == _this.success)&&(identical(other.orderId, _this.orderId) || other.orderId == _this.orderId)&&(identical(other.error, _this.error) || other.error == _this.error)&&(identical(other.cause, _this.cause) || other.cause == _this.cause));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as OrderResultData;
  return Object.hash(runtimeType,_this.success,_this.orderId,_this.error,_this.cause);
}

@override
String toString() {
  final _this = this as OrderResultData;
  return 'OrderResultData(success: ${_this.success}, orderId: ${_this.orderId}, error: ${_this.error}, cause: ${_this.cause})';
}


}

/// @nodoc
abstract mixin class $OrderResultDataCopyWith<$Res>  {
  factory $OrderResultDataCopyWith(OrderResultData value, $Res Function(OrderResultData) _then) = _$OrderResultDataCopyWithImpl;
@useResult
$Res call({
 bool success, String? orderId, String? error, String? cause
});




}
/// @nodoc
class _$OrderResultDataCopyWithImpl<$Res>
    implements $OrderResultDataCopyWith<$Res> {
  _$OrderResultDataCopyWithImpl(this._self, this._then);

  final OrderResultData _self;
  final $Res Function(OrderResultData) _then;

/// Create a copy of OrderResultData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? orderId = freezed,Object? error = freezed,Object? cause = freezed,}) {
  return _then(OrderResultData(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,orderId: freezed == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,cause: freezed == cause ? _self.cause : cause // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OrderResultData].
extension OrderResultDataPatterns on OrderResultData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderResultData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderResultData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderResultData value)  $default,){
final _that = this;
switch (_that) {
case _OrderResultData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderResultData value)?  $default,){
final _that = this;
switch (_that) {
case _OrderResultData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String? orderId,  String? error,  String? cause)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderResultData() when $default != null:
return $default(_that.success,_that.orderId,_that.error,_that.cause);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String? orderId,  String? error,  String? cause)  $default,) {final _that = this;
switch (_that) {
case _OrderResultData():
return $default(_that.success,_that.orderId,_that.error,_that.cause);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String? orderId,  String? error,  String? cause)?  $default,) {final _that = this;
switch (_that) {
case _OrderResultData() when $default != null:
return $default(_that.success,_that.orderId,_that.error,_that.cause);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OrderResultData extends OrderResultData {
  const _OrderResultData({required this.success, this.orderId, this.error, this.cause}): super._();
  factory _OrderResultData.fromJson(Map<String, dynamic> json) => _$OrderResultDataFromJson(json);

@override final  bool success;
@override final  String? orderId;
@override final  String? error;
@override final  String? cause;

/// Create a copy of OrderResultData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderResultDataCopyWith<_OrderResultData> get copyWith => __$OrderResultDataCopyWithImpl<_OrderResultData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrderResultDataToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderResultData&&(identical(other.success, success) || other.success == success)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.error, error) || other.error == error)&&(identical(other.cause, cause) || other.cause == cause));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,success,orderId,error,cause);
}

@override
String toString() {
    return 'OrderResultData(success: $success, orderId: $orderId, error: $error, cause: $cause)';
}


}

/// @nodoc
abstract mixin class _$OrderResultDataCopyWith<$Res> implements $OrderResultDataCopyWith<$Res> {
  factory _$OrderResultDataCopyWith(_OrderResultData value, $Res Function(_OrderResultData) _then) = __$OrderResultDataCopyWithImpl;
@override @useResult
$Res call({
 bool success, String? orderId, String? error, String? cause
});




}
/// @nodoc
class __$OrderResultDataCopyWithImpl<$Res>
    implements _$OrderResultDataCopyWith<$Res> {
  __$OrderResultDataCopyWithImpl(this._self, this._then);

  final _OrderResultData _self;
  final $Res Function(_OrderResultData) _then;

/// Create a copy of OrderResultData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? orderId = freezed,Object? error = freezed,Object? cause = freezed,}) {
  return _then(_OrderResultData(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,orderId: freezed == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,cause: freezed == cause ? _self.cause : cause // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
