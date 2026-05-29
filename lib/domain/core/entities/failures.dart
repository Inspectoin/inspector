
import 'package:inspector/domain/core/utils/constants.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  Failure({
    this.message='',
});


  @override
  List<Object?> get props => [message];

}

class ServerFailure implements Failure {
  final ServerErrorCode errorCode;
  final String? serverCode;
  final String message;
  final dynamic args;
  ServerFailure({
    required this.errorCode,
    this.message = '',
    this.serverCode,
    this.args,
  });

  @override
  List<Object?> get props => [errorCode,serverCode,message];

  @override
  bool? get stringify => true;


}

