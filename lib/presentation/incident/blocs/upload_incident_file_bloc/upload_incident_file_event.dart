// presentation/incident/blocs/upload_incident_file_bloc/upload_incident_file_event.dart
part of 'upload_incident_file_bloc.dart';

@immutable
abstract class UploadIncidentFileEvent {}

@immutable
class UploadFileRequested extends UploadIncidentFileEvent {
  final File file;

  UploadFileRequested({required this.file});
}
