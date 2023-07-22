import '../../../core/resources/data_state.dart';
import '../../../core/usecase/usecase.dart';
import '../../data/models/cocktail_response.dart';
import '../repository/home_repository.dart';

class SearchDrinksUseCase implements UseCase<DataState<List<Drink>>, String> {
  final HomeRepository homeRepository;

  SearchDrinksUseCase(this.homeRepository);

  @override
  Future<DataState<List<Drink>>> call({String? params}) {
    return homeRepository.searchDrinks(params!);
  }
}
