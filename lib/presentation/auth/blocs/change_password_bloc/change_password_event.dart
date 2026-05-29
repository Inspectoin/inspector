part of 'change_password_bloc.dart';

@immutable
abstract class ChangePasswordEvent {}

@immutable
class ChangePasswordRequested extends ChangePasswordEvent {
  final String oldPassword;
  final String newPassword;

  ChangePasswordRequested({
    required this.oldPassword,
    required this.newPassword,
  });
}
