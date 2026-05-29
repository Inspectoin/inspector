part of 'first_time_bloc.dart';


@immutable
abstract class FirstTimeEvent {}

class CheckFirstTimeRequested extends FirstTimeEvent {

}



class SetFirstTimeRequested extends FirstTimeEvent {
  final bool firstTimeValue;


   SetFirstTimeRequested({required this.firstTimeValue});
}
