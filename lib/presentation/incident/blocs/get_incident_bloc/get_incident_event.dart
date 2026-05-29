part of 'get_incident_bloc.dart';

abstract class GetIncidentEvent  {
  const GetIncidentEvent();


}

class GetIncidentRequested extends GetIncidentEvent {
  final GetIncidentParams params;

  const GetIncidentRequested({required this.params});


}