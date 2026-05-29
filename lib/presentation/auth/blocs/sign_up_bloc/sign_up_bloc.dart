import 'package:inspector/domain/auth/entities/user.dart';
import 'package:inspector/domain/auth/usecases/sign_up_usecase.dart';
import 'package:inspector/presentation/core/blocs/core/base_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';


part 'sign_up_event.dart';

@lazySingleton
class SignUpBloc extends Bloc<SignUpEvent, BaseState<User>> {
  final SignUpUseCase signUpUseCase;

  SignUpBloc(this.signUpUseCase,
      ) : super(const BaseState()) {
    on<SignUpRequested>((event, emit) async {
      emit(const BaseState(status: BaseStatus.inProgress));
      final result = await signUpUseCase.call(SignUpUpUseCaseParams(
          id: event.id,
          username: event.username,
          name: event.name,
          address: event.address,
          phone: event.phone,
          email: event.email,
          password: event.password));

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
