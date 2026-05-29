
import 'package:inspector/domain/core/usecases/is_first_time_use_case.dart';
import 'package:inspector/domain/core/usecases/set_first_time_use_case.dart';
import 'package:inspector/domain/core/usecases/usecase.dart';
import 'package:inspector/presentation/core/blocs/core/base_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';


part 'first_time_event.dart';

@lazySingleton
class FirstTimeBloc extends Bloc<FirstTimeEvent, BaseState<bool>> {
  final IsFirstTimeUseCase isFirstTimeUseCase;
  final SetFirstTimeUseCase setFirstTimeUseCase;

  FirstTimeBloc(this.isFirstTimeUseCase,this.setFirstTimeUseCase) : super(const BaseState()) {
    on<CheckFirstTimeRequested>((event, emit) async {
      emit(const BaseState(status: BaseStatus.inProgress));

      final result = await isFirstTimeUseCase.call(NoParams());

      emit(
        result.fold(
              (l) => state.setFailureState(l),
              (r) =>  BaseState(
              status: BaseStatus.success,
              item: r
          ),
        ),
      );
    });

    on<SetFirstTimeRequested>((event, emit) async {
      emit(const BaseState(status: BaseStatus.inProgress));

      final result = await setFirstTimeUseCase.call(SetFirstTimeUseCaseParams(
          firstTimeValue: event.firstTimeValue));

      emit(
        result.fold(
              (l) => state.setFailureState(l),
              (r) =>  BaseState(
              status: BaseStatus.success,
              item: event.firstTimeValue
          ),
        ),
      );
    });
  }
}
