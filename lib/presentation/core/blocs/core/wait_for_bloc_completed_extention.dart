

import 'dart:async';

import 'package:inspector/presentation/core/blocs/core/base_paginated_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'base_state.dart';

extension WaitForBlocCompletedExtention on Bloc {


  Future waitForCompletion() async {
    // in some cases not take the changes in bloc immediately
    await Future.delayed(Duration(milliseconds: 100));

    final completer = Completer();

    // when bloc already completed don't listen for steam
    // return its completed directly
    if(state is BaseState || state is BasePaginatedListState) {
      if (state.isSuccess || state.isFailure) {
        completer.complete(state);
        return completer;
      }
    }


    // listen to bloc stream
    late StreamSubscription subscription;
    subscription = stream.listen((state) {

      if(state is BaseState || state is BasePaginatedListState){

        if (state.isSuccess || state.isFailure) {
          completer.complete(state);
          subscription.cancel();
        }
      }

    });



    return completer.future;
  }

}
