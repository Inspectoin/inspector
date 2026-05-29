import 'package:inspector/data/auth/models/user/user_model.dart';
import 'package:inspector/data/core/datasource/remote/base_remote_datesource.dart';
import 'package:inspector/data/core/models/base_response/base_response.dart';
import 'package:inspector/data/core/utils/app_endpoints.dart';
import 'package:inspector/data/core/utils/configuration/configuration.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';


abstract class AuthRemoteDataSource {
  Future<BaseResponse> verifyOtp(String code);
  Future<BaseResponse> resendOtp(String phone);
  Future<BaseResponse<UserModel>> updateProfile(String fullName, String phone, String countryCode,String email,);
  Future<BaseResponse> updateProfileImage(String file);

  Future<BaseResponse<UserModel>> refreshToken(String token);

   Future<BaseResponse<UserModel>> signIn(String identifier, String password);
   Future<BaseResponse<UserModel>>  signUp ({
     required String id,
     required String username,
     required String name,
     required String phone,
     required String email,
     required String address,
     required String password,
   });


  Future<BaseResponse<UserModel>> getCurrentUser();

  Future<BaseResponse> deactivateAccount({required String email,required String reason});
  Future<BaseResponse> deleteAccount({required String email,required String reason});

  Future signOut();

  Future<BaseResponse> changePassword({
    required String oldPassword,
    required String newPassword,
  });


  Future<BaseResponse> removeFCMToken();



  Future<BaseResponse> resetPasswordRequest({
    required String identifier,
  });

  Future<BaseResponse> confirmResetPassword({
    required String code,
    required String newPassword,
  });

}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl extends BaseRemoteDatasourceImpl
    implements AuthRemoteDataSource {
  Dio _dio;
  Logger _logger;
  Configuration configuration;

  AuthRemoteDataSourceImpl( this._dio,this._logger,this.configuration) : super(_dio,_logger,configuration);

  @override
  Future<BaseResponse<UserModel>> refreshToken(String token) async{
    var result =  await apiRequest(
        requestType: RequestType.POST,
        url: configuration.baseUrl + AppEndpoints.REFRESH_TOKEN,
        body: {
          "refresh_token": token,
        }
    );


    var user =UserModel.fromJson(result.data['user_info']);
    user.accessToken=result.data['access_token'];
    user.refreshToken=result.data['refresh_token'];
    user.accessTokenExpiresAt=result.data['access_token_expires_at'];
    return BaseResponse(data: user);
  }

  @override
  Future<BaseResponse> deactivateAccount({required String email, required String reason}) {
    // TODO: implement deactivateAccount
    throw UnimplementedError();
  }

  @override
  Future<BaseResponse> deleteAccount({required String email, required String reason}) {
    // TODO: implement deleteAccount
    throw UnimplementedError();
  }

  @override
  Future<BaseResponse<UserModel>> getCurrentUser() async{
    var result =  await apiRequest(
        requestType: RequestType.GET,
        url: configuration.baseUrl + AppEndpoints.GET_MY_PROFILE,
    );
    var user =UserModel.fromJson(result.data);
    return BaseResponse(data:user );
  }

  @override
  Future<BaseResponse> removeFCMToken() {
    // TODO: implement removeFCMToken
    throw UnimplementedError();
  }

  @override
  Future signOut() async{

  }

  @override
  Future<BaseResponse> verifyOtp( String code) async{
    await apiRequest(
        requestType: RequestType.POST,
        url: configuration.baseUrl + AppEndpoints.VRIFY_OTP,
        body: {
          'code':code,
        }
    );

    return BaseResponse();
  }

  @override
  Future<BaseResponse<UserModel>> signIn(String identifier, String password) async{
    var result =  await apiRequest(
        requestType: RequestType.POST,
        url: configuration.baseUrl + AppEndpoints.SIGN_IN,
        body: {
          "identifier": identifier,
          "password": password
        }
    );


    var user =UserModel.fromJson(result.data['user_info']);
    user.accessToken=result.data['access_token'];
    user.refreshToken=result.data['refresh_token'];
    user.accessTokenExpiresAt=result.data['access_token_expires_at'];
    return BaseResponse(data: user);
  }

  @override
  Future<BaseResponse<UserModel>> signUp({required String id,required String username,required String name,required String phone , required String email, required String address, required String password}) async{
    var result =  await apiRequest(
        requestType: RequestType.POST,
        url: configuration.baseUrl + AppEndpoints.SIGN_UP,
        body: {
          "national_id": id,
          "name": name,
          "email": email,
          "password": password,
          "phone_number": phone,
          "username": username,
          "address": {
            "label": address,
          }
        }
    );
    var user =UserModel.fromJson(result.data['user']);
    user.accessToken=result.data['verification_access_token'];
    return BaseResponse(data:user );
  }

  @override
  Future<BaseResponse> resendOtp(String phone) async{
    await apiRequest(
        requestType: RequestType.POST,
        url: configuration.baseUrl + AppEndpoints.RESEND,
        body: {
          "phone_number": phone
        }
    );
    return BaseResponse();
  }

  @override
  Future<BaseResponse<UserModel>> updateProfile(String fullName, String phone, String countryCode,String email,) async {
    final response = await apiRequest(
      requestType: RequestType.PUT, // Or RequestType.PUT, depending on your API
      url: configuration.baseUrl + AppEndpoints.UPDATE_PROFILE, // Ensure AppEndpoints.UPDATE_PROFILE is defined
      body: {
        'name': fullName,
        'phone_number': phone,
        'phone_country_code': countryCode,
        'email': email,
        // 'profile_image_url':'',
        // 'national_id':''
      },
    );
    final user = UserModel.fromJson(response.data);
    return BaseResponse(data: user);
  }

  @override
  Future<BaseResponse> updateProfileImage(String file) async{

    MultipartFile multipartFile = await MultipartFile.fromFile(file,);

    Map<String, dynamic> requestBody = {
      'file': multipartFile,
    };

    await apiRequest(
    requestType: RequestType.POST,
    isFormData: true,
    url: configuration.baseUrl + AppEndpoints.UPLOAD_PROFILE_IMAGE, // Ensure AppEndpoints.CHANGE_PASSWORD is defined
    body:requestBody,
    );
    return BaseResponse();
  }

  @override
  Future<BaseResponse> changePassword({required String oldPassword, required String newPassword}) async {
    await apiRequest(
      requestType: RequestType.POST,
      url: configuration.baseUrl + AppEndpoints.CHANGE_PASSWORD, // Ensure AppEndpoints.CHANGE_PASSWORD is defined
      body: {
        "oldPassword": oldPassword,
        "newPassword":newPassword
      },
    );
    return BaseResponse();
  }

  @override
  Future<BaseResponse> resetPasswordRequest({required String identifier})  async{
    await apiRequest(
    requestType: RequestType.POST,
    url: configuration.baseUrl + AppEndpoints.RESET_PASSWORD_REQUEST,
    body: {
      "identifier": identifier,
      "captchaCode": "bypass_recaptcha_token"
    },
    );
    return BaseResponse();
  }

  @override
  Future<BaseResponse> confirmResetPassword({required String code, required String newPassword}) async{
    await apiRequest(
    requestType: RequestType.POST,
    url: configuration.baseUrl + AppEndpoints.CONFIRM_RESET_PASSWORD,
    body: {
      "resetPasswordCode": newPassword,
      "newPassword": newPassword
    },
    );
    return BaseResponse();
  }

}
