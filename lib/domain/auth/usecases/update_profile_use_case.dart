import 'package:inspector/domain/auth/entities/user.dart';
import 'package:inspector/domain/auth/repositories/auth_repository.dart';
import 'package:inspector/domain/core/entities/failures.dart';
import 'package:inspector/domain/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

class UpdateProfileUseCaseParams extends Equatable {
  final String fullName;
  final String phone;
  final String countryCode;
  final String email;

  const UpdateProfileUseCaseParams({
    required this.fullName,
    required this.phone,
    required this.countryCode,
    required this.email,
  });

  @override
  List<Object?> get props => [fullName, phone, countryCode, email];
}

@lazySingleton
class UpdateProfileUseCase implements UseCase<User, UpdateProfileUseCaseParams> {
  final AuthRepository repository;

  UpdateProfileUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(UpdateProfileUseCaseParams params) async {
    return await repository.updateProfile(params: params);
  }
}
