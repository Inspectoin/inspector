import 'dart:async';
import 'dart:io'; // Added for File type

import 'package:inspector/data/auth/datasources/local/auth_local_datasource.dart';
import 'package:inspector/domain/auth/entities/user.dart';
import 'package:inspector/domain/auth/repositories/auth_repository.dart';
import 'package:inspector/domain/auth/usecases/change_password_use_case.dart';
import 'package:inspector/domain/auth/usecases/confirm_reset_password_use_case.dart';
import 'package:inspector/domain/auth/usecases/resend_otp_usecase.dart';
import 'package:inspector/domain/auth/usecases/reset_password_request_use_case.dart';
import 'package:inspector/domain/auth/usecases/sign_in_usecase.dart';
import 'package:inspector/domain/auth/usecases/sign_up_usecase.dart';
import 'package:inspector/domain/auth/usecases/update_profile_picture_use_case.dart';
import 'package:inspector/domain/auth/usecases/update_profile_use_case.dart';
import 'package:inspector/domain/auth/usecases/verify_otp_usecase.dart';
import 'package:inspector/domain/core/usecases/usecase.dart';
import 'package:inspector/domain/core/utils/network/network_info.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:inspector/data/auth/datasources/remote/auth_remote_datasource.dart';
import 'package:inspector/data/auth/models/user/user_model.dart';
import 'package:inspector/data/core/repositories/base_repository_impl.dart';
import 'package:inspector/data/core/utils/configuration/configuration.dart';
import 'package:inspector/domain/core/entities/failures.dart';
import 'package:logger/logger.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl extends BaseRepositoryImpl implements AuthRepository {
  final AuthLocalDatasource local;
  final AuthRemoteDataSource remote;
  final Logger logger;
  final Configuration configuration;

  AuthRepositoryImpl(this.local, this.remote, this.logger,
      this.configuration)
      : super(logger);

  @override
  Future<Either<Failure, User?>> getSignedInUser() async{
    return getData(() async {
      var result =  local.getSignedInUser();
      return right(result?.toDomain());
    }, );


  }

  @override
  Future<Either<Failure, User>> signIn({required SignInUseCaseParams params}) {
    return request(() async {
      final result = await remote.signIn(params.identifier, params.password);
      local.signInUser(result.data!);
      return right(result.data!.toDomain());
    }, withCheckToken: false);
  }

  @override
  Future<Either<Failure, User>> singUp({required SignUpUpUseCaseParams params}) {
    return request(() async {
      final result = await remote.signUp(
          id: params.id,
          username: params.username,
          name: params.name,
          phone: params.phone,
          email: params.email,
          address: params.address,
          password: params.password);

      // save user data
      local.signInUser(result.data!);



      return right(result.data!.toDomain());
    }, withCheckToken: false);
  }

  @override
  Future<Either<Failure, User>> getMine({required NoParams params}) {
    return request(() async {

      final result = await remote.getCurrentUser();

      var oldUser = local.getSignedInUser();
      var newUser =result.data;

      if(oldUser != null) {
        // save user data
        newUser?.accessToken=oldUser.accessToken;
        newUser?.refreshToken=oldUser.refreshToken;
        newUser?.accessTokenExpiresAt=oldUser.accessTokenExpiresAt;
      }
      local.signInUser(newUser!);
      return right(result.data!.toDomain());
    });
  }

  @override
  Future<Either<Failure, Unit>> singOut({required NoParams params}) {
    return request(() async {
       local.logout();
       local.authStatus.add(null);



       return right(unit);
    },
      withCheckConnection: false,
      withCheckToken: false
    );
  }

  @override
  Future<Either<Failure, Stream<User?>>> subscribeToAuthStatus() async {
    return right(local.authStatus.stream.map((event) => event?.toDomain()));
  }

  @override
  Future<Either<Failure, Unit>> resendOTP({required ResendOtpUseCaseParams params}) {
    return request(() async {

      local.getSignedInUser();
       await remote.resendOtp(
        params.phone
      );

      return right(unit);
    }, withCheckToken: false);
  }

  @override
  Future<Either<Failure, Unit>> verifyOTP({required VerifyOtpUseCaseParams params}) {
    return request(() async {
      final result = await remote.verifyOtp(
          params.code
      );

      local.logout();


      return right(unit);
    }, withCheckToken: false);
  }

  @override
  Future<Either<Failure, User>> updateProfile({required UpdateProfileUseCaseParams params}) {
    return request(() async {
      final result = await remote.updateProfile(
        params.fullName,
        params.phone,
        params.countryCode,
        params.email,
      );
      if (result.data != null) {
         var oldUser = local.getSignedInUser();
         var newUser =result.data;
         if(oldUser != null) {
            newUser?.accessToken=oldUser.accessToken;
            newUser?.refreshToken=oldUser.refreshToken;
            newUser?.accessTokenExpiresAt=oldUser.accessTokenExpiresAt;
         }
        local.signInUser(newUser!);
      }
      return right(result.data!.toDomain());
    });
  }

 @override
  Future<Either<Failure, Unit>> changePassword({required ChangePasswordUseCaseParams params}) {
    return request(() async {
      await remote.changePassword(
        oldPassword: params.oldPassword,
        newPassword: params.newPassword,
      );
      // local.logout(); // Uncomment if you want to force logout after password change
      return right(unit);
    });
  }

  @override
  Future<Either<Failure, Unit>> updateProfilePicture({required UpdateProfilePictureParams params}) {
    return request(() async {
      final result = await remote.updateProfileImage(params.imagePath);
      return right(unit);
    });
  }

  @override
  Future<Either<Failure, Unit>> confirmResetPassword({required ConfirmResetPasswordUseCaseParams params}) {
    return request(() async {
      await remote.confirmResetPassword(
       code : params.code,
        newPassword: params.newPassword,
      );
      return right(unit);
    },
        withCheckToken: false

    );
  }

  @override
  Future<Either<Failure, Unit>> resetPasswordRequest({required ResetPasswordRequestUseCaseParams params}) {
    return request(() async {
      await remote.resetPasswordRequest(
        identifier: params.identifier,
      );
      return right(unit);
    },
        withCheckToken: false
    );
  }
}
