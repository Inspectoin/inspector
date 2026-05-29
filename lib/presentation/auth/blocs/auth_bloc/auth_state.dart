part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class Authenticated extends AuthState {
  final User user;

  Authenticated({
    required this.user,
  });
}

class Unauthenticated extends AuthState {
  final Failure failure;

  Unauthenticated(this.failure);
}

class AuthFailure extends AuthState {
  final Failure failure;

  AuthFailure(this.failure);
}

class AuthLoading extends AuthState {}
