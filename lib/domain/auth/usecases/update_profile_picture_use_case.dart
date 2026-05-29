import 'dart:io';

import 'package:inspector/domain/auth/entities/user.dart';
import 'package:inspector/domain/auth/repositories/auth_repository.dart';
import 'package:inspector/domain/core/entities/failures.dart';
import 'package:inspector/domain/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UpdateProfilePictureUseCase extends UseCase<Unit, UpdateProfilePictureParams> {
  final AuthRepository repository;

  UpdateProfilePictureUseCase({required this.repository});

  @override
  Future<Either<Failure, Unit>> call(UpdateProfilePictureParams params) async {
    return repository.updateProfilePicture(params: params);
  }
}

class UpdateProfilePictureParams extends Equatable {
  final String imagePath;

  const UpdateProfilePictureParams({required this.imagePath});

  @override
  List<Object?> get props => [imagePath];
}
