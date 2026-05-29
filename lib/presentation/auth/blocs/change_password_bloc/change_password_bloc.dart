import 'package:bloc/bloc.dart';
import 'package:inspector/domain/auth/usecases/change_password_use_case.dart';
import 'package:inspector/domain/core/entities/failures.dart';
import 'package:inspector/presentation/core/blocs/core/base_state.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'change_password_event.dart';

@injectable
class ChangePasswordBloc extends Bloc<ChangePasswordEvent, BaseState<Unit>> {
  final ChangePasswordUseCase _changePasswordUseCase;

  ChangePasswordBloc(this._changePasswordUseCase) : super(const BaseState()) {
    on<ChangePasswordRequested>((event, emit) async {
      emit(state.copyWith(status: BaseStatus.inProgress));
      final result = await _changePasswordUseCase(
        ChangePasswordUseCaseParams(
          oldPassword: event.oldPassword,
          newPassword: event.newPassword,
        ),
      );
      result.fold(
        (failure) => emit(state.setFailureState(failure)),
        (_) => emit(state.copyWith(status: BaseStatus.success, item: unit)),
      );
    });
  }
}
