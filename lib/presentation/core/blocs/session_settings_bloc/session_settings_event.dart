part of 'session_settings_bloc.dart';

abstract class SessionSettingsEvent extends Equatable {
  const SessionSettingsEvent();

  @override
  List<Object> get props => [];
}

class SetSessionStatusRequested extends SessionSettingsEvent {
  final bool newStatus;

  const SetSessionStatusRequested({required this.newStatus});

  @override
  List<Object> get props => [newStatus];
}

class GetSessionStatusRequested extends SessionSettingsEvent {}
