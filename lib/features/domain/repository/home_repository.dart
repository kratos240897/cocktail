import '../../../core/resources/data_state.dart';
import '../../data/models/cocktail_response.dart';

abstract class HomeRepository {
  Future<DataState<List<Drink>>> getDrinks();
  Future<DataState<List<Drink>>> searchDrinks(String query);
}
