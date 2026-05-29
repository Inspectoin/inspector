import 'package:inspector/domain/core/entities/failures.dart';
import 'package:inspector/domain/core/repositories/core_repository.dart';
import 'package:inspector/domain/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class IsFirstTimeUseCase extends UseCase<bool, NoParams> {
  final CoreRepository repository;

  IsFirstTimeUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(NoParams params) {
    return repository.isFirstTime();
  }
}
