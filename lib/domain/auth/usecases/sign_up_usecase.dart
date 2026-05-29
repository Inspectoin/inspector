import 'package:inspector/domain/auth/entities/user.dart';
import 'package:inspector/domain/auth/repositories/auth_repository.dart';
import 'package:inspector/domain/core/entities/failures.dart';
import 'package:inspector/domain/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SignUpUseCase extends UseCase<User, SignUpUpUseCaseParams> {
  final AuthRepository authRepository;

  SignUpUseCase(this.authRepository);
  @override
  Future<Either<Failure, User>> call(SignUpUpUseCaseParams params) {
    return authRepository.singUp(params: params);
  }
}

class SignUpUpUseCaseParams {
  final String id;
  final String username;
  final String name;
  final String address;
  final String phone;
  final String email;
  final String password;

  SignUpUpUseCaseParams({
    required this.id,
    required this.username,
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    required this.password
  });
}
