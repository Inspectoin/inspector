import 'package:inspector/domain/auth/entities/user.dart';
import 'package:inspector/domain/auth/repositories/auth_repository.dart';
import 'package:inspector/domain/core/entities/failures.dart';
import 'package:inspector/domain/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SignInUseCase extends UseCase<User, SignInUseCaseParams> {
  final AuthRepository authRepository;

  SignInUseCase(this.authRepository);
  @override
  Future<Either<Failure, User>> call(SignInUseCaseParams params) {
    return authRepository.signIn(params: params);
  }
}

class SignInUseCaseParams {
  final String identifier;
  final String password;

  SignInUseCaseParams({
    required this.identifier,
    required this.password
  });
}
