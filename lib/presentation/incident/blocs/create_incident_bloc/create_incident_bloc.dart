import 'package:bloc/bloc.dart';
import 'package:inspector/presentation/core/blocs/core/base_state.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:inspector/domain/incident/entities/incident.dart';
import 'package:inspector/domain/incident/usecases/create_incident_usecase.dart';

part 'create_incident_event.dart';

@injectable
class CreateIncidentBloc extends Bloc<CreateIncidentEvent, BaseState<Incident>> {
  final CreateIncidentUseCase _createIncidentUseCase;

  CreateIncidentBloc(this._createIncidentUseCase) : super(const BaseState()) {
    on<CreateIncidentRequested>((event, emit) async {
      emit(state.copyWith(status: BaseStatus.inProgress));
      final params = CreateIncidentParams(
        incidentTypeId: event.incidentTypeId,
        categoryId: event.categoryId,
        description: event.description,
        labelLocation: event.labelLocation,
        coordinatesLocation: event.coordinatesLocation,
        hideMyInfo: event.hideMyInfo,
        files: event.files,
      );
      final failureOrSuccess = await _createIncidentUseCase(params);
      failureOrSuccess.fold(
        (failure) => emit(state.setFailureState(failure)),
        (incident) => emit(BaseState(status: BaseStatus.success, item: incident)),
      );
    });
  }
}
