// domain/incident/usecases/get_incidents_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:inspector/domain/core/entities/failures.dart';
import 'package:inspector/domain/core/usecases/usecase.dart';
import 'package:inspector/domain/incident/entities/incident.dart';
import 'package:inspector/domain/incident/repositories/incident_repository.dart';

class GetIncidentsParams {
  final int? page;
  final int? limit;

  GetIncidentsParams({this.page, this.limit});
}

@lazySingleton
class GetIncidentsUseCase extends UseCase<List<Incident>, GetIncidentsParams> {
  final IncidentRepository repository;

  GetIncidentsUseCase(this.repository);

  @override
  Future<Either<Failure, List<Incident>>> call(GetIncidentsParams params) {
    return repository.getIncidents(params: params);
  }
}

