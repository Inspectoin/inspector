// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'incident_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IncidentTypeModel _$IncidentTypeModelFromJson(Map<String, dynamic> json) =>
    IncidentTypeModel(
      id: json['id'] as String,
      key: json['key'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      categories: (json['categories'] as List<dynamic>)
          .map((e) => IncidentCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$IncidentTypeModelToJson(IncidentTypeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'key': instance.key,
      'name': instance.name,
      'description': instance.description,
      'categories': instance.categories,
    };
