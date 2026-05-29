import 'package:inspector/domain/auth/entities/user.dart';
import 'package:inspector/domain/auth/repositories/auth_repository.dart';
import 'package:inspector/domain/auth/usecases/sign_in_usecase.dart';
import 'package:inspector/domain/core/entities/failures.dart';
import 'package:inspector/domain/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetMineUseCase extends UseCase<User, NoParams> {
  final AuthRepository authRepository;

  GetMineUseCase(this.authRepository);
  @override
  Future<Either<Failure, User>> call(NoParams params) {
    return authRepository.getMine(params: params);
  }
}