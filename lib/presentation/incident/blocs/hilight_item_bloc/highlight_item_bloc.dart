import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:inspector/domain/incident/entities/incident_file.dart';
import 'package:inspector/domain/incident/usecases/upload_incident_file_use_case.dart';
import 'package:inspector/presentation/core/blocs/core/base_state.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'highlight_item_event.dart';

@lazySingleton
class HighlightItemBloc extends Bloc<HighlightItemEvent, HighlightItemSate> {

  HighlightItemBloc()
      : super( HighlightItemInitial()) {
    on<HighlightItemRequested>(_onHighlightItemRequested);
  }

  Future<void> _onHighlightItemRequested(
    HighlightItemRequested event,
    Emitter<HighlightItemSate> emit,
  ) async {

     await Future.delayed(Duration(milliseconds: 1000));

     emit(HighlightItemRefresh(type:  event.type));
  }
}


abstract class HighlightItemSate {}

class HighlightItemInitial extends HighlightItemSate {}

class HighlightItemRefresh extends HighlightItemSate {
  final HighlightItemType type;

  HighlightItemRefresh({
    required this.type,
  });
}