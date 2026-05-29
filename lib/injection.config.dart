// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:inspector/data/auth/datasources/local/auth_local_datasource.dart'
    as _i348;
import 'package:inspector/data/auth/datasources/remote/auth_remote_datasource.dart'
    as _i921;
import 'package:inspector/data/auth/repositories/auth_repository_impl.dart'
    as _i989;
import 'package:inspector/data/core/datasource/local/core_local_datasource.dart'
    as _i382;
import 'package:inspector/data/core/datasource/remote/base_remote_datesource.dart'
    as _i152;
import 'package:inspector/data/core/datasource/remote/core_remote_data_source.dart'
    as _i353;
import 'package:inspector/data/core/datasources/local/core_local_datasource.dart'
    as _i354;
import 'package:inspector/data/core/repositories/core_repository_impl.dart'
    as _i912;
import 'package:inspector/data/core/utils/configuration/configuration.dart'
    as _i530;
import 'package:inspector/data/core/utils/configuration/dev_configuration.dart'
    as _i629;
import 'package:inspector/data/core/utils/configuration/prod_configuration.dart'
    as _i354;
import 'package:inspector/data/core/utils/configuration/qa_configuration.dart'
    as _i455;
import 'package:inspector/data/core/utils/device_info.dart' as _i855;
import 'package:inspector/data/incident/datasources/remote/incident_remote_datasource.dart'
    as _i416;
import 'package:inspector/data/incident/repositories/incident_repository_impl.dart'
    as _i353;
import 'package:inspector/domain/auth/repositories/auth_repository.dart'
    as _i989;
import 'package:inspector/domain/auth/usecases/change_password_use_case.dart'
    as _i358;
import 'package:inspector/domain/auth/usecases/confirm_reset_password_use_case.dart'
    as _i989;
import 'package:inspector/domain/auth/usecases/get_mine_usecase.dart' as _i418;
import 'package:inspector/domain/auth/usecases/resend_otp_usecase.dart'
    as _i362;
import 'package:inspector/domain/auth/usecases/reset_password_request_use_case.dart'
    as _i494;
import 'package:inspector/domain/auth/usecases/sign_in_usecase.dart' as _i650;
import 'package:inspector/domain/auth/usecases/sign_out_usecase.dart' as _i346;
import 'package:inspector/domain/auth/usecases/sign_up_usecase.dart' as _i981;
import 'package:inspector/domain/auth/usecases/subscribe_to_auth_status.dart'
    as _i739;
import 'package:inspector/domain/auth/usecases/update_profile_picture_use_case.dart'
    as _i215;
import 'package:inspector/domain/auth/usecases/update_profile_use_case.dart'
    as _i627;
import 'package:inspector/domain/auth/usecases/verify_otp_usecase.dart'
    as _i211;
import 'package:inspector/domain/core/repositories/core_repository.dart'
    as _i988;
import 'package:inspector/domain/core/usecases/get_session_status_usecase.dart'
    as _i714;
import 'package:inspector/domain/core/usecases/is_first_time_use_case.dart'
    as _i191;
import 'package:inspector/domain/core/usecases/set_first_time_use_case.dart'
    as _i755;
import 'package:inspector/domain/core/usecases/set_session_status_usecase.dart'
    as _i96;
import 'package:inspector/domain/incident/repositories/incident_repository.dart'
    as _i960;
import 'package:inspector/domain/incident/usecases/create_incident_usecase.dart'
    as _i367;
import 'package:inspector/domain/incident/usecases/get_incident_types_usecase.dart'
    as _i621;
import 'package:inspector/domain/incident/usecases/get_incident_usecase.dart'
    as _i460;
import 'package:inspector/domain/incident/usecases/get_incidents_usecase.dart'
    as _i90;
import 'package:inspector/domain/incident/usecases/upload_incident_file_use_case.dart'
    as _i285;
import 'package:inspector/injectable_module.dart' as _i315;
import 'package:inspector/presentation/auth/blocs/auth_bloc/auth_bloc.dart'
    as _i187;
import 'package:inspector/presentation/auth/blocs/change_password_bloc/change_password_bloc.dart'
    as _i815;
import 'package:inspector/presentation/auth/blocs/resend_code_bloc/resend_code_bloc.dart'
    as _i116;
import 'package:inspector/presentation/auth/blocs/reset_password_bloc/reset_password_bloc.dart'
    as _i672;
import 'package:inspector/presentation/auth/blocs/sign_up_bloc/sign_up_bloc.dart'
    as _i400;
import 'package:inspector/presentation/auth/blocs/update_profile_bloc/update_profile_bloc.dart'
    as _i271;
import 'package:inspector/presentation/auth/blocs/update_profile_picture_bloc/update_profile_picture_bloc.dart'
    as _i887;
import 'package:inspector/presentation/auth/blocs/verify_signup_bloc/verify_sign_up_bloc.dart'
    as _i334;
import 'package:inspector/presentation/core/blocs/first_time_bloc/first_time_bloc.dart'
    as _i641;
import 'package:inspector/presentation/core/blocs/session_settings_bloc/session_settings_bloc.dart'
    as _i752;
import 'package:inspector/presentation/core/routes/router.dart' as _i649;
import 'package:inspector/presentation/incident/blocs/create_incident_bloc/create_incident_bloc.dart'
    as _i1034;
import 'package:inspector/presentation/incident/blocs/get_incident_bloc/get_incident_bloc.dart'
    as _i849;
import 'package:inspector/presentation/incident/blocs/get_incident_types_bloc/get_incident_types_bloc.dart'
    as _i372;
import 'package:inspector/presentation/incident/blocs/get_incidents_bloc/get_incidents_bloc.dart'
    as _i597;
import 'package:inspector/presentation/incident/blocs/hilight_item_bloc/highlight_item_bloc.dart'
    as _i1045;
import 'package:inspector/presentation/incident/blocs/upload_incident_file_bloc/upload_incident_file_bloc.dart'
    as _i873;
import 'package:logger/logger.dart' as _i974;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

const String _dev = 'dev';
const String _qa = 'qa';
const String _prod = 'prod';

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final injectableModule = _$InjectableModule();
    gh.factory<_i855.DeviceInfo>(() => _i855.DeviceInfo());
    await gh.lazySingletonAsync<_i460.SharedPreferences>(
      () => injectableModule.sharedPref,
      preResolve: true,
    );
    gh.lazySingleton<_i361.Dio>(() => injectableModule.dioInstance);
    gh.lazySingleton<_i974.Logger>(() => injectableModule.logger);
    gh.lazySingleton<_i649.AppRouter>(() => injectableModule.router);
    gh.lazySingleton<_i1045.HighlightItemBloc>(
        () => _i1045.HighlightItemBloc());
    gh.lazySingleton<_i530.Configuration>(
      () => _i629.DevConfiguration(),
      registerFor: {_dev},
    );
    gh.lazySingleton<_i530.Configuration>(
      () => _i455.QAConfiguration(),
      registerFor: {_qa},
    );
    gh.lazySingleton<_i354.CoreLocalDataSource>(
        () => _i354.CoreLocalDataSourceImpl(gh<_i460.SharedPreferences>()));
    gh.lazySingleton<_i921.AuthRemoteDataSource>(
        () => _i921.AuthRemoteDataSourceImpl(
              gh<_i361.Dio>(),
              gh<_i974.Logger>(),
              gh<_i530.Configuration>(),
            ));
    gh.lazySingleton<_i353.CoreRemoteDataSource>(
        () => _i353.CoreRemoteDataSourceImpl(
              gh<_i361.Dio>(),
              gh<_i974.Logger>(),
              gh<_i530.Configuration>(),
            ));
    gh.lazySingleton<_i348.AuthLocalDatasource>(
      () => _i348.AuthLocalDatasourceImpl(gh<_i460.SharedPreferences>()),
      dispose: (i) => i.dispose(),
    );
    gh.lazySingleton<_i530.Configuration>(
      () => _i354.ProductionConfiguration(),
      registerFor: {_prod},
    );
    gh.lazySingleton<_i416.IncidentRemoteDatasource>(
        () => _i416.IncidentRemoteDatasourceImpl(
              gh<_i361.Dio>(),
              gh<_i974.Logger>(),
              gh<_i530.Configuration>(),
            ));
    gh.lazySingleton<_i382.CoreLocalDataSource>(
        () => _i382.CoreLocalDataSourceImpl(gh<_i460.SharedPreferences>()));
    gh.factory<_i152.BaseRemoteDatasource>(() => _i152.BaseRemoteDatasourceImpl(
          gh<_i361.Dio>(),
          gh<_i974.Logger>(),
          gh<_i530.Configuration>(),
        ));
    gh.lazySingleton<_i988.CoreRepository>(() => _i912.CoreRepositoryImpl(
          gh<_i353.CoreRemoteDataSource>(),
          gh<_i974.Logger>(),
          gh<_i530.Configuration>(),
        ));
    gh.lazySingleton<_i191.IsFirstTimeUseCase>(
        () => _i191.IsFirstTimeUseCase(repository: gh<_i988.CoreRepository>()));
    gh.lazySingleton<_i755.SetFirstTimeUseCase>(() =>
        _i755.SetFirstTimeUseCase(repository: gh<_i988.CoreRepository>()));
    gh.lazySingleton<_i96.SetSessionStatusUseCase>(() =>
        _i96.SetSessionStatusUseCase(repository: gh<_i988.CoreRepository>()));
    gh.lazySingleton<_i714.GetSessionStatusUseCase>(() =>
        _i714.GetSessionStatusUseCase(repository: gh<_i988.CoreRepository>()));
    gh.lazySingleton<_i641.FirstTimeBloc>(() => _i641.FirstTimeBloc(
          gh<_i191.IsFirstTimeUseCase>(),
          gh<_i755.SetFirstTimeUseCase>(),
        ));
    gh.lazySingleton<_i989.AuthRepository>(() => _i989.AuthRepositoryImpl(
          gh<_i348.AuthLocalDatasource>(),
          gh<_i921.AuthRemoteDataSource>(),
          gh<_i974.Logger>(),
          gh<_i530.Configuration>(),
        ));
    gh.lazySingleton<_i960.IncidentRepository>(
        () => _i353.IncidentRepositoryImpl(
              gh<_i416.IncidentRemoteDatasource>(),
              gh<_i974.Logger>(),
              gh<_i530.Configuration>(),
            ));
    gh.lazySingleton<_i215.UpdateProfilePictureUseCase>(() =>
        _i215.UpdateProfilePictureUseCase(
            repository: gh<_i989.AuthRepository>()));
    gh.factory<_i752.SessionSettingsBloc>(() => _i752.SessionSettingsBloc(
          gh<_i96.SetSessionStatusUseCase>(),
          gh<_i714.GetSessionStatusUseCase>(),
        ));
    gh.lazySingleton<_i358.ChangePasswordUseCase>(
        () => _i358.ChangePasswordUseCase(gh<_i989.AuthRepository>()));
    gh.lazySingleton<_i989.ConfirmResetPasswordUseCase>(
        () => _i989.ConfirmResetPasswordUseCase(gh<_i989.AuthRepository>()));
    gh.lazySingleton<_i494.ResetPasswordRequestUseCase>(
        () => _i494.ResetPasswordRequestUseCase(gh<_i989.AuthRepository>()));
    gh.factory<_i815.ChangePasswordBloc>(
        () => _i815.ChangePasswordBloc(gh<_i358.ChangePasswordUseCase>()));
    gh.factory<_i887.UpdateProfilePictureBloc>(() =>
        _i887.UpdateProfilePictureBloc(
            gh<_i215.UpdateProfilePictureUseCase>()));
    gh.factory<_i672.ResetPasswordBloc>(() => _i672.ResetPasswordBloc(
          gh<_i494.ResetPasswordRequestUseCase>(),
          gh<_i989.ConfirmResetPasswordUseCase>(),
        ));
    gh.lazySingleton<_i362.ResendOtpUseCase>(
        () => _i362.ResendOtpUseCase(gh<_i989.AuthRepository>()));
    gh.lazySingleton<_i739.SubscribeToAuthStatusUseCase>(
        () => _i739.SubscribeToAuthStatusUseCase(gh<_i989.AuthRepository>()));
    gh.lazySingleton<_i650.SignInUseCase>(
        () => _i650.SignInUseCase(gh<_i989.AuthRepository>()));
    gh.lazySingleton<_i981.SignUpUseCase>(
        () => _i981.SignUpUseCase(gh<_i989.AuthRepository>()));
    gh.lazySingleton<_i418.GetMineUseCase>(
        () => _i418.GetMineUseCase(gh<_i989.AuthRepository>()));
    gh.lazySingleton<_i211.VerifyOtpUseCase>(
        () => _i211.VerifyOtpUseCase(gh<_i989.AuthRepository>()));
    gh.lazySingleton<_i346.SignOutUseCase>(
        () => _i346.SignOutUseCase(gh<_i989.AuthRepository>()));
    gh.lazySingleton<_i367.CreateIncidentUseCase>(
        () => _i367.CreateIncidentUseCase(gh<_i960.IncidentRepository>()));
    gh.lazySingleton<_i285.UploadIncidentFileUseCase>(
        () => _i285.UploadIncidentFileUseCase(gh<_i960.IncidentRepository>()));
    gh.lazySingleton<_i90.GetIncidentsUseCase>(
        () => _i90.GetIncidentsUseCase(gh<_i960.IncidentRepository>()));
    gh.lazySingleton<_i621.GetIncidentTypesUseCase>(
        () => _i621.GetIncidentTypesUseCase(gh<_i960.IncidentRepository>()));
    gh.lazySingleton<_i460.GetIncidentUseCase>(
        () => _i460.GetIncidentUseCase(gh<_i960.IncidentRepository>()));
    gh.lazySingleton<_i627.UpdateProfileUseCase>(
        () => _i627.UpdateProfileUseCase(gh<_i989.AuthRepository>()));
    gh.factory<_i271.UpdateProfileBloc>(
        () => _i271.UpdateProfileBloc(gh<_i627.UpdateProfileUseCase>()));
    gh.lazySingleton<_i372.GetIncidentTypesBloc>(
        () => _i372.GetIncidentTypesBloc(gh<_i621.GetIncidentTypesUseCase>()));
    gh.factory<_i849.GetIncidentBloc>(
        () => _i849.GetIncidentBloc(gh<_i460.GetIncidentUseCase>()));
    gh.factory<_i1034.CreateIncidentBloc>(
        () => _i1034.CreateIncidentBloc(gh<_i367.CreateIncidentUseCase>()));
    gh.lazySingleton<_i400.SignUpBloc>(
        () => _i400.SignUpBloc(gh<_i981.SignUpUseCase>()));
    gh.factory<_i597.GetIncidentsBloc>(
        () => _i597.GetIncidentsBloc(gh<_i90.GetIncidentsUseCase>()));
    gh.lazySingleton<_i334.VerifySignUpBloc>(
        () => _i334.VerifySignUpBloc(gh<_i211.VerifyOtpUseCase>()));
    gh.factory<_i873.UploadIncidentFileBloc>(() =>
        _i873.UploadIncidentFileBloc(gh<_i285.UploadIncidentFileUseCase>()));
    gh.lazySingleton<_i116.ResendCodeBloc>(
        () => _i116.ResendCodeBloc(gh<_i362.ResendOtpUseCase>()));
    gh.singleton<_i187.AuthBloc>(() => _i187.AuthBloc(
          gh<_i418.GetMineUseCase>(),
          gh<_i650.SignInUseCase>(),
          gh<_i739.SubscribeToAuthStatusUseCase>(),
          gh<_i346.SignOutUseCase>(),
        ));
    return this;
  }
}

class _$InjectableModule extends _i315.InjectableModule {}
