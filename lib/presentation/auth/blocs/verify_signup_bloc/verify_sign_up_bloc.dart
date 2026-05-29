import 'package:inspector/domain/auth/entities/user.dart';
import 'package:inspector/domain/auth/usecases/verify_otp_usecase.dart';
import 'package:inspector/presentation/core/blocs/core/base_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';


part 'verify_sign_up_event.dart';

@lazySingleton
class VerifySignUpBloc extends Bloc<VerifySignUpEvent, BaseState<User>> {
  final VerifyOtpUseCase verifyOtpUseCase;

  VerifySignUpBloc(this.verifyOtpUseCase,
      ) : super(const BaseState()) {
    on<VerifySignUpRequested>((event, emit) async {
      emit(const BaseState(status: BaseStatus.inProgress));
      final result = await verifyOtpUseCase.call(VerifyOtpUseCaseParams(
        code: event.code
      ));

      emit(
        result.fold(
              (l) => state.setFailureState(l),
              (r) =>  BaseState(
              status: BaseStatus.success,
                event: event
          ),
        ),
      );
    });
  }
}
