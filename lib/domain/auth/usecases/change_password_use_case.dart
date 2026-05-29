import 'package:inspector/domain/auth/repositories/auth_repository.dart';
import 'package:inspector/domain/core/entities/failures.dart';
import 'package:inspector/domain/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

class ChangePasswordUseCaseParams {
  final String oldPassword;
  final String newPassword;

  const ChangePasswordUseCaseParams({
    required this.oldPassword,
    required this.newPassword,
  });
}

@lazySingleton
class ChangePasswordUseCase
    implements UseCase<void, ChangePasswordUseCaseParams> {
  final AuthRepository _repository;

  ChangePasswordUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(
      ChangePasswordUseCaseParams params) async {
    return _repository.changePassword(params: params);
  }
}
