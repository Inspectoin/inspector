// domain/incident/entities/incident_file.dart
import 'package:equatable/equatable.dart';

class IncidentFile extends Equatable {
  final String fileId;
  String url;
  String path;
  String originalName;
  int size;
  String mimeType;
  DateTime uploadedAt;
  bool isLocal;

   IncidentFile({
    required this.fileId,
    required this.url,
    required this.originalName,
    required this.size,
    required this.mimeType,
    required this.uploadedAt,
     this.isLocal=false,
     this.path=''
  });

  @override
  List<Object?> get props => [
        fileId,
        url,
        originalName,
        size,
        mimeType,
        uploadedAt,
      ];
}
