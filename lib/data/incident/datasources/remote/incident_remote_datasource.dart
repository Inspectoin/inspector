import 'dart:io';

import 'package:inspector/data/auth/models/user/user_model.dart';
import 'package:inspector/data/core/datasource/remote/base_remote_datesource.dart';
import 'package:inspector/data/core/models/base_list_response/base_list_response.dart';
import 'package:inspector/data/core/models/base_response/base_response.dart';
import 'package:inspector/data/core/utils/app_endpoints.dart';
import 'package:inspector/data/core/utils/configuration/configuration.dart';
import 'package:inspector/data/incident/model/incident_model/incident_model.dart';
import 'package:inspector/data/incident/model/incident_type_model/incident_type_model.dart';
import 'package:inspector/data/incident/models/incident_file_model.dart';
import 'package:inspector/presentation/core/blocs/core/base_paginated_list_state.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';


abstract class IncidentRemoteDatasource {

 
  



  Future<BaseResponse<IncidentModel>> createIncident({
    required String incidentTypeId,
    required String categoryId,
    required String description,
    required String labelLocation,
    required String coordinatesLocation,
    required bool hideMyInfo,
    required List<String> files,
  });

  Future<BaseListResponse<List<IncidentTypeModel>>> getIncidentTypes();

  Future<BaseListResponse<List<IncidentModel>>> getIncidents({
    int? page, 
    int? limit, 
  });

  Future<BaseResponse<IncidentModel>> getIncident({required String id});
  Future<IncidentFileModel> uploadIncidentFile({required File file});

}

@LazySingleton(as: IncidentRemoteDatasource)
class IncidentRemoteDatasourceImpl extends BaseRemoteDatasourceImpl
    implements IncidentRemoteDatasource {
  Dio _dio;
  Logger _logger;
  Configuration configuration;

  IncidentRemoteDatasourceImpl( this._dio,this._logger,this.configuration) : super(_dio,_logger,configuration);



  



  @override
  Future<BaseResponse<IncidentModel>> createIncident({
    required String incidentTypeId,
    required String categoryId,
    required String description,
    required String labelLocation,
    required String coordinatesLocation,
    required bool hideMyInfo,
    required List<String> files,
  }) async {

    Map<String, dynamic> requestBody = {
      "incident_type_id": incidentTypeId,
      "category_id": categoryId,
      "description": description,
      "location": {
        //"label": labelLocation,
        "coordinates": coordinatesLocation,
      },
      'hide_my_info':hideMyInfo,
      'files':files
    };

    // List<MultipartFile> multipartFiles = [];
    // for(var file in files){
    //   var multipartFile = await MultipartFile.fromFile(file);
    //   multipartFiles.add(multipartFile);
    // }

    var result = await apiRequest(
      requestType: RequestType.POST,
      isFormData: false,
      url: configuration.baseUrl + AppEndpoints.CREATE_INCIDENT,
      body: requestBody,
    );


    IncidentModel incident = IncidentModel.fromJson(result.data);

    return BaseResponse(data: incident);
  }


  @override
  Future<BaseListResponse<List<IncidentTypeModel>>> getIncidentTypes() async {
    final String getTypesEndpoint = configuration.baseUrl + AppEndpoints.GET_INCIDENTS_TYPE;


      var result = await apiRequest(
        requestType: RequestType.GET,
        url: getTypesEndpoint,
      );

        List<dynamic> typesJson = result.data['incident_types'];
        List<IncidentTypeModel> incidentTypes = typesJson
            .map((typeJson) => IncidentTypeModel.fromJson(typeJson as Map<String, dynamic>))
            .toList();
    return BaseListResponse<List<IncidentTypeModel>> (data: incidentTypes);

  }




  @override
  Future<BaseListResponse<List<IncidentModel>>> getIncidents({
        int? page,
        int? limit,
      }) async {
    final String getIncidentsEndpoint =
        configuration.baseUrl + AppEndpoints.GET_MY_INCIDENTS;

    Map<String, dynamic> queryParameters = {};
    if (page != null) queryParameters['page'] = page;
    if (limit != null) queryParameters['limit'] = limit;

    var result = await apiRequest(
      requestType: RequestType.GET,
      url: getIncidentsEndpoint,
      params: queryParameters.isNotEmpty ? queryParameters : null,
    );

    List<dynamic> incidentsJson = result.data as List<dynamic>;
    List<IncidentModel> incidents = incidentsJson
        .map((incidentJson) =>
        IncidentModel.fromJson(incidentJson as Map<String, dynamic>))
        .toList();
    return BaseListResponse<List<IncidentModel>>(data: incidents);
  }


  @override
  Future<BaseResponse<IncidentModel>> getIncident({required String id}) async {

    final String getIncidentEndpoint = "${configuration.baseUrl}${AppEndpoints.GET_INCIDENT(id)}";

    var result = await apiRequest(
      requestType: RequestType.GET,
      url: getIncidentEndpoint,
    );

    IncidentModel incident = IncidentModel.fromJson(result.data as Map<String, dynamic>);
    return BaseResponse(data: incident);
  }

  @override
  Future<IncidentFileModel> uploadIncidentFile({required File file}) async {
    final String uploadUrl = configuration.baseUrl + AppEndpoints.UPLOAD_INCIDENT_FILE;

    MultipartFile multipartFile = await MultipartFile.fromFile(file.path, filename: file.path.split('/').last);

    Map<String, dynamic> requestBody = {
      'file': multipartFile,
    };

    var result = await apiRequest(
      requestType: RequestType.POST,
      isFormData: true,
      url: uploadUrl,
      body: requestBody,
    );

    return IncidentFileModel.fromJson(result.data as Map<String, dynamic>);
  }


}
