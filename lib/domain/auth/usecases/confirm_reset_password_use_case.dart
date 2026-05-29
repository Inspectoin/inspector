import 'package:inspector/domain/auth/repositories/auth_repository.dart';
import 'package:inspector/domain/core/entities/failures.dart';
import 'package:inspector/domain/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

class ConfirmResetPasswordUseCaseParams {
  final String code;
  final String newPassword;

  const ConfirmResetPasswordUseCaseParams({
    required this.code,
    required this.newPassword,
  });
}

@lazySingleton
class ConfirmResetPasswordUseCase
    implements UseCase<void, ConfirmResetPasswordUseCaseParams> {
  final AuthRepository _repository;

  ConfirmResetPasswordUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(
      ConfirmResetPasswordUseCaseParams params) async {
    return _repository.confirmResetPassword(params: params);
  }
}
