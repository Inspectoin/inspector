part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AuthCheckRequested extends AuthEvent {}

class AuthLogout extends AuthEvent {}

class SubscribeToAuthStatus extends AuthEvent {}

class AuthSignIn extends AuthEvent {
  final String identifier;
  final String password;

  AuthSignIn({
    required this.identifier,
    required this.password,
});
}
