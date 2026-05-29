
import 'package:bloc/bloc.dart';
import 'package:inspector/domain/core/entities/failures.dart';
import 'package:inspector/domain/core/usecases/usecase.dart'; // For NoParams
import 'package:inspector/domain/incident/entities/incident.dart';
import 'package:inspector/domain/incident/entities/incident_type.dart';
// Import specific UseCases
import 'package:inspector/domain/incident/usecases/get_incident_types_usecase.dart';
import 'package:inspector/domain/incident/usecases/create_incident_usecase.dart';
import 'package:inspector/domain/incident/usecases/get_incidents_usecase.dart';
import 'package:inspector/domain/incident/usecases/get_incident_usecase.dart';
import 'package:inspector/presentation/core/blocs/core/base_paginated_list_state.dart';
// Import specific UseCaseParams (assuming they are in usecase files or separate params files)
// e.g., import 'package:inspector/domain/incident/usecases/create_incident_usecase.dart' for CreateIncidentUseCaseParams;
import 'package:inspector/presentation/core/blocs/core/base_state.dart';
import 'package:flutter/foundation.dart'; // For @immutable
import 'package:injectable/injectable.dart';


part 'get_incidents_event.dart';

@injectable
class GetIncidentsBloc extends Bloc<GetIncidentsEvent, BasePaginatedListState<Incident>> {
  final GetIncidentsUseCase _getIncidentsUseCase;

  GetIncidentsBloc(this._getIncidentsUseCase)
      : super(const BasePaginatedListState()) {
    on<GetIncidentsRequested>(_onFetchIncidentsRequested);
  }

  Future<void> _onFetchIncidentsRequested(
      GetIncidentsRequested event,
      Emitter<BasePaginatedListState<Incident>> emit,
      ) async {
    emit(const BasePaginatedListState(status: PaginatedListStatus.inProgress));

    final params = GetIncidentsParams( // Construct UseCaseParams here
      page: event.page,
      limit: event.limit,
    );

    final failureOrItem = await _getIncidentsUseCase(params);

    emit(
      failureOrItem.fold(
            (failure) => state.setFailureState(failure),
            (itemValue) => BasePaginatedListState(
          status: PaginatedListStatus.success,
          items: itemValue,
        ),
      ),
    );
  }
}