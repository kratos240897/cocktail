import 'dart:io';

import '../../../core/resources/data_state.dart';
import '../../domain/repository/home_repository.dart';
import '../data_source/remote/drinks_api_service.dart';
import '../models/cocktail_response.dart';
import 'package:dio/dio.dart';

class HomeRepositoryImpl extends HomeRepository {
  final DrinksApiService _drinksApiService;

  HomeRepositoryImpl(this._drinksApiService);
  @override
  Future<DataState<List<Drink>>> getDrinks() async {
    try {
      final httpResponse = await _drinksApiService.getDrinks(query: 'rum');

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.unknown,
            requestOptions: httpResponse.response.requestOptions));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<Drink>>> searchDrinks(String query) async {
    try {
      final httpResponse = await _drinksApiService.getDrinks(query: query);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.unknown,
            requestOptions: httpResponse.response.requestOptions));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
