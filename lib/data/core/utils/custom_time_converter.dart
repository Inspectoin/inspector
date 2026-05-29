import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

class CustomTimeConverter implements JsonConverter<TimeOfDay?, int?> {
  const CustomTimeConverter();

  @override
  TimeOfDay? fromJson(int? json) {
    if (json == null) return null;

    return TimeOfDay(hour: json ~/ 60, minute: json % 60);
  }

  @override
  int? toJson(TimeOfDay? json) {
    if (json == null) return null;

    return (json.hour * 60) + json.minute;
  }
}
