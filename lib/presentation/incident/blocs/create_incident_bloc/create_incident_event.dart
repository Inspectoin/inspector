part of 'create_incident_bloc.dart';

@immutable
abstract class CreateIncidentEvent {}

class CreateIncidentRequested extends CreateIncidentEvent {
  final String incidentTypeId;
  final String categoryId;
  final String description;
  final String labelLocation;
  final String coordinatesLocation;
  final bool hideMyInfo;
  final List<String> files;

   CreateIncidentRequested({
    required this.incidentTypeId,
    required this.categoryId,
    required this.description,
    required this.labelLocation,
    required this.coordinatesLocation,
     required this.hideMyInfo,
    required this.files,
  });
}
