import 'package:inspector/domain/core/entities/failures.dart';
import 'package:dartz/dartz.dart';

typedef FutureEitherFailureOrData<T> = Future<Either<Failure, T>> Function();

abstract class BaseRepository {
  Future<Either<Failure, T>> request<T>(FutureEitherFailureOrData<T> body,
      );

  Future<Either<Failure, T>> getData<T>(FutureEitherFailureOrData<T> body,
      );
}
