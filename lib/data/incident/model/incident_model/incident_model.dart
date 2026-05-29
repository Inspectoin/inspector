import 'package:inspector/data/core/utils/custom_non_nullable_date_converter.dart';
import 'package:inspector/data/core/utils/list_converter.dart';
import 'package:inspector/domain/incident/entities/incident.dart';
import 'package:json_annotation/json_annotation.dart';

part 'incident_model.g.dart';

@JsonSerializable()
class IncidentModel {
  final String id;
  @JsonKey(name: 'userId')
  final String userId;
  final String description;
  final String location;
  @JsonKey(name: 'incidentTypeId')
  final String incidentTypeId;
  @JsonKey(name: 'categoryId')
  final String categoryId;
  @ListOrStringConverter()
  final List<String> files;
  @JsonKey(name: 'createdAt')
  final DateTime createdAt;
  @CustomNonNullableDateTimeConverter()
  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;
  final String? tenantId;


  IncidentModel({
    required this.id,
    required this.userId,
    required this.description,
    required this.location,
    required this.incidentTypeId,
    required this.categoryId,
    required this.files,
    required this.createdAt,
    this.updatedAt,
    this.tenantId,
  });

  factory IncidentModel.fromJson(Map<String, dynamic> json) =>
      _$IncidentModelFromJson(json);

  Map<String, dynamic> toJson() => _$IncidentModelToJson(this);
}

extension IncidentMapper on IncidentModel {
  Incident toDomain() {
    return Incident(
      id: id,
      userId: userId,
      description: description,
      location: location,
      incidentTypeId: incidentTypeId,
      categoryId: categoryId,
      files: files,
      createdAt: createdAt,
      updatedAt: updatedAt,
      tenantId: tenantId,
    );
  }
}
