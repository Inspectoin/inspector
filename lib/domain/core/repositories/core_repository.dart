import 'package:inspector/domain/core/entities/failures.dart';
import 'package:inspector/domain/core/usecases/set_first_time_use_case.dart';
import 'package:dartz/dartz.dart';

abstract class CoreRepository {


  Future<Either<Failure, bool>> isFirstTime();
  Future<Either<Failure, Unit>> setFirstTime({required  SetFirstTimeUseCaseParams params});

  Future<Either<Failure, void>> setSessionStatus(bool status);
  Future<Either<Failure, bool>> getSessionStatus();

}
