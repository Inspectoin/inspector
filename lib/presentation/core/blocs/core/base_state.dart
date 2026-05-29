import 'dart:math';

import 'package:inspector/domain/core/entities/failures.dart';
import 'package:equatable/equatable.dart';

enum BaseStatus {
  initial,
  inProgress,
  success,
  failure,
}

class BaseState<T> extends Equatable {
  final BaseStatus status;
  final T? item;
  final Failure? failure;
  final dynamic event;

  BaseState<T> setInitialState() => BaseState<T>(
        status: BaseStatus.initial,
      );

  BaseState<T> setInProgressState() => BaseState<T>(
        status: BaseStatus.inProgress,
        event: event
      );
  BaseState<T> setSuccessState(T item) =>
      BaseState<T>(status: BaseStatus.success, item: item);

  BaseState<T> setFailureState(Failure failure) =>
      BaseState<T>(status: BaseStatus.failure, failure: failure,event: event);

  bool get isInProgress => status == BaseStatus.inProgress;

  bool get isFailure => status == BaseStatus.failure;

  bool get isSuccess => status == BaseStatus.success;

  bool get isInitial => status == BaseStatus.initial;

  const BaseState({
    this.status = BaseStatus.initial,
    this.item,
    this.failure,
    this.event,
  });

  BaseState<T> copyWith({
    BaseStatus? status,
    T? item,
    Failure? failure,
    dynamic event,
  }) {
    return BaseState<T>(
      status: status ?? this.status,
      item: item ?? this.item,
      failure: failure ?? this.failure,
      event: event?? this.event
    );
  }

  @override
  List<Object?> get props => [status,item,failure?.message,];



}
