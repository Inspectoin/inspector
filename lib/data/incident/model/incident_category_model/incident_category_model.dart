import 'package:inspector/domain/incident/entities/incident_category.dart';
import 'package:json_annotation/json_annotation.dart';

part 'incident_category_model.g.dart';

@JsonSerializable()
class IncidentCategoryModel {
  final String id;
  final String name;

  IncidentCategoryModel({required this.id, required this.name});

  factory IncidentCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$IncidentCategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$IncidentCategoryModelToJson(this);
}

extension IncidentCategoryMapper on IncidentCategoryModel {
  IncidentCategory toDomain() {
    return IncidentCategory(
      id: id,
      name: name,
    );
  }
}
