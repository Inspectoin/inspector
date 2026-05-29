part of 'get_incidents_bloc.dart';


abstract class GetIncidentsEvent {}


class GetIncidentsRequested extends GetIncidentsEvent {
  final int page;
  final int limit;

   GetIncidentsRequested({
    required this.page,
    required this.limit,
  });
}
