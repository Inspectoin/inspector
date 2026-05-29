import 'package:bloc/bloc.dart';
import 'package:inspector/domain/core/usecases/usecase.dart'; // For NoParams
import 'package:inspector/domain/incident/entities/incident_type.dart';
import 'package:inspector/domain/incident/usecases/get_incident_types_usecase.dart';
import 'package:inspector/presentation/core/blocs/core/base_state.dart'; // Your BaseState
import 'package:injectable/injectable.dart';
import 'package:flutter/material.dart';

part 'get_incident_types_event.dart';

@lazySingleton
class GetIncidentTypesBloc
    extends Bloc<GetIncidentTypesEvent, BaseState<List<IncidentType>>> {
  final GetIncidentTypesUseCase _getIncidentTypesUseCase;

  GetIncidentTypesBloc(this._getIncidentTypesUseCase)
      : super(const BaseState()) {
    on<GetIncidentTypesRequested>(_onGetIncidentTypesRequested);
  }

  Future<void> _onGetIncidentTypesRequested(GetIncidentTypesRequested event,
      Emitter<BaseState<List<IncidentType>>> emit,) async {
    emit(state.copyWith(status: BaseStatus
        .inProgress));

    final failureOrIncidentTypes = await _getIncidentTypesUseCase(NoParams());

    emit(
      failureOrIncidentTypes.fold(
            (failure) => state.setFailureState(failure),
            (incidentTypes) =>
            BaseState(
              status: BaseStatus.success,
              item: incidentTypes,
            ),
      ),
    );
  }
}