import 'package:inspector/domain/auth/entities/user.dart';
import 'package:inspector/domain/auth/usecases/get_mine_usecase.dart';
import 'package:inspector/domain/auth/usecases/sign_in_usecase.dart';
import 'package:inspector/domain/auth/usecases/sign_out_usecase.dart';
import 'package:inspector/domain/auth/usecases/subscribe_to_auth_status.dart';
import 'package:inspector/domain/core/entities/failures.dart';
import 'package:inspector/domain/core/usecases/usecase.dart';
import 'package:inspector/domain/core/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'auth_event.dart';

part 'auth_state.dart';

@Singleton()
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetMineUseCase getMineUseCase;
  final SubscribeToAuthStatusUseCase subscribeToAuthStatusUseCase;
  final SignInUseCase signInUseCase;
  final SignOutUseCase signOutUseCase;

  // this for initial page after initial page done will be true
  // i using it to listen to expired token in main.dart to close all pages
  bool allowEvents=false;

  AuthBloc(
    this.getMineUseCase,
    this.signInUseCase,
    this.subscribeToAuthStatusUseCase,
    this.signOutUseCase,
  ) : super(AuthInitial()) {
    on<AuthSignIn>(
          (event, emit) async {
         //   allowEvents=false;

            emit(AuthLoading());
        final result = await signInUseCase.call(SignInUseCaseParams(
            identifier: event.identifier, password: event.password));
        await result.fold(
              (failure) async {
            if (failure is ServerFailure &&
                failure.errorCode == ServerErrorCode.unauthenticated) {
              emit(Unauthenticated(failure));
            } else {
              emit(AuthFailure(failure));
            }
          },
              (user) async {
           //     allowEvents=true;
                emit(Authenticated(user: user));
          },
        );
      },
    );
    on<AuthCheckRequested>(
      (event, emit) async {
        emit(AuthLoading());
        final result = await getMineUseCase.call(NoParams());
        await result.fold(
          (failure) async {
            emit(AuthFailure(failure));
          },
          (user) async {
         //   allowEvents=true;
            emit(
              Authenticated(
                user: user,
              ),
            );
          },
        );
      },
    );
    on<SubscribeToAuthStatus>(
      (event, emit) async {
        final result = await subscribeToAuthStatusUseCase.call(NoParams());
        await result.fold(
          (l) => null,
          (authStatus) async {
            await emit.onEach<User?>(
              authStatus,
              onData: (user) {
                if (user == null) {
                  emit(Unauthenticated(ServerFailure(message: '', errorCode: ServerErrorCode.unauthenticated)));
                } else {
                  emit(
                    Authenticated(
                      user: user,
                    ),
                  );
                }
              },
            );
          },
        );
      },
    );
    on<AuthLogout>(
      (event, emit) {
        signOutUseCase.call(NoParams());
      },
    );
  }
}
