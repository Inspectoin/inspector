import 'package:inspector/domain/core/entities/failures.dart';
import 'package:inspector/domain/core/repositories/core_repository.dart';
import 'package:inspector/domain/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SetFirstTimeUseCase extends UseCase<Unit, SetFirstTimeUseCaseParams> {
  final CoreRepository repository;

  SetFirstTimeUseCase({required this.repository});

  @override
  Future<Either<Failure, Unit>> call(SetFirstTimeUseCaseParams params) {
    return repository.setFirstTime(params: params);
  }
}


class SetFirstTimeUseCaseParams {

  bool firstTimeValue;


  SetFirstTimeUseCaseParams({required this.firstTimeValue});
}


