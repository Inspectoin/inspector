part of 'reset_password_bloc.dart';

@immutable
abstract class ResetPasswordEvent {}

@immutable
class ResetPasswordRequested extends ResetPasswordEvent {
  final String identifier;

  ResetPasswordRequested({
    required this.identifier,
  });
}


@immutable
class ConfirmResetPasswordRequested extends ResetPasswordEvent {
  final String code;
  final String newPassword;

  ConfirmResetPasswordRequested({
    required this.code,
    required this.newPassword,
  });
}