// data/incident/models/incident_file_model.dart
import 'package:inspector/domain/incident/entities/incident_file.dart';
import 'package:json_annotation/json_annotation.dart';

part 'incident_file_model.g.dart';

@JsonSerializable()
class IncidentFileModel {
  @JsonKey(name: 'file_id')
  final String fileId;
  final String url;
  @JsonKey(name: 'original_name')
  final String originalName;
  final int size;
  @JsonKey(name: 'mime_type')
  final String mimeType;
  @JsonKey(name: 'uploaded_at')
  final DateTime uploadedAt;

  IncidentFileModel({
    required this.fileId,
    required this.url,
    required this.originalName,
    required this.size,
    required this.mimeType,
    required this.uploadedAt,
  });

  factory IncidentFileModel.fromJson(Map<String, dynamic> json) =>
      _$IncidentFileModelFromJson(json);

  Map<String, dynamic> toJson() => _$IncidentFileModelToJson(this);
}

extension IncidentFileMapper on IncidentFileModel {
  IncidentFile toDomain() {
    return IncidentFile(
      fileId: fileId,
      url: url,
      originalName: originalName,
      size: size,
      mimeType: mimeType,
      uploadedAt: uploadedAt,
    );
  }
}
