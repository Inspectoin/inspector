// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'incident_file_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IncidentFileModel _$IncidentFileModelFromJson(Map<String, dynamic> json) =>
    IncidentFileModel(
      fileId: json['file_id'] as String,
      url: json['url'] as String,
      originalName: json['original_name'] as String,
      size: (json['size'] as num).toInt(),
      mimeType: json['mime_type'] as String,
      uploadedAt: DateTime.parse(json['uploaded_at'] as String),
    );

Map<String, dynamic> _$IncidentFileModelToJson(IncidentFileModel instance) =>
    <String, dynamic>{
      'file_id': instance.fileId,
      'url': instance.url,
      'original_name': instance.originalName,
      'size': instance.size,
      'mime_type': instance.mimeType,
      'uploaded_at': instance.uploadedAt.toIso8601String(),
    };
