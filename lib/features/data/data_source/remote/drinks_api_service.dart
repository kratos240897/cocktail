import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../config/constants/app/constants.dart';
import '../../../../config/constants/app/endpoints.dart';
import '../../models/cocktail_response.dart';


part 'drinks_api_service.g.dart';

@RestApi(baseUrl: Constants.BASE_URL)
abstract class DrinksApiService {
  factory DrinksApiService(Dio dio) = _DrinksApiService;

  @GET(Endpoints.DRINKS)
  Future<HttpResponse<List<Drink>>> getDrinks(
      {@Query('s') required String query});
}
