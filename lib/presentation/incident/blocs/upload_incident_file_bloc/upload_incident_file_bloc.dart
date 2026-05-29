// presentation/incident/blocs/upload_incident_file_bloc/upload_incident_file_bloc.dart
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:inspector/domain/incident/entities/incident_file.dart';
import 'package:inspector/domain/incident/usecases/upload_incident_file_use_case.dart';
import 'package:inspector/presentation/core/blocs/core/base_state.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'upload_incident_file_event.dart';

@injectable
class UploadIncidentFileBloc extends Bloc<UploadIncidentFileEvent, BaseState<IncidentFile>> {
  final UploadIncidentFileUseCase _uploadIncidentFileUseCase;

  UploadIncidentFileBloc(this._uploadIncidentFileUseCase)
      : super(const BaseState<IncidentFile>()) {
    on<UploadFileRequested>(_onUploadFileRequested);
  }

  Future<void> _onUploadFileRequested(
    UploadFileRequested event,
    Emitter<BaseState<IncidentFile>> emit,
  ) async {
    emit(state.copyWith(status: BaseStatus.inProgress)); // Or const BaseState(status: BaseStatus.inProgress)

    final params = UploadIncidentFileUseCaseParams(file: event.file);
    final failureOrSuccess = await _uploadIncidentFileUseCase(params);

    failureOrSuccess.fold(
      (failure) => emit(state.setFailureState(failure)),
      (incidentFile) => emit(BaseState<IncidentFile>(
        status: BaseStatus.success,
        item: incidentFile,
      )),
    );
  }
}
