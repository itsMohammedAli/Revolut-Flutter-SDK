// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'callback_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RevolutLogEntry {

@JsonKey(fromJson: _logLevelFromJson, toJson: _logLevelToJson) RevolutLogLevel get level; String get message;@EpochMillisecondsConverter() DateTime get timestamp; String get source;
/// Create a copy of RevolutLogEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RevolutLogEntryCopyWith<RevolutLogEntry> get copyWith => _$RevolutLogEntryCopyWithImpl<RevolutLogEntry>(this as RevolutLogEntry, _$identity);

  /// Serializes this RevolutLogEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as RevolutLogEntry;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RevolutLogEntry&&(identical(other.level, _this.level) || other.level == _this.level)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.timestamp, _this.timestamp) || other.timestamp == _this.timestamp)&&(identical(other.source, _this.source) || other.source == _this.source));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RevolutLogEntry;
  return Object.hash(runtimeType,_this.level,_this.message,_this.timestamp,_this.source);
}



}

/// @nodoc
abstract mixin class $RevolutLogEntryCopyWith<$Res>  {
  factory $RevolutLogEntryCopyWith(RevolutLogEntry value, $Res Function(RevolutLogEntry) _then) = _$RevolutLogEntryCopyWithImpl;
@useResult
$Res call({
@JsonKey(fromJson: _logLevelFromJson, toJson: _logLevelToJson) RevolutLogLevel level, String message,@EpochMillisecondsConverter() DateTime timestamp, String source
});




}
/// @nodoc
class _$RevolutLogEntryCopyWithImpl<$Res>
    implements $RevolutLogEntryCopyWith<$Res> {
  _$RevolutLogEntryCopyWithImpl(this._self, this._then);

  final RevolutLogEntry _self;
  final $Res Function(RevolutLogEntry) _then;

/// Create a copy of RevolutLogEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? level = null,Object? message = null,Object? timestamp = null,Object? source = null,}) {
  return _then(RevolutLogEntry(
level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as RevolutLogLevel,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RevolutLogEntry].
extension RevolutLogEntryPatterns on RevolutLogEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RevolutLogEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RevolutLogEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RevolutLogEntry value)  $default,){
final _that = this;
switch (_that) {
case _RevolutLogEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RevolutLogEntry value)?  $default,){
final _that = this;
switch (_that) {
case _RevolutLogEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _logLevelFromJson, toJson: _logLevelToJson)  RevolutLogLevel level,  String message, @EpochMillisecondsConverter()  DateTime timestamp,  String source)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RevolutLogEntry() when $default != null:
return $default(_that.level,_that.message,_that.timestamp,_that.source);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _logLevelFromJson, toJson: _logLevelToJson)  RevolutLogLevel level,  String message, @EpochMillisecondsConverter()  DateTime timestamp,  String source)  $default,) {final _that = this;
switch (_that) {
case _RevolutLogEntry():
return $default(_that.level,_that.message,_that.timestamp,_that.source);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(fromJson: _logLevelFromJson, toJson: _logLevelToJson)  RevolutLogLevel level,  String message, @EpochMillisecondsConverter()  DateTime timestamp,  String source)?  $default,) {final _that = this;
switch (_that) {
case _RevolutLogEntry() when $default != null:
return $default(_that.level,_that.message,_that.timestamp,_that.source);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RevolutLogEntry extends RevolutLogEntry {
  const _RevolutLogEntry({@JsonKey(fromJson: _logLevelFromJson, toJson: _logLevelToJson) required this.level, this.message = '', @EpochMillisecondsConverter() required this.timestamp, this.source = 'Unknown'}): super._();
  factory _RevolutLogEntry.fromJson(Map<String, dynamic> json) => _$RevolutLogEntryFromJson(json);

@override@JsonKey(fromJson: _logLevelFromJson, toJson: _logLevelToJson) final  RevolutLogLevel level;
@override@JsonKey() final  String message;
@override@EpochMillisecondsConverter() final  DateTime timestamp;
@override@JsonKey() final  String source;

/// Create a copy of RevolutLogEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RevolutLogEntryCopyWith<_RevolutLogEntry> get copyWith => __$RevolutLogEntryCopyWithImpl<_RevolutLogEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RevolutLogEntryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RevolutLogEntry&&(identical(other.level, level) || other.level == level)&&(identical(other.message, message) || other.message == message)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.source, source) || other.source == source));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,level,message,timestamp,source);
}



}

/// @nodoc
abstract mixin class _$RevolutLogEntryCopyWith<$Res> implements $RevolutLogEntryCopyWith<$Res> {
  factory _$RevolutLogEntryCopyWith(_RevolutLogEntry value, $Res Function(_RevolutLogEntry) _then) = __$RevolutLogEntryCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(fromJson: _logLevelFromJson, toJson: _logLevelToJson) RevolutLogLevel level, String message,@EpochMillisecondsConverter() DateTime timestamp, String source
});




}
/// @nodoc
class __$RevolutLogEntryCopyWithImpl<$Res>
    implements _$RevolutLogEntryCopyWith<$Res> {
  __$RevolutLogEntryCopyWithImpl(this._self, this._then);

  final _RevolutLogEntry _self;
  final $Res Function(_RevolutLogEntry) _then;

/// Create a copy of RevolutLogEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? level = null,Object? message = null,Object? timestamp = null,Object? source = null,}) {
  return _then(_RevolutLogEntry(
level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as RevolutLogLevel,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$RevolutPaymentResult {

 bool get success; String get message; String get error;@EpochMillisecondsConverter() DateTime get timestamp;
/// Create a copy of RevolutPaymentResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RevolutPaymentResultCopyWith<RevolutPaymentResult> get copyWith => _$RevolutPaymentResultCopyWithImpl<RevolutPaymentResult>(this as RevolutPaymentResult, _$identity);

  /// Serializes this RevolutPaymentResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as RevolutPaymentResult;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RevolutPaymentResult&&(identical(other.success, _this.success) || other.success == _this.success)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.error, _this.error) || other.error == _this.error)&&(identical(other.timestamp, _this.timestamp) || other.timestamp == _this.timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RevolutPaymentResult;
  return Object.hash(runtimeType,_this.success,_this.message,_this.error,_this.timestamp);
}



}

/// @nodoc
abstract mixin class $RevolutPaymentResultCopyWith<$Res>  {
  factory $RevolutPaymentResultCopyWith(RevolutPaymentResult value, $Res Function(RevolutPaymentResult) _then) = _$RevolutPaymentResultCopyWithImpl;
@useResult
$Res call({
 bool success, String message, String error,@EpochMillisecondsConverter() DateTime timestamp
});




}
/// @nodoc
class _$RevolutPaymentResultCopyWithImpl<$Res>
    implements $RevolutPaymentResultCopyWith<$Res> {
  _$RevolutPaymentResultCopyWithImpl(this._self, this._then);

  final RevolutPaymentResult _self;
  final $Res Function(RevolutPaymentResult) _then;

/// Create a copy of RevolutPaymentResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? message = null,Object? error = null,Object? timestamp = null,}) {
  return _then(RevolutPaymentResult(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [RevolutPaymentResult].
extension RevolutPaymentResultPatterns on RevolutPaymentResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RevolutPaymentResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RevolutPaymentResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RevolutPaymentResult value)  $default,){
final _that = this;
switch (_that) {
case _RevolutPaymentResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RevolutPaymentResult value)?  $default,){
final _that = this;
switch (_that) {
case _RevolutPaymentResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String message,  String error, @EpochMillisecondsConverter()  DateTime timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RevolutPaymentResult() when $default != null:
return $default(_that.success,_that.message,_that.error,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String message,  String error, @EpochMillisecondsConverter()  DateTime timestamp)  $default,) {final _that = this;
switch (_that) {
case _RevolutPaymentResult():
return $default(_that.success,_that.message,_that.error,_that.timestamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String message,  String error, @EpochMillisecondsConverter()  DateTime timestamp)?  $default,) {final _that = this;
switch (_that) {
case _RevolutPaymentResult() when $default != null:
return $default(_that.success,_that.message,_that.error,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RevolutPaymentResult extends RevolutPaymentResult {
  const _RevolutPaymentResult({this.success = false, this.message = '', this.error = '', @EpochMillisecondsConverter() required this.timestamp}): super._();
  factory _RevolutPaymentResult.fromJson(Map<String, dynamic> json) => _$RevolutPaymentResultFromJson(json);

@override@JsonKey() final  bool success;
@override@JsonKey() final  String message;
@override@JsonKey() final  String error;
@override@EpochMillisecondsConverter() final  DateTime timestamp;

/// Create a copy of RevolutPaymentResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RevolutPaymentResultCopyWith<_RevolutPaymentResult> get copyWith => __$RevolutPaymentResultCopyWithImpl<_RevolutPaymentResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RevolutPaymentResultToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RevolutPaymentResult&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.error, error) || other.error == error)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,success,message,error,timestamp);
}



}

/// @nodoc
abstract mixin class _$RevolutPaymentResultCopyWith<$Res> implements $RevolutPaymentResultCopyWith<$Res> {
  factory _$RevolutPaymentResultCopyWith(_RevolutPaymentResult value, $Res Function(_RevolutPaymentResult) _then) = __$RevolutPaymentResultCopyWithImpl;
@override @useResult
$Res call({
 bool success, String message, String error,@EpochMillisecondsConverter() DateTime timestamp
});




}
/// @nodoc
class __$RevolutPaymentResultCopyWithImpl<$Res>
    implements _$RevolutPaymentResultCopyWith<$Res> {
  __$RevolutPaymentResultCopyWithImpl(this._self, this._then);

  final _RevolutPaymentResult _self;
  final $Res Function(_RevolutPaymentResult) _then;

/// Create a copy of RevolutPaymentResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? message = null,Object? error = null,Object? timestamp = null,}) {
  return _then(_RevolutPaymentResult(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
