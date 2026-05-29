// presentation/incident/blocs/upload_incident_file_bloc/upload_incident_file_event.dart
part of 'highlight_item_bloc.dart';

@immutable
abstract class HighlightItemEvent {}

@immutable
class HighlightItemRequested extends HighlightItemEvent {
  final HighlightItemType type;

  HighlightItemRequested({required this.type});
}

enum HighlightItemType{incident,point}
