import 'package:inspector/domain/auth/entities/user.dart';
import 'package:json_annotation/json_annotation.dart';


part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String id;
  final String name;
  final String email;

  @JsonKey(name: 'phone_number')
  final String phoneNumber;

  @JsonKey(name: 'phone_country_code')
  final String phoneCountryCode;

  @JsonKey(name: 'profile_picture_url')
  final String? profilePictureUrl;

  @JsonKey(name: 'is_email_verified')
  final bool isEmailVerified;

  @JsonKey(name: 'is_phone_verified')
  final bool isPhoneVerified;

  @JsonKey(name: 'is_active')
  final bool isActive;

  @JsonKey(name: 'role_id')
  final String? roleId;

  @JsonKey(name: 'access_token')
  String? accessToken;

  @JsonKey(name: 'access_token_expires_at')
  int? accessTokenExpiresAt;

  @JsonKey(name: 'refresh_token')
  String? refreshToken;

  UserModel({
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
    this.accessTokenExpiresAt,
    this.refreshToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

extension  MapToDomain on UserModel {

  User toDomain() {
    return User(
      id: id,
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      phoneCountryCode: phoneCountryCode,
      profilePictureUrl: profilePictureUrl,
      isEmailVerified: isEmailVerified,
      isPhoneVerified: isPhoneVerified,
      isActive: isActive,
      roleId: roleId,
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }
}

