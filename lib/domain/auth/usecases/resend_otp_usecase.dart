import 'package:inspector/domain/auth/entities/user.dart';
import 'package:inspector/domain/auth/repositories/auth_repository.dart';
import 'package:inspector/domain/core/entities/failures.dart';
import 'package:inspector/domain/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ResendOtpUseCase extends UseCase<Unit, ResendOtpUseCaseParams> {
  final AuthRepository authRepository;

  ResendOtpUseCase(this.authRepository);
  @override
  Future<Either<Failure, Unit>> call(ResendOtpUseCaseParams params) {
    return authRepository.resendOTP(params: params);
  }
}

class ResendOtpUseCaseParams {
  final String phone;


  ResendOtpUseCaseParams({
    required this.phone,
  });
}
