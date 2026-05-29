import 'package:inspector/presentation/core/blocs/core/base_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inspector/domain/core/usecases/set_session_status_usecase.dart';
import 'package:inspector/domain/core/usecases/get_session_status_usecase.dart';
import 'package:inspector/domain/core/usecases/usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'session_settings_event.dart';

@injectable
class SessionSettingsBloc extends Bloc<SessionSettingsEvent, BaseState<bool>> {
  final SetSessionStatusUseCase _setSessionStatusUseCase;
  final GetSessionStatusUseCase _getSessionStatusUseCase;

  SessionSettingsBloc(
    this._setSessionStatusUseCase,
    this._getSessionStatusUseCase,
  ) : super(const BaseState()) {
    on<GetSessionStatusRequested>(_onGetSessionStatusRequested);
    on<SetSessionStatusRequested>(_onSetSessionStatusRequested);
  }

  Future<void> _onGetSessionStatusRequested(
    GetSessionStatusRequested event,
    Emitter<BaseState<bool>> emit,
  ) async {
    emit(state.copyWith(status: BaseStatus.inProgress));
    final failureOrStatus = await _getSessionStatusUseCase(NoParams());
    failureOrStatus.fold(
      (failure) => emit(state.setFailureState(failure)),
      (status) => emit(state.copyWith(status: BaseStatus.success, item: status)),
    );
  }

  Future<void> _onSetSessionStatusRequested(
    SetSessionStatusRequested event,
    Emitter<BaseState<bool>> emit,
  ) async {
     emit(state.copyWith(status: BaseStatus.inProgress));
    final failureOrSuccess = await _setSessionStatusUseCase(
      SetSessionStatusParams(status: event.newStatus),
    );
    failureOrSuccess.fold(
      (failure) => emit(state.setFailureState(failure)),
      (_) => emit(state.copyWith(status: BaseStatus.success, item: event.newStatus)), // Update state with the new status
    );
  }
}
