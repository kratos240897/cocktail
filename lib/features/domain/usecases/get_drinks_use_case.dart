import 'package:evolvex_lib/evolvex_lib.dart';

import '../entities/drink.dart';
import '../repository/home_repository.dart';

class GetDrinksUseCase implements UseCase<DataState<List<Drink>>, void> {
  final HomeRepository homeRepository;

  GetDrinksUseCase(this.homeRepository);

  @override
  Future<DataState<List<Drink>>> call({void params}) {
    return homeRepository.getDrinks();
  }
}
