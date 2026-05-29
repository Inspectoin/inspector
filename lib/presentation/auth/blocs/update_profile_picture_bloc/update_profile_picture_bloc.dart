import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:inspector/domain/auth/entities/user.dart';
import 'package:inspector/domain/auth/usecases/update_profile_picture_use_case.dart';
import 'package:inspector/presentation/core/blocs/core/base_state.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'update_profile_picture_event.dart';

@injectable
class UpdateProfilePictureBloc extends Bloc<UpdateProfilePictureEvent, BaseState<User>> {
  final UpdateProfilePictureUseCase _updateProfilePictureUseCase;

  UpdateProfilePictureBloc(this._updateProfilePictureUseCase)
      : super(const BaseState()) {
    on<UpdateProfilePictureRequested>(_onUpdateProfilePictureRequested);
  }

  Future<void> _onUpdateProfilePictureRequested(
    UpdateProfilePictureRequested event,
    Emitter<BaseState<User>> emit,
  ) async {
    emit(state.copyWith(status: BaseStatus.inProgress));
    final result = await _updateProfilePictureUseCase(
      UpdateProfilePictureParams(imagePath: event.imagePath),
    );
    result.fold(
      (failure) => emit(state.setFailureState(failure)),
      (user) => emit(state.copyWith(status: BaseStatus.success,)),
    );
  }
}
