import 'package:inspector/domain/auth/repositories/auth_repository.dart';
import 'package:inspector/domain/core/entities/failures.dart';
import 'package:inspector/domain/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

class ResetPasswordRequestUseCaseParams {
  final String identifier;

  const ResetPasswordRequestUseCaseParams({
    required this.identifier,
  });
}

@lazySingleton
class ResetPasswordRequestUseCase
    implements UseCase<void, ResetPasswordRequestUseCaseParams> {
  final AuthRepository _repository;

  ResetPasswordRequestUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(
ResetPasswordRequestUseCaseParams params) async {
    return _repository.resetPasswordRequest(params: params);
  }
}
