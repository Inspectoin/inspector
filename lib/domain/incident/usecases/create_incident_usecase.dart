// domain/incident/usecases/create_incident_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:inspector/domain/core/entities/failures.dart';
import 'package:inspector/domain/core/usecases/usecase.dart';
import 'package:inspector/domain/incident/entities/incident.dart';
import 'package:inspector/domain/incident/repositories/incident_repository.dart';

class CreateIncidentParams {
  final String incidentTypeId;
  final String categoryId;
  final String description;
  final String labelLocation;
  final String coordinatesLocation;
  final bool hideMyInfo;
  final List<String> files;

  CreateIncidentParams({
    required this.incidentTypeId,
    required this.categoryId,
    required this.description,
    required this.labelLocation,
    required this.coordinatesLocation,
    required this.hideMyInfo,
    required this.files,
  });
}

@lazySingleton
class CreateIncidentUseCase extends UseCase<Incident, CreateIncidentParams> {
  final IncidentRepository repository;

  CreateIncidentUseCase(this.repository);

  @override
  Future<Either<Failure, Incident>> call(CreateIncidentParams params) {
    return repository.createIncident(params: params);
  }
}