import 'package:inspector/domain/auth/entities/user.dart';
import 'package:inspector/domain/auth/usecases/update_profile_use_case.dart';
import 'package:inspector/presentation/core/blocs/core/base_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'update_profile_event.dart';

@injectable
class UpdateProfileBloc extends Bloc<UpdateProfileEvent, BaseState<User>> {
  final UpdateProfileUseCase _updateProfileUseCase;

  UpdateProfileBloc(this._updateProfileUseCase) : super(const BaseState()) {
    on<UpdateProfileRequested>((event, emit) async {
      emit(state.copyWith(status: BaseStatus.inProgress));
      final params = UpdateProfileUseCaseParams(
        fullName: event.fullName,
        phone: event.phone,
        countryCode: event.countryCode,
        email: event.email,
      );
      final failureOrUser = await _updateProfileUseCase(params);
      failureOrUser.fold(
        (failure) => emit(state.setFailureState(failure)),
        (user) => emit(BaseState(status: BaseStatus.success, item: user)),
      );
    });
  }
}
