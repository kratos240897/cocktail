part of 'home_bloc.dart';

abstract class HomeEvent {}

class FetchDataEvent extends HomeEvent {}

class SearchEvent extends HomeEvent {
  final String query;

  SearchEvent({required this.query});
}

class ClearSearchEvent extends HomeEvent {}
