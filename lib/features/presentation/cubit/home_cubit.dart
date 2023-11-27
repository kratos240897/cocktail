import 'package:evolvex_lib/evolvex_lib.dart';

import '../../domain/entities/drink.dart';
import '../../domain/usecases/get_drinks_use_case.dart';
import '../../domain/usecases/search_drinks_use_case.dart';
import 'home_state.dart';

class HomeCubit extends BaseCubit<HomeState> {
  final GetDrinksUseCase _getDrinksUseCase;
  final SearchDrinksUseCase _searchDrinksUseCase;
  HomeCubit(this._getDrinksUseCase, this._searchDrinksUseCase)
      : super(initialState: HomeInitial());
  final loadedState = HomeLoadedState();
  List<Drink> drinks = [];
  List<Drink> filteredDrinks = [];

  Future<void> fetchDrinks() async {
    emit(HomeLoadingState());
    final dataState = await _getDrinksUseCase();
    if (dataState is DataSuccess) {
      drinks = dataState.data!;
      emit(loadedState..copyWith(drinks));
    } else {
      emit(getErrorState(dataState.error!));
    }
  }

  Future<void> searchDrinks(String query) async {
    emit(HomeLoadingState());
    final dataState = await _searchDrinksUseCase(params: query);
    if (dataState is DataSuccess) {
      filteredDrinks = dataState.data!;
      emit(loadedState..copyWith(filteredDrinks));
    } else {
      emit(getErrorState(dataState.error!));
    }
  }

  void clearSearch() {
    filteredDrinks.clear();
    emit(loadedState..copyWith(drinks));
  }

  @override
  HomeState getErrorState(Object error) {
    if (error is Failure) {
      return HomeErrorState(errorMessage: error.message);
    }
    return HomeErrorState(errorMessage: 'An error occured: $error');
  }
}
