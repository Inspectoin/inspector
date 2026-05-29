// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'incident_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IncidentModel _$IncidentModelFromJson(Map<String, dynamic> json) =>
    IncidentModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      description: json['description'] as String,
      location: json['location'] as String,
      incidentTypeId: json['incidentTypeId'] as String,
      categoryId: json['categoryId'] as String,
      files: const ListOrStringConverter().fromJson(json['files']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: _$JsonConverterFromJson<String, DateTime>(json['updatedAt'],
          const CustomNonNullableDateTimeConverter().fromJson),
      tenantId: json['tenantId'] as String?,
    );

Map<String, dynamic> _$IncidentModelToJson(IncidentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'description': instance.description,
      'location': instance.location,
      'incidentTypeId': instance.incidentTypeId,
      'categoryId': instance.categoryId,
      'files': const ListOrStringConverter().toJson(instance.files),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': _$JsonConverterToJson<String, DateTime>(instance.updatedAt,
          const CustomNonNullableDateTimeConverter().toJson),
      'tenantId': instance.tenantId,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
