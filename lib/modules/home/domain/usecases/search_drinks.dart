import 'package:dartz/dartz.dart';
import 'package:evolvex_lib/evolvex_lib.dart';

import '../../../../core/base/service_locator.dart';
import '../../data/models/cocktail_response.dart';
import '../repository/home_repository.dart';

class SearchDrinks {
  Future<Either<Failure, List<Drinks>>> searchDrinks(String query) {
    return serviceLocator<HomeRepository>().searchDrinks(query);
  }
}
