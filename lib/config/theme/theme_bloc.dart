import 'package:evolvex_lib/evolvex_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeThemeEvent {
  final MaterialColor color;
  ChangeThemeEvent({required this.color});
}

abstract class ThemeState extends BaseState {}

class ChangeThemeState extends ThemeState {
  final MaterialColor color;
  ChangeThemeState({required this.color});
}

class ThemeErrorState extends ThemeState {
  final String errorMessage;

  ThemeErrorState({required this.errorMessage});
}

class ThemeBloc extends BaseBloc<ChangeThemeEvent, ThemeState> {
  ThemeBloc()
      : super(
            initialState: ChangeThemeState(color: Styles.colors.kPrimaryColor));

  @override
  Future<void> handleEvents(
      ChangeThemeEvent event, Emitter<ThemeState> emit) async {
    _changeThemeEventHandler(event, emit);
  }

  _changeThemeEventHandler(ChangeThemeEvent event, Emitter<ThemeState> emit) {
    emit(ChangeThemeState(color: event.color));
  }

  @override
  ThemeState getErrorState(Object error) {
    return ThemeErrorState(errorMessage: 'An error occured: $error');
  }
}
