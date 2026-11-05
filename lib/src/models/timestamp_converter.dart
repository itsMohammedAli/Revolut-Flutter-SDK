import 'package:json_annotation/json_annotation.dart';

/// Native callback timestamps use epoch milliseconds rather than ISO strings.
class EpochMillisecondsConverter implements JsonConverter<DateTime, num?> {
  const EpochMillisecondsConverter();
  @override
  DateTime fromJson(num? value) =>
      DateTime.fromMillisecondsSinceEpoch((value ?? 0).toInt());
  @override
  int toJson(DateTime value) => value.millisecondsSinceEpoch;
}
