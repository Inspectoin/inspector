import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BaseResponse<T> extends Equatable  {

  @JsonKey(name: 'Message')
  final String? message;
  @JsonKey(name: 'Count')
  final int? count;
  @JsonKey(name: 'ScannedCount')
  final int? scannedCount;
  final T? data;
  final String? code;
  final Map<dynamic, dynamic>? args;
  @JsonKey(name: 'LastEvaluatedKey')
  late final String? lastEvaluatedKey;

  BaseResponse({
    this.message,
    this.count,
    this.scannedCount,
    this.data,
    this.code,
    this.args,
    this.lastEvaluatedKey
  });

  factory BaseResponse.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$BaseResponseFromJson(json, fromJsonT);



  @override
  List<Object?> get props => [
    message,
    count,
    scannedCount,
    data,
    code,
    args,
    lastEvaluatedKey,
  ];
}
