import 'package:equatable/equatable.dart';

class PaginatedList<T>  extends Equatable{
  final String? lastEvaluatedKey;
  final List<T> data;

  PaginatedList(this.lastEvaluatedKey, this.data);

  @override
  List<Object?> get props => [lastEvaluatedKey,data];
}
