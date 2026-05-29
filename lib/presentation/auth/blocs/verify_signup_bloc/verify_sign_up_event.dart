part of 'verify_sign_up_bloc.dart';


@immutable
abstract class VerifySignUpEvent {}

class  VerifySignUpRequested extends VerifySignUpEvent {
  final String code;


  VerifySignUpRequested({
    required this.code,
  });

}




