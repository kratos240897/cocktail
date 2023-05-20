import 'package:dartz/dartz.dart';
import 'package:evolvex_lib/evolvex_lib.dart';

import '../../data/models/cocktail_response.dart';


abstract class HomeRepository {
  Future<Either<Failure, List<Drinks>>> getDrinks();
  Future<Either<Failure, List<Drinks>>> searchDrinks(String query);
}
