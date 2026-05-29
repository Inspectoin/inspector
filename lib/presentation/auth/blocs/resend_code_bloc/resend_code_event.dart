part of 'resend_code_bloc.dart';


@immutable
abstract class ResendCodeEvent {}

class  ResendCodeRequested extends ResendCodeEvent {
  final String phone;


  ResendCodeRequested({
    required this.phone,
  });

}




