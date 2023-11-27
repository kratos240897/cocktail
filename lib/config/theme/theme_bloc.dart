import 'package:evolvex_lib/evolvex_lib.dart';
import 'package:flutter/material.dart';

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

class ThemeCubit extends BaseCubit<ThemeState> {
  ThemeCubit()
      : super(
            initialState: ChangeThemeState(color: Styles.colors.kPrimaryColor));

  changeTheme(MaterialColor color) {
    emit(ChangeThemeState(color: color));
  }

  @override
  ThemeState getErrorState(Object error) {
    return ThemeErrorState(errorMessage: 'An error occured: $error');
  }
}
