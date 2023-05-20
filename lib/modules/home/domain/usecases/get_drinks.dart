import 'package:dartz/dartz.dart';
import 'package:evolvex_lib/evolvex_lib.dart';

import '../../../../core/base/service_locator.dart';
import '../../data/models/cocktail_response.dart';
import '../repository/home_repository.dart';

class GetDrinks {
  Future<Either<Failure, List<Drinks>>> getDrinks() {
    return serviceLocator<HomeRepository>().getDrinks();
  }
}
