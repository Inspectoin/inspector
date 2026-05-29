// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse<T> _$BaseResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    BaseResponse<T>(
      message: json['Message'] as String?,
      count: (json['Count'] as num?)?.toInt(),
      scannedCount: (json['ScannedCount'] as num?)?.toInt(),
      data: _$nullableGenericFromJson(json['data'], fromJsonT),
      code: json['code'] as String?,
      args: json['args'] as Map<String, dynamic>?,
      lastEvaluatedKey: json['LastEvaluatedKey'] as String?,
    );

Map<String, dynamic> _$BaseResponseToJson<T>(
  BaseResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'Message': instance.message,
      'Count': instance.count,
      'ScannedCount': instance.scannedCount,
      'data': _$nullableGenericToJson(instance.data, toJsonT),
      'code': instance.code,
      'args': instance.args,
      'LastEvaluatedKey': instance.lastEvaluatedKey,
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);
