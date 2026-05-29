import 'package:inspector/data/core/datasource/remote/core_remote_data_source.dart';
import 'package:inspector/data/core/utils/configuration/configuration.dart';
import 'package:inspector/domain/core/entities/failures.dart';
import 'package:inspector/domain/core/repositories/core_repository.dart';
import 'package:inspector/domain/core/usecases/set_first_time_use_case.dart';
import 'package:inspector/injection.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:inspector/data/core/repositories/base_repository_impl.dart';
import 'package:logger/logger.dart';
import '../datasource/local/core_local_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';



@LazySingleton(as: CoreRepository)
class CoreRepositoryImpl extends BaseRepositoryImpl implements CoreRepository {
  final CoreRemoteDataSource remote;
  late CoreLocalDataSourceImpl local;
  final Logger logger;
  final Configuration configuration;

  CoreRepositoryImpl( this.remote, this.logger,
      this.configuration)
      : super( logger){
    local =CoreLocalDataSourceImpl(getIt<SharedPreferences>());
  }



  @override
  Future<Either<Failure, bool>> isFirstTime() {
    return request(
            () async {
          final result = await local.isFirstTime();
          return right(result);
        },
        withCheckToken: false,
        withCheckConnection: false

    );
  }


  @override
  Future<Either<Failure, Unit>> setFirstTime({required SetFirstTimeUseCaseParams params}) {
    return request(
            () async {
          local.setFirstTime(params.firstTimeValue);
          return right(unit);
        },
        withCheckToken: false,
        withCheckConnection: false
    );
  }
  @override
  Future<Either<Failure, bool>> getSessionStatus() async {
    return request(
            () async {
              final status = await local.getSessionStatus();
              return Right(status);
        },
        withCheckToken: false,
        withCheckConnection: false
    );


  }

  @override
  Future<Either<Failure, void>> setSessionStatus(bool status) async {
    return request(
            () async {
              await local.setSessionStatus(status);
              return const Right(unit);
        },
        withCheckToken: false,
        withCheckConnection: false
    );

  }





}
