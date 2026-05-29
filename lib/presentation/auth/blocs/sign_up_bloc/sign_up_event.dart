part of 'sign_up_bloc.dart';


@immutable
abstract class SignUpEvent {}

class SignUpRequested extends SignUpEvent {
  final String id;
  final String username;
  final String name;
  final String address;
  final String phone;
  final String email;
  final String password;

  SignUpRequested({
    required this.id,
    required this.username,
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    required this.password
  });

}




