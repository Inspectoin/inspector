part of 'update_profile_bloc.dart';

@immutable
abstract class UpdateProfileEvent {}

@immutable
class UpdateProfileRequested extends UpdateProfileEvent {
  final String fullName;
  final String phone;
  final String countryCode;
  final String email;

   UpdateProfileRequested({
    required this.fullName,
    required this.phone,
    required this.countryCode,
    required this.email,
  });
}
