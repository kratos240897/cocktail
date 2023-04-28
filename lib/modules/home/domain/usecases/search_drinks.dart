import 'package:dartz/dartz.dart';

import '../../../../core/base/failure.dart';
import '../../../../core/base/service_locator.dart';
import '../../data/models/cocktail_response.dart';
import '../repository/home_repository.dart';

class SearchDrinks {
  Future<Either<Failure, List<Drinks>>> searchDrinks(String query) {
    return serviceLocator<HomeRepository>().searchDrinks(query);
  }
}
