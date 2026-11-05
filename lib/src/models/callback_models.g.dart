// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'callback_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RevolutLogEntry _$RevolutLogEntryFromJson(Map<String, dynamic> json) =>
    _RevolutLogEntry(
      level: _logLevelFromJson(json['level'] as String?),
      message: json['message'] as String? ?? '',
      timestamp: const EpochMillisecondsConverter().fromJson(
        json['timestamp'] as num?,
      ),
      source: json['source'] as String? ?? 'Unknown',
    );

Map<String, dynamic> _$RevolutLogEntryToJson(
  _RevolutLogEntry instance,
) => <String, dynamic>{
  'level': _logLevelToJson(instance.level),
  'message': instance.message,
  'timestamp': const EpochMillisecondsConverter().toJson(instance.timestamp),
  'source': instance.source,
};

_RevolutPaymentResult _$RevolutPaymentResultFromJson(
  Map<String, dynamic> json,
) => _RevolutPaymentResult(
  success: json['success'] as bool? ?? false,
  message: json['message'] as String? ?? '',
  error: json['error'] as String? ?? '',
  timestamp: const EpochMillisecondsConverter().fromJson(
    json['timestamp'] as num?,
  ),
);

Map<String, dynamic> _$RevolutPaymentResultToJson(
  _RevolutPaymentResult instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'error': instance.error,
  'timestamp': const EpochMillisecondsConverter().toJson(instance.timestamp),
};
