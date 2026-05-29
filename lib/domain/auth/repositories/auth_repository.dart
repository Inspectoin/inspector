import 'dart:async';
import 'dart:io'; // Added for File type

import 'package:inspector/domain/auth/usecases/change_password_use_case.dart';
import 'package:inspector/domain/auth/usecases/confirm_reset_password_use_case.dart';
import 'package:inspector/domain/auth/usecases/resend_otp_usecase.dart';
import 'package:inspector/domain/auth/usecases/reset_password_request_use_case.dart';
import 'package:inspector/domain/auth/usecases/sign_in_usecase.dart';
import 'package:inspector/domain/auth/usecases/sign_up_usecase.dart';
import 'package:inspector/domain/auth/usecases/update_profile_picture_use_case.dart';
import 'package:inspector/domain/auth/usecases/update_profile_use_case.dart';
import 'package:inspector/domain/auth/usecases/verify_otp_usecase.dart';
import 'package:inspector/domain/core/entities/failures.dart';
import 'package:inspector/domain/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:inspector/domain/auth/entities/user.dart';


abstract class AuthRepository {
  Future<Either<Failure, User?>> getSignedInUser();

  Future<Either<Failure, User>> signIn({required SignInUseCaseParams params});
  Future<Either<Failure, User>> singUp({required SignUpUpUseCaseParams params});
  Future<Either<Failure, Unit>> verifyOTP({required VerifyOtpUseCaseParams params});
  Future<Either<Failure, Unit>> resendOTP({required ResendOtpUseCaseParams params});
  Future<Either<Failure, Unit>> singOut({required NoParams params});
  Future<Either<Failure, Stream<User?>>> subscribeToAuthStatus();
  Future<Either<Failure, User>> getMine({required NoParams params});
  Future<Either<Failure, User>> updateProfile({required UpdateProfileUseCaseParams params});
  Future<Either<Failure, Unit>> changePassword({required ChangePasswordUseCaseParams params});
  Future<Either<Failure, Unit>> resetPasswordRequest({required ResetPasswordRequestUseCaseParams params});
  Future<Either<Failure, Unit>> confirmResetPassword({required ConfirmResetPasswordUseCaseParams params});
  Future<Either<Failure, Unit>> updateProfilePicture({required UpdateProfilePictureParams params});

}
