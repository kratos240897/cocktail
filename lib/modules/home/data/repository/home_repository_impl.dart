import 'package:dartz/dartz.dart';
import 'package:evolvex_lib/evolvex_lib.dart';

import '../../../../core/base/service_locator.dart';
import '../../domain/repository/home_repository.dart';
import '../data_source/drinks_remote_data_source.dart';
import '../models/cocktail_response.dart';

class HomeRepositoryImpl extends HomeRepository {
  @override
  Future<Either<Failure, List<Drinks>>> getDrinks() {
    return serviceLocator<DrinksRemoteDataSource>().getDrinks();
  }

  @override
  Future<Either<Failure, List<Drinks>>> searchDrinks(String query) {
    return serviceLocator<DrinksRemoteDataSource>().searchDrinks(query);
  }
}
