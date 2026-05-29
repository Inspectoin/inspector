import 'package:inspector/domain/core/entities/failures.dart';
import 'package:inspector/domain/core/repositories/core_repository.dart';
import 'package:inspector/domain/core/usecases/usecase.dart'; // Make sure NoParams is defined here or import it
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetSessionStatusUseCase extends UseCase<bool, NoParams> {
  final CoreRepository repository;

  GetSessionStatusUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return repository.getSessionStatus();
  }
}
