import 'package:json_annotation/json_annotation.dart';

class ListOrStringConverter implements JsonConverter<List<String>, dynamic> {
  const ListOrStringConverter();

  @override
  List<String> fromJson(dynamic json) {
    return [];
    if (json == null) return [];
    if (json is String) return [json];
    if (json is List) return json.map((e) => e.toString()).toList();
    return [];
  }

  @override
  dynamic toJson(List<String> object) => object;
}
