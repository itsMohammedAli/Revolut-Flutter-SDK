import 'package:freezed_annotation/freezed_annotation.dart';
import 'timestamp_converter.dart';

part 'callback_models.freezed.dart';
part 'callback_models.g.dart';

@freezed
abstract class RevolutLogEntry with _$RevolutLogEntry {
  const RevolutLogEntry._();
  const factory RevolutLogEntry({
    @JsonKey(fromJson: _logLevelFromJson, toJson: _logLevelToJson)
    required RevolutLogLevel level,
    @Default('') String message,
    @EpochMillisecondsConverter() required DateTime timestamp,
    @Default('Unknown') String source,
  }) = _RevolutLogEntry;
  factory RevolutLogEntry.fromJson(Map<String, dynamic> json) =>
      _$RevolutLogEntryFromJson(json);
  factory RevolutLogEntry.fromMap(Map<String, dynamic> map) =>
      RevolutLogEntry.fromJson(map);
  Map<String, dynamic> toMap() => toJson();
  @override
  String toString() =>
      '[${timestamp.toIso8601String()}] [$source] [${level.name.toUpperCase()}] $message';
}

enum RevolutLogLevel { info, success, warning, error }

RevolutLogLevel _logLevelFromJson(String? value) =>
    RevolutLogLevel.values.firstWhere(
      (level) => level.name == value?.toLowerCase(),
      orElse: () => RevolutLogLevel.info,
    );
String _logLevelToJson(RevolutLogLevel level) => level.name.toUpperCase();

@freezed
abstract class RevolutPaymentResult with _$RevolutPaymentResult {
  const RevolutPaymentResult._();
  const factory RevolutPaymentResult({
    @Default(false) bool success,
    @Default('') String message,
    @Default('') String error,
    @EpochMillisecondsConverter() required DateTime timestamp,
  }) = _RevolutPaymentResult;
  factory RevolutPaymentResult.fromJson(Map<String, dynamic> json) =>
      _$RevolutPaymentResultFromJson(json);
  factory RevolutPaymentResult.fromMap(Map<String, dynamic> map) =>
      RevolutPaymentResult.fromJson(map);
  Map<String, dynamic> toMap() => toJson();
  @override
  String toString() => success
      ? '[${timestamp.toIso8601String()}] SUCCESS: $message'
      : '[${timestamp.toIso8601String()}] ERROR: $error';
}
