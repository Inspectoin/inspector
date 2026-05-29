import 'dart:async';

import 'package:inspector/data/core/utils/configuration/configuration.dart';
import 'package:inspector/data/core/utils/logger_output.dart';
import 'package:inspector/domain/auth/repositories/auth_repository.dart';
import 'package:inspector/presentation/core/routes/router.dart';
import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';


import 'package:shared_preferences/shared_preferences.dart';

import 'injection.dart';


@module
abstract class InjectableModule {




  @preResolve
  @lazySingleton
  Future<SharedPreferences> get sharedPref => SharedPreferences.getInstance();

  @lazySingleton
  Dio get dioInstance {
    final dio = Dio(
      BaseOptions(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          //  "Accept-Language": 'en',
          },
          validateStatus: (statusCode) {
            if (statusCode != null) {
              if (200 <= statusCode && statusCode < 300) {
                return true;
              } else {
                return false;
              }
            } else {
              return false;
            }
          },
      ),
    );

    dio.interceptors.add(
      LogInterceptor(
          responseBody: true,
          requestBody: true,
          request: true,
          requestHeader: true,
          logPrint: (obj) {
            debugPrint(obj.toString());
          }),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) async {
          Map<String, String> headers;

          final failureOrUser = await getIt<AuthRepository>().getSignedInUser();
          final user = failureOrUser.getOrElse(() => null);


          print('new request accessToken : ${user?.accessToken}');
            headers = {
              if (user != null)
              'Authorization': 'Bearer ${user.accessToken}',
              'x-tenant-api-key': getIt<Configuration>().tenant
            };
            request.headers.addAll(headers);


          request.sendTimeout = const Duration(seconds: 20);
          request.connectTimeout = const Duration(seconds: 20);
          request.receiveTimeout = const Duration(seconds: 20);

          return handler.next(request);
        },
        onError: (DioException error, ErrorInterceptorHandler handler) async {




          return handler.next(error); // Pass the error along
        },
      ),
    );
    dio.interceptors.add(CurlLoggerDioInterceptor());
    return dio;
  }

  @lazySingleton
  Logger get logger => Logger(
   // printer: PrettyPrinter(),
    output: CrashlyticsLogOutput(),
  );





  @lazySingleton
  AppRouter get router => AppRouter();



  // @lazySingleton
  // Location get location => Location();
}
