import 'dart:io';

import 'package:evolvex_lib/evolvex_lib.dart';

import '../../domain/entities/drink.dart';
import '../../domain/repository/home_repository.dart';
import '../source/remote/drinks_api_service.dart';
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
        return DataFailed(ExceptionHandler.handleException(DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.unknown,
            requestOptions: httpResponse.response.requestOptions)));
      }
    } catch (e) {
      return DataFailed(ExceptionHandler.handleException(e));
    }
  }

  @override
  Future<DataState<List<Drink>>> searchDrinks(String query) async {
    try {
      final httpResponse = await _drinksApiService.getDrinks(query: query);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(ExceptionHandler.handleException(DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.unknown,
            requestOptions: httpResponse.response.requestOptions)));
      }
    } catch (e) {
      return DataFailed(ExceptionHandler.handleException(e));
    }
  }
}
