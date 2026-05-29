import 'package:equatable/equatable.dart';

class BasePaginationUseCaseParams extends Equatable {
  int limit;
  String lastEvaluatedKey;

  BasePaginationUseCaseParams({
   required this.limit,
   required this.lastEvaluatedKey,
});

  @override
  List<Object?> get props => [limit,lastEvaluatedKey];
}
