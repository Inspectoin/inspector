import 'package:dio/dio.dart';
import 'package:dio/src/response.dart' as dioResponse;
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../../utils/configuration/configuration.dart';

abstract class BaseRemoteDatasource {

  Future<dioResponse.Response> apiRequest(
      {required RequestType requestType, required String url, Map? body, Map<String,
          dynamic>? params});


}

@Injectable(as: BaseRemoteDatasource)
class BaseRemoteDatasourceImpl extends BaseRemoteDatasource{


  Dio _dio;
  Logger _logger;
  Configuration _configuration;

  BaseRemoteDatasourceImpl(this._dio,this._logger,this._configuration) {
  }



  @override
  Future<dioResponse.Response> apiRequest(
      {required RequestType requestType,
        required String url, Object? body, Map<String,
          dynamic>? params,
      bool isFormData=false,
      }) async {



    _logger.d('api requests body $body');

    switch (requestType) {
      case RequestType.GET:
        return await _dio.get(url, queryParameters: params);
      case RequestType.POST:
      return await _dio.post(url, data:  isFormData ? FormData.fromMap(body! as Map<String, dynamic>) : body,);
      case RequestType.PUT:
        return await _dio.put(url, data:  isFormData ? FormData.fromMap(body! as Map<String, dynamic>) : body,);
      case RequestType.DELETE:
        return await _dio.delete(
            url, data: body, queryParameters: params);
      default:
    }
    throw Exception('Select method for HTTP request');
  }



}

enum RequestType { GET, POST, PUT, DELETE }
