import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;

import 'package:inspector/data/auth/datasources/local/auth_local_datasource.dart';
import 'package:inspector/data/auth/datasources/remote/auth_remote_datasource.dart';
import 'package:inspector/data/auth/models/user/user_model.dart';
import 'package:inspector/data/core/models/base_response/base_response.dart';
import 'package:inspector/data/core/utils/app_endpoints.dart';
import 'package:inspector/domain/core/entities/failures.dart';
import 'package:inspector/domain/core/repositories/base_repository.dart';
import 'package:inspector/domain/core/utils/constants.dart';
import 'package:inspector/domain/core/utils/network/network_info.dart';
import 'package:inspector/injection.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:logger/logger.dart';

class BaseRepositoryImpl implements BaseRepository {
  final AuthRemoteDataSource _authRemote = getIt<AuthRemoteDataSource>();
  final AuthLocalDatasource authLocal = getIt<AuthLocalDatasource>();
  final Logger _logger;

  BaseRepositoryImpl( this._logger);


  /// for Api request
  @override
  Future<Either<Failure, T>> request<T>(FutureEitherFailureOrData<T> body,
      {bool withCheckToken=true,bool withCheckConnection = true }) async {
    try {


    //   if (!await _networkInfo.isConnected && withCheckConnection==true) {
    //     return left(
    //       ServerFailure(errorCode: ServerErrorCode.noInternetConnection));
    // }


   // token
   var error=  await checkToken(withCheckToken);
    if(error!=null){
      return left(error) ;
    }


    /// body request
      return await body();
    } catch (e,stackTrace) {
      print('Exception');
      bool isTestEnvironment = Platform.environment.containsKey('FLUTTER_TEST');

      if (!isTestEnvironment) {
        // Report error to Firebase Crashlytics
        // await FirebaseCrashlytics.instance.recordError(
        //   e,
        //   stackTrace,
        //   reason: e,
        // );
      }



      if (e is DioException) {
        return  handleDioException(e);
      }

      _logger.e(e.toString(),error:  e,stackTrace:  stackTrace);

      return left(ServerFailure(errorCode: ServerErrorCode.serverError,message: e.toString()));
    }
  }





  Future<Failure?> checkToken(bool checkToken) async{


    print('checkToken  $checkToken' );
    /// check token
    if (checkToken) {

      final user = authLocal.getSignedInUser();
      _logger.d('Checking Token');



      if (user != null && user.accessTokenExpiresAt!=null) {



        try{
          if (isTokenExpired(user.accessTokenExpiresAt??0)) {

            _logger.e('Token Expired');
            //get new token from cognito session
            BaseResponse response =
            await _authRemote.refreshToken(user.refreshToken??'');


            await updateToken(response.data);
          }
        }catch(e,stackTrace){

          // // Report error to Firebase Crashlytics
          // FirebaseCrashlytics.instance.recordError(
          //   e,
          //   stackTrace,
          //   reason: e,
          // );

          _logger.d('Checking Token Error');
          _logger.e(e.toString(),error: e,stackTrace: stackTrace);

          signOut();
          return ServerFailure(errorCode: ServerErrorCode.unauthenticated);

        }

      }else{
        signOut();
        return ServerFailure(errorCode: ServerErrorCode.unauthenticated);

      }
    }
    return null;
  }




  updateToken(UserModel newUser) async{
    // save new token
    await authLocal.signInUser(newUser);
    //change token in dio
    final dio = getIt<Dio>();
    dio.options.headers['Authorization'] = 'Bearer ${newUser.accessToken}';

  }


  Either<Failure, T> handleDioException<T>(DioException e) {

    print(e.response?.statusCode);

    _logger.e(e.message,error: e,stackTrace: e.stackTrace);

    var message = '';
    var errorCode = ServerErrorCode.serverError;



    if (e.response != null) {
      errorCode = _getErrorCode(e.response!.statusCode ?? 500);

      try {



        final responseData = e.response?.data is String
            ? jsonDecode(e.response!.data) //convret from json to map
            : e.response!.data;

        final baseResponse =
        BaseResponse.fromJson(responseData, (_) => null);

        message = baseResponse.code ?? baseResponse.message ??  e.response!.data['message']?? '';
        print('base repository message');
        print(message);

        print(errorCode);


          if (errorCode == ServerErrorCode.invalidRefreshToken ||
              errorCode == ServerErrorCode.invalidAccessToken || errorCode ==ServerErrorCode.unauthenticated
          ) {


            final uri = e.requestOptions.uri;

            if(!uri.toString().contains(AppEndpoints.SIGN_IN)){
              authLocal.authStatus.add(null);
              authLocal.logout();
              _authRemote.signOut();
            }

            return left(
                ServerFailure(errorCode: errorCode,message: message,serverCode: baseResponse.code ));
          } else {
            return left(
              ServerFailure(
                  errorCode: errorCode,
                  message: message,
                  args: baseResponse.args,
                  serverCode: baseResponse.code
              ),
            );
          }

      } catch (e,stackTrace) {
        // Report error to Firebase Crashlytics
        //  FirebaseCrashlytics.instance.recordError(
        //   e,
        //   stackTrace,
        //    reason: e,
        // );
        return left(
          ServerFailure(
            errorCode: errorCode,
            message: message,
          ),
        );
      }
    }

    return left(
        ServerFailure(errorCode: ServerErrorCode.serverError));
  }




  bool isTokenExpired(int accessTokenExpiresAt) {
    final expiryDate = DateTime.fromMillisecondsSinceEpoch(accessTokenExpiresAt * 1000);
    final now = DateTime.now();
    return expiryDate.isBefore(now);
  }


  // checkInternetConnection()async{
  //   _logger.e('internet status ${await _networkInfo.isConnected}');
  //   if (!await _networkInfo.isConnected) {
  //     return left(
  //         ServerFailure(errorCode: ServerErrorCode.noInternetConnection));
  //   }
  // }


  ServerErrorCode _getErrorCode(int statusCode) {
    switch (statusCode) {
      case 401:
        return ServerErrorCode.unauthenticated;
      case 404:
        return ServerErrorCode.notFound;
      case 403:
        return ServerErrorCode.forbidden;
      case 400:
        return ServerErrorCode.invalidData;
      case 422:
        return ServerErrorCode.wrongInput;
      case 502:
        return ServerErrorCode.wrongInput;
      default:
        return ServerErrorCode.serverError;
    }
  }



  signOut(){
    authLocal.authStatus.add(null);
    authLocal.logout();
    _authRemote.signOut();
  }

  @override
  Future<Either<Failure, T>> getData<T>(FutureEitherFailureOrData<T> body) async{
    try {

      /// body request
      return await body();
    } catch (e,stackTrace) {
      return left(ServerFailure(errorCode: ServerErrorCode.localError,message: e.toString()));
    }
  }

}
