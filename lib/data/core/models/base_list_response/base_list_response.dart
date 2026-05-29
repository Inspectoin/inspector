import 'package:inspector/data/core/models/base_response/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'base_list_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BaseListResponse<T> extends BaseResponse  {

  @JsonKey(name:  'Items')
  @override
  final T? data;


  BaseListResponse({
    super.message,
    this.data,
    super.lastEvaluatedKey

  });

  factory BaseListResponse.fromJson(
      Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$BaseListResponseFromJson(json, fromJsonT);


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
