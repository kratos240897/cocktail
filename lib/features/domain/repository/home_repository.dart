import 'package:cocktail/features/domain/entities/drink.dart';
import 'package:evolvex_lib/evolvex_lib.dart';


abstract class HomeRepository {
  Future<DataState<List<Drink>>> getDrinks();
  Future<DataState<List<Drink>>> searchDrinks(String query);
}
