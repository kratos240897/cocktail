import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

abstract class BaseState {}

class LoadingState extends BaseState {}

class ErrorState extends BaseState {
  final String errorMessage;

  ErrorState({required this.errorMessage});
}

class SuccessState extends BaseState {
  final String message;

  SuccessState({required this.message});
}

abstract class BaseBloc<E, S extends BaseState> extends Bloc<E, S> {
  final S initialState;
  BaseBloc({required this.initialState}) : super(initialState) {
    on<E>(eventHandler);

    // on((event, emit) async {
    //   try {
    //     await for (var state in mapEventToState(event as E)) {
    //       emit(state);
    //     }
    //   } catch (error, stackTrace) {
    //     debugPrint('Error: $error');
    //     debugPrint('Stacktrace: $stackTrace');
    //     emit(getErrorState(error));
    //   }
    // });
  }

  // Stream<S> mapEventToState(E event);

  Future<void> eventHandler(E event, Emitter<S> emit) async {
    try {
      await handleEvents(event, emit);
    } catch (error, stackTrace) {
      debugPrint('Error: $error');
      debugPrint('Stacktrace: $stackTrace');
      emit(getErrorState(error));
    }
  }

  Future<void> handleEvents(E event, Emitter<S> emit);

  S getErrorState(Object error);
}
