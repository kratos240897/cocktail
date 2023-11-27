import 'package:evolvex_lib/evolvex_lib.dart';

import '../../domain/entities/drink.dart';

sealed class HomeState extends BaseState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  List<Drink> drinks = [];
  HomeLoadedState();

  copyWith(List<Drink> drink) {
    drinks.clear();
    drinks.addAll(drink);
  }
}

class HomeErrorState extends HomeState {
  final String errorMessage;

  HomeErrorState({required this.errorMessage});
}
