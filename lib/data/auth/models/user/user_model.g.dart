// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phoneNumber: json['phone_number'] as String,
      phoneCountryCode: json['phone_country_code'] as String,
      profilePictureUrl: json['profile_picture_url'] as String?,
      isEmailVerified: json['is_email_verified'] as bool,
      isPhoneVerified: json['is_phone_verified'] as bool,
      isActive: json['is_active'] as bool,
      roleId: json['role_id'] as String?,
      accessToken: json['access_token'] as String?,
      accessTokenExpiresAt: (json['access_token_expires_at'] as num?)?.toInt(),
      refreshToken: json['refresh_token'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'phone_country_code': instance.phoneCountryCode,
      'profile_picture_url': instance.profilePictureUrl,
      'is_email_verified': instance.isEmailVerified,
      'is_phone_verified': instance.isPhoneVerified,
      'is_active': instance.isActive,
      'role_id': instance.roleId,
      'access_token': instance.accessToken,
      'access_token_expires_at': instance.accessTokenExpiresAt,
      'refresh_token': instance.refreshToken,
    };
