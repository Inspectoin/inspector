import 'package:bloc/bloc.dart';
import 'package:inspector/domain/auth/usecases/change_password_use_case.dart';
import 'package:inspector/domain/auth/usecases/confirm_reset_password_use_case.dart';
import 'package:inspector/domain/auth/usecases/reset_password_request_use_case.dart';
import 'package:inspector/domain/core/entities/failures.dart';
import 'package:inspector/presentation/core/blocs/core/base_state.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'reset_password_event.dart';

@injectable
class ResetPasswordBloc extends Bloc<ResetPasswordEvent, BaseState<Unit>> {
  final ResetPasswordRequestUseCase _resetPasswordRequestUseCase;
  final ConfirmResetPasswordUseCase _confirmResetPasswordUseCase;

  ResetPasswordBloc(this._resetPasswordRequestUseCase,this._confirmResetPasswordUseCase) : super(const BaseState()) {

    on<ResetPasswordRequested>((event, emit) async {
      emit(state.copyWith(status: BaseStatus.inProgress));
      final result = await _resetPasswordRequestUseCase(
        ResetPasswordRequestUseCaseParams(
          identifier: event.identifier,
        ),
      );
      result.fold(
        (failure) => emit(state.setFailureState(failure)),
        (_) => emit(state.copyWith(status: BaseStatus.success, item: unit,event: event)),
      );
    });


    on<ConfirmResetPasswordRequested>((event, emit) async {
      emit(state.copyWith(status: BaseStatus.inProgress));
      final result = await _confirmResetPasswordUseCase(
        ConfirmResetPasswordUseCaseParams(
          code: event.code,
          newPassword: event.code,
        ),
      );
      result.fold(
            (failure) => emit(state.setFailureState(failure)),
            (_) => emit(state.copyWith(status: BaseStatus.success, item: unit,event: event)),
      );
    });
  }
}
