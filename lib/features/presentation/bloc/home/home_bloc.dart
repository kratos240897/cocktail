import 'package:evolvex_lib/evolvex_lib.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/resources/data_state.dart';
import '../../../data/models/cocktail_response.dart';
import '../../../domain/usecases/get_drinks_use_case.dart';
import '../../../domain/usecases/search_drinks_use_case.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  final GetDrinksUseCase _getDrinksUseCase;
  final SearchDrinksUseCase _searchDrinksUseCase;
  HomeBloc(this._getDrinksUseCase, this._searchDrinksUseCase)
      : super(initialState: HomeInitial());
  final loadedState = HomeLoadedState();
  List<Drink> drinks = [];
  List<Drink> filteredDrinks = [];

  @override
  Future<void> handleEvents(HomeEvent event, Emitter<HomeState> emit) async {
    if (event is FetchDataEvent) {
      await _fetchDataEventHandler(emit);
    } else if (event is SearchEvent) {
      await _searchEventHandler(event.query, emit);
    } else if (event is ClearSearchEvent) {
      _clearSearchEventHandler(emit);
    }
  }

  Future<void> _fetchDataEventHandler(Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    final dataState = await _getDrinksUseCase();
    if (dataState is DataSuccess) {
      drinks = dataState.data!;
      emit(loadedState..copyWith(drinks));
    } else {
      emit(getErrorState(dataState.error!));
    }
  }

  Future<void> _searchEventHandler(
      String query, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    final dataState = await _searchDrinksUseCase(params: query);
    if (dataState is DataSuccess) {
      filteredDrinks = dataState.data!;
      emit(loadedState..copyWith(filteredDrinks));
    } else {
      emit(getErrorState(dataState.error!));
    }
  }

  void _clearSearchEventHandler(Emitter<HomeState> emit) {
    filteredDrinks.clear();
    emit(loadedState..copyWith(drinks));
  }

  @override
  HomeState getErrorState(Object error) {
    return HomeErrorState(errorMessage: 'An error occured: $error');
  }
}
