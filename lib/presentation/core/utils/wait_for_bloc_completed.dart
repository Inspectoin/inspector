import 'dart:async';

import 'package:inspector/presentation/core/blocs/core/base_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<BaseState> waitForBlocCompletion(Bloc bloc) async {
  final completer = Completer<BaseState>();

  late StreamSubscription subscription;
  subscription = bloc.stream.listen((state) {
    if (state.isDone) {
      completer.complete(state);
      subscription.cancel();
    }
  });

  return completer.future;
}