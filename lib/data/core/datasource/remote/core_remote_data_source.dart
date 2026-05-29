
import 'package:inspector/data/core/datasource/remote/base_remote_datesource.dart';
import 'package:inspector/data/core/utils/configuration/configuration.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';


abstract class CoreRemoteDataSource {



}

@LazySingleton(as: CoreRemoteDataSource)
class CoreRemoteDataSourceImpl extends BaseRemoteDatasourceImpl
    implements CoreRemoteDataSource {
  Dio _dio;
  Logger _logger;
  Configuration configuration;

  CoreRemoteDataSourceImpl( this._dio,this._logger,this.configuration) : super(_dio,_logger,configuration);







}
