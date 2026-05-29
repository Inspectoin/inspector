import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

class CustomNonNullableTimeConverter implements JsonConverter<TimeOfDay, int> {
  const CustomNonNullableTimeConverter();

  @override
  TimeOfDay fromJson(int json) {
    return TimeOfDay(hour: json ~/ 60, minute: json % 60);
  }

  @override
  int toJson(TimeOfDay json) {
    return (json.hour * 60) + json.minute;
  }
}
