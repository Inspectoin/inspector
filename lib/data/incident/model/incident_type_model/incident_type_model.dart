import 'package:inspector/domain/incident/entities/incident_type.dart';
import 'package:json_annotation/json_annotation.dart';
import '../incident_category_model/incident_category_model.dart';

part 'incident_type_model.g.dart';

@JsonSerializable()
class IncidentTypeModel {
  final String id;
  final String key;
  final String name;
  final String description;
  final List<IncidentCategoryModel> categories;

  IncidentTypeModel({
    required this.id,
    required this.key,
    required this.name,
    required this.description,
    required this.categories,
  });

  factory IncidentTypeModel.fromJson(Map<String, dynamic> json) =>
      _$IncidentTypeModelFromJson(json);

  Map<String, dynamic> toJson() => _$IncidentTypeModelToJson(this);
}

extension IncidentTypeMapper on IncidentTypeModel {
  IncidentType toDomain() {
    return IncidentType(
      id: id,
      key: key,
      name: name,
      description: description,
      categories: categories.map((e) => e.toDomain()).toList(),
    );
  }
}
