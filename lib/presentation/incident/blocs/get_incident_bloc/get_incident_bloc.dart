import 'package:inspector/domain/incident/entities/incident.dart';
import 'package:inspector/domain/incident/usecases/get_incident_usecase.dart';
import 'package:inspector/presentation/core/blocs/core/base_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'get_incident_event.dart';

@injectable
class GetIncidentBloc extends Bloc<GetIncidentEvent, BaseState<Incident>> {
  final GetIncidentUseCase _getIncidentUseCase;

  GetIncidentBloc(this._getIncidentUseCase)
      : super(const BaseState()) {
    on<GetIncidentRequested>(_onGetIncidentRequested);
  }

  Future<void> _onGetIncidentRequested(GetIncidentRequested event,
      Emitter<BaseState<Incident>> emit,) async {
    emit(state.copyWith(status: BaseStatus.inProgress));
    final failureOrIncident = await _getIncidentUseCase(event.params);

    emit(
      failureOrIncident.fold(
            (failure) => state.setFailureState(failure),
            (incident) =>
            BaseState(
              status: BaseStatus.success,
              item: incident,
            ),
      ),
    );
  }
}