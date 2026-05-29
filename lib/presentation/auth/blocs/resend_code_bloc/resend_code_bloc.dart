import 'package:inspector/domain/auth/entities/user.dart';
import 'package:inspector/domain/auth/usecases/resend_otp_usecase.dart';
import 'package:inspector/domain/auth/usecases/verify_otp_usecase.dart';
import 'package:inspector/presentation/core/blocs/core/base_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';


part 'resend_code_event.dart';

@lazySingleton
class ResendCodeBloc extends Bloc<ResendCodeEvent, BaseState> {
  final ResendOtpUseCase resendOtpUseCase;

  ResendCodeBloc(this.resendOtpUseCase,
      ) : super(const BaseState()) {
    on<ResendCodeRequested>((event, emit) async {
      emit(const BaseState(status: BaseStatus.inProgress));
      final result = await resendOtpUseCase.call(ResendOtpUseCaseParams(
        phone: event.phone
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
