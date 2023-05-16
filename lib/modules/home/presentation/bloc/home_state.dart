part of 'home_bloc.dart';

abstract class HomeState extends BaseState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  List<Drinks> drinks = [];
  HomeLoadedState();

  copyWith(List<Drinks> drinks) {
    this.drinks.clear();
    this.drinks.addAll(drinks);
  }
}

class HomeErrorState extends HomeState {
  final String errorMessage;

  HomeErrorState({required this.errorMessage});
}
