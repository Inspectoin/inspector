// domain/incident/repositories/incident_repository.dart

import 'dart:io'; // Added for File type

import 'package:inspector/domain/core/entities/failures.dart';
import 'package:inspector/domain/incident/entities/incident.dart';
import 'package:inspector/domain/incident/entities/incident_file.dart'; // Added for IncidentFile
import 'package:inspector/domain/incident/entities/incident_type.dart';
import 'package:inspector/domain/incident/usecases/create_incident_usecase.dart'; // For CreateIncidentParams
import 'package:inspector/domain/incident/usecases/get_incident_usecase.dart';
import 'package:inspector/domain/incident/usecases/get_incidents_usecase.dart';
import 'package:inspector/domain/incident/usecases/upload_incident_file_use_case.dart'; // Added for UploadIncidentFileUseCaseParams
import 'package:dartz/dartz.dart';

abstract class IncidentRepository {
  Future<Either<Failure, Incident>> createIncident(
      {required CreateIncidentParams params});

  Future<Either<Failure, List<IncidentType>>> getIncidentTypes();

  Future<Either<Failure, List<Incident>>> getIncidents(
      {required GetIncidentsParams params});

  Future<Either<Failure, Incident>> getIncident(
      {required GetIncidentParams params});

  Future<Either<Failure, IncidentFile>> uploadIncidentFile(
      {required UploadIncidentFileUseCaseParams params}); // Added method
}
