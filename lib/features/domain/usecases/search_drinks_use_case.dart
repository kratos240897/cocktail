import 'package:evolvex_lib/evolvex_lib.dart';

import '../entities/drink.dart';
import '../repository/home_repository.dart';

class SearchDrinksUseCase implements UseCase<DataState<List<Drink>>, String> {
  final HomeRepository homeRepository;

  SearchDrinksUseCase(this.homeRepository);

  @override
  Future<DataState<List<Drink>>> call({String? params}) {
    return homeRepository.searchDrinks(params!);
  }
}
