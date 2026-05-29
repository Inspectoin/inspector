import 'package:inspector/domain/core/entities/failures.dart';
import 'package:inspector/domain/core/repositories/core_repository.dart';
import 'package:inspector/domain/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SetSessionStatusUseCase extends UseCase<void, SetSessionStatusParams> {
  final CoreRepository repository;

  SetSessionStatusUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(SetSessionStatusParams params) async {
    return repository.setSessionStatus(params.status);
  }
}

class SetSessionStatusParams extends Equatable {
  final bool status;

  const SetSessionStatusParams({required this.status});

  @override
  List<Object?> get props => [status];
}
