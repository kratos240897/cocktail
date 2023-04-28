import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_loggy_dio/flutter_loggy_dio.dart';

import '../constants/app/constants.dart';

class ApiService {
  var dio = Dio(BaseOptions(
      baseUrl: Constants.BASE_URL, contentType: 'application/json'));

  ApiService() {
    addInterceptor();
  }

  void addInterceptor() {
    dio.interceptors.add(LoggyDioInterceptor());
  }

  Future<Response> getRequest(
      String endpoint, Map<String, dynamic> query) async {
    try {
      Response response;
      response = await dio.get(
        endpoint,
        queryParameters: query,
      );
      return response;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return Future.error(e);
    }
  }
}
