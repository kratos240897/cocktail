import 'package:dartz/dartz.dart';

import '../../../../core/base/failure.dart';
import '../../../../core/base/service_locator.dart';
import '../../data/models/cocktail_response.dart';
import '../repository/home_repository.dart';

class GetDrinks {
  Future<Either<Failure, List<Drinks>>> getDrinks() {
    return serviceLocator<HomeRepository>().getDrinks();
  }
}
