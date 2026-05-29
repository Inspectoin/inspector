// domain/incident/usecases/upload_incident_file_use_case.dart
import 'dart:io';

import 'package:inspector/domain/core/entities/failures.dart';
import 'package:inspector/domain/core/usecases/usecase.dart';
import 'package:inspector/domain/incident/entities/incident_file.dart';
import 'package:inspector/domain/incident/repositories/incident_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

class UploadIncidentFileUseCaseParams extends Equatable {
  final File file;

  const UploadIncidentFileUseCaseParams({required this.file});

  @override
  List<Object?> get props => [file];
}

@lazySingleton
class UploadIncidentFileUseCase
    implements UseCase<IncidentFile, UploadIncidentFileUseCaseParams> {
  final IncidentRepository repository;

  UploadIncidentFileUseCase(this.repository);

  @override
  Future<Either<Failure, IncidentFile>> call(
      UploadIncidentFileUseCaseParams params,
  ) async {
    return repository.uploadIncidentFile(params: params);
  }
}
