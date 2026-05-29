
// domain/incident/usecases/get_incident_detail_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:inspector/domain/core/entities/failures.dart';
import 'package:inspector/domain/core/usecases/usecase.dart';
import 'package:inspector/domain/incident/entities/incident.dart';
import 'package:inspector/domain/incident/repositories/incident_repository.dart';

class GetIncidentParams {
  final String id;

  GetIncidentParams({required this.id});
}

@lazySingleton
class GetIncidentUseCase
    extends UseCase<Incident, GetIncidentParams> {
  final IncidentRepository repository;

  GetIncidentUseCase(this.repository);

  @override
  Future<Either<Failure, Incident>> call(GetIncidentParams params) {
    return repository.getIncident(params: params);
  }
}