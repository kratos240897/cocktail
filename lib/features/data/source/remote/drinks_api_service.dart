
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../config/constants/app/constants.dart';
import '../../../../config/constants/app/endpoints.dart';
import '../../../domain/entities/drink.dart';
import '../../dto/drink_dto.dart';

part 'drinks_api_service.g.dart';

@RestApi(baseUrl: Constants.baseURL)
abstract class DrinksApiService {
  factory DrinksApiService(Dio dio) = _DrinksApiService;

  @GET(Endpoints.drinks)
  Future<HttpResponse<List<Drink>>> getDrinks(
      {@Query('s') required String query});
}
