// domain/incident/usecases/get_incident_types_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:inspector/domain/core/entities/failures.dart';
import 'package:inspector/domain/core/usecases/usecase.dart'; // For UseCase and NoParams
import 'package:inspector/domain/incident/entities/incident_type.dart';
import 'package:inspector/domain/incident/repositories/incident_repository.dart';

@lazySingleton
class GetIncidentTypesUseCase extends UseCase<List<IncidentType>, NoParams> {
  final IncidentRepository repository;

  GetIncidentTypesUseCase(this.repository);

  @override
  Future<Either<Failure, List<IncidentType>>> call(NoParams params) {
    return repository.getIncidentTypes();
  }
}