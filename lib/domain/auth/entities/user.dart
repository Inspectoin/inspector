
import 'package:equatable/equatable.dart';
class User {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String phoneCountryCode;
  final String? profilePictureUrl;
  final bool isEmailVerified;
  final bool isPhoneVerified;
  final bool isActive;
  final String? roleId;
  final String? accessToken;
  final String? refreshToken;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.phoneCountryCode,
    required this.profilePictureUrl,
    required this.isEmailVerified,
    required this.isPhoneVerified,
    required this.isActive,
    required this.roleId,
    this.accessToken,
    this.refreshToken,
  });
}
