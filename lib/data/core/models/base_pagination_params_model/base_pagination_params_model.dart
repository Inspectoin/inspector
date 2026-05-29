import 'package:json_annotation/json_annotation.dart';

part 'base_pagination_params_model.g.dart';

@JsonSerializable(createToJson: true,createFactory: false)
class BasePaginationParamsModel {
  final int? limit;
  final int? skip;

  BasePaginationParamsModel(
    this.limit,
    this.skip,
  );

  
  Map<String, dynamic> toJson() => _$BasePaginationParamsModelToJson(this);
}
