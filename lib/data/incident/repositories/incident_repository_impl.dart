// data/incident/repositories/incident_repository_impl.dart
import 'package:inspector/data/incident/datasources/remote/incident_remote_datasource.dart';
import 'package:inspector/domain/incident/entities/incident_file.dart';
import 'package:inspector/domain/incident/usecases/upload_incident_file_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:inspector/data/core/repositories/base_repository_impl.dart';
import 'package:inspector/data/core/utils/configuration/configuration.dart';

import 'package:inspector/data/incident/model/incident_model/incident_model.dart';
import 'package:inspector/data/incident/model/incident_type_model/incident_type_model.dart';
import 'package:inspector/data/incident/models/incident_file_model.dart'; // Ensure this import is present

import 'package:inspector/domain/core/entities/failures.dart';
import 'package:inspector/domain/incident/entities/incident.dart';
import 'package:inspector/domain/incident/entities/incident_type.dart';
import 'package:inspector/domain/incident/repositories/incident_repository.dart';
import 'package:inspector/domain/incident/usecases/create_incident_usecase.dart';
import 'package:inspector/domain/incident/usecases/get_incident_usecase.dart';
import 'package:inspector/domain/incident/usecases/get_incidents_usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@LazySingleton(as: IncidentRepository)
class IncidentRepositoryImpl extends BaseRepositoryImpl
    implements IncidentRepository {

  final IncidentRemoteDatasource remoteDataSource;
  final Logger logger;


  final Configuration configuration;

  IncidentRepositoryImpl(this.remoteDataSource, this.logger, this.configuration)
      : super(logger); // Pass logger to BaseRepositoryImpl

  @override
  Future<Either<Failure, Incident>> createIncident(
      {required CreateIncidentParams params}) {
    return request<Incident>(() async {
      final response = await remoteDataSource.createIncident(
        incidentTypeId: params.incidentTypeId,
        categoryId: params.categoryId,
        description: params.description,
        labelLocation: params.labelLocation,
        coordinatesLocation: params.coordinatesLocation,
        hideMyInfo: params.hideMyInfo,
        files: params.files,
      );
      return right(response.data!.toDomain()); // Keeping your original structure for now
    },withCheckToken: false);
  }

  @override
  Future<Either<Failure, List<IncidentType>>> getIncidentTypes() {
    return request<List<IncidentType>>(() async {
      final response = await remoteDataSource.getIncidentTypes();
     final domainList = response.data!.map((model) => model.toDomain()).toList(); // Keeping your original structure
      return right(domainList);
    },withCheckToken: false);
  }

  @override
  Future<Either<Failure, List<Incident>>> getIncidents(
      {required GetIncidentsParams params}) {
    return request<List<Incident>>(() async {
      // Similar assumptions as above
      final response = await remoteDataSource.getIncidents(
        page: params.page,
        limit: params.limit,
      );
      final domainList =
      response.data!.map((model) => model.toDomain()).toList(); // Keeping your original structure
      return right(domainList);
    });
  }

  @override
  Future<Either<Failure, Incident>> getIncident(
      {required GetIncidentParams params}) {
    return request<Incident>(() async {
      // Similar assumptions as above
      final response = await remoteDataSource.getIncident(id: params.id);
      return right(response.data!.toDomain()); // Keeping your original structure
    });
  }

  @override
  Future<Either<Failure, IncidentFile>> uploadIncidentFile(
      {required UploadIncidentFileUseCaseParams params}) {
    return request<IncidentFile>(() async {
      final incidentFileModel = await remoteDataSource.uploadIncidentFile(file: params.file);
      return right(incidentFileModel.toDomain()); // Corrected line
    });
  }
}
