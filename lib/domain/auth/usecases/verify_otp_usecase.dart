import 'package:inspector/domain/auth/entities/user.dart';
import 'package:inspector/domain/auth/repositories/auth_repository.dart';
import 'package:inspector/domain/core/entities/failures.dart';
import 'package:inspector/domain/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class VerifyOtpUseCase extends UseCase<Unit, VerifyOtpUseCaseParams> {
  final AuthRepository authRepository;

  VerifyOtpUseCase(this.authRepository);
  @override
  Future<Either<Failure, Unit>> call(VerifyOtpUseCaseParams params) {
    return authRepository.verifyOTP(params: params);
  }
}

class VerifyOtpUseCaseParams {
  final String code;


  VerifyOtpUseCaseParams({
    required this.code,
  });
}
