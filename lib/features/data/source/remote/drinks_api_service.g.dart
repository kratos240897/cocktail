// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drinks_api_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _DrinksApiService implements DrinksApiService {
  _DrinksApiService(
    this._dio) {
    baseUrl ??= 'https://www.thecocktaildb.com';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<HttpResponse<List<Drink>>> getDrinks({required String query}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r's': query};
    final _headers = <String, dynamic>{};
    const _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<List<Drink>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/api/json/v1/1/search.php',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    var value = List<Drink>.empty();
    if (_result.data != null &&
        _result.data!.containsKey('drinks') &&
        _result.data?['drinks'] != null) {
      value = _result.data!['drinks']
          .map<Drink>((dynamic i) => DrinkDto.fromJson(i))
          .toList();
    }
    final httpResponse = HttpResponse<List<Drink>>(value, _result);
    return httpResponse;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
