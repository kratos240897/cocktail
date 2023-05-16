import 'package:bloc/bloc.dart';

import '../../../../core/app/base_bloc.dart';
import '../../../../core/base/service_locator.dart';
import '../../data/models/cocktail_response.dart';
import '../../domain/usecases/get_drinks.dart';
import '../../domain/usecases/search_drinks.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  HomeBloc() : super(initialState: HomeInitial());
  final loadedState = HomeLoadedState();
  List<Drinks> drinks = [];
  List<Drinks> filteredDrinks = [];

  @override
  Future<void> handleEvents(HomeEvent event, Emitter<HomeState> emit) async {
    if (event is FetchDataEvent) {
      await _fetchDataEventHandler(event, emit);
    } else if (event is SearchEvent) {
      await _searchEventHandler(event, emit);
    } else if (event is ClearSearchEvent) {
       _clearSearchEventHandler(event, emit);
    }
  }

  Future<void> _fetchDataEventHandler(
      FetchDataEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    final result = await serviceLocator<GetDrinks>().getDrinks();
    result.fold((failure) => emit(getErrorState(failure.message)), (value) {
      drinks = value;
      emit(loadedState..copyWith(drinks));
    });
  }

  Future<void> _searchEventHandler(
      SearchEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    final result =
        await serviceLocator<SearchDrinks>().searchDrinks(event.query);
    result.fold((failure) => emit(getErrorState(failure.message)), (value) {
      filteredDrinks = value;
      emit(loadedState..copyWith(filteredDrinks));
    });
  }

  void _clearSearchEventHandler(
      ClearSearchEvent event, Emitter<HomeState> emit) {
    filteredDrinks.clear();
    emit(loadedState..copyWith(drinks));
  }

  @override
  HomeState getErrorState(Object error) {
    return HomeErrorState(errorMessage: 'An error occured: $error');
  }
}
