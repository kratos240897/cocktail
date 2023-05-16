import 'package:dartz/dartz.dart';

import '../../../../core/base/exception_handler.dart';
import '../../../../core/base/failure.dart';
import '../../../../core/base/service_locator.dart';
import '../../../../core/constants/app/endpoints.dart';
import '../../../../core/service/api_service.dart';
import '../models/cocktail_response.dart';

abstract class DrinksRemoteDataSource {
  Future<Either<Failure, List<Drinks>>> getDrinks();
  Future<Either<Failure, List<Drinks>>> searchDrinks(String query);
}

class DrinksRemoteDataSourceImpl extends DrinksRemoteDataSource {
  @override
  Future<Either<Failure, List<Drinks>>> getDrinks() async {
    try {
      final apiService = serviceLocator<ApiService>();
      final res = await apiService.getRequest(Endpoints.DRINKS, {'s': 'rum'});
      return Right(CocktailResponse.fromJson(res.data).drinks);
    } catch (e) {
      return Left(ExceptionHandler.handleException(e));
    }
  }

  @override
  Future<Either<Failure, List<Drinks>>> searchDrinks(String query) async {
    try {
      final apiService = serviceLocator<ApiService>();
      final res = await apiService.getRequest(Endpoints.DRINKS, {'s': query});
      if (res.data['drinks'] == null) {
        return Right(CocktailResponse(drinks: []).drinks);
      }
      return Right(CocktailResponse.fromJson(res.data).drinks);
    } catch (e) {
      return Left(ExceptionHandler.handleException(e));
    }
  }
}
