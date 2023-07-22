import '../../../core/resources/data_state.dart';
import '../../../core/usecase/usecase.dart';
import '../../data/models/cocktail_response.dart';
import '../repository/home_repository.dart';

class GetDrinksUseCase implements UseCase<DataState<List<Drink>>, void> {
  final HomeRepository homeRepository;

  GetDrinksUseCase(this.homeRepository);

  @override
  Future<DataState<List<Drink>>> call({void params}) {
    return homeRepository.getDrinks();
  }
}