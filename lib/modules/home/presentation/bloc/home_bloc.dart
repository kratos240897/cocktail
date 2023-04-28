import 'package:bloc/bloc.dart';

import '../../../../core/base/service_locator.dart';
import '../../data/models/cocktail_response.dart';
import '../../domain/usecases/get_drinks.dart';
import '../../domain/usecases/search_drinks.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    final loadedState = HomeLoadedState(drinks: []);
    List<Drinks> drinks = [];
    List<Drinks> filteredDrinks = [];
    on<HomeEvent>((event, emit) async {
      try {
        if (event is FetchDataEvent) {
          emit(HomeLoadingState());
          final result = await serviceLocator<GetDrinks>().getDrinks();
          result.fold((failure) {
            emit(HomeErrorState(errorMessage: failure.message));
          }, (value) {
            drinks = value;
            emit(loadedState..drinks = drinks);
          });
        } else if (event is SearchEvent) {
          emit(HomeLoadingState());
          final result = await serviceLocator<SearchDrinks>().searchDrinks(event.query);
          result.fold((failure) {
            emit(HomeErrorState(errorMessage: failure.message));
          }, (value) {
            filteredDrinks = value;
            emit(loadedState..drinks = filteredDrinks);
          });
        } else if (event is ClearSearchEvent) {
          filteredDrinks.clear();
          emit(loadedState..drinks = drinks);
        }
      } catch (e) {
        emit(HomeErrorState(errorMessage: e.toString()));
      }
    });
  }
}
