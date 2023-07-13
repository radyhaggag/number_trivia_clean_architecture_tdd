import 'package:dio/dio.dart';

abstract class ApiConsumer {
  Future<dynamic> get({
    required String endpoint,
    Map<String, dynamic>? queryParams,
  });
}

const BASE_URL = 'http://numbersapi.com/';

class DioConsumer implements ApiConsumer {
  final Dio _dio;

  DioConsumer(this._dio) {
    _initDio();
  }

  _initDio() {
    _dio.options = BaseOptions(
      baseUrl: BASE_URL,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
      },
    );
  }

  @override
  Future get({
    required String endpoint,
    Map<String, dynamic>? queryParams,
  }) async {
    final response = await _dio.get(
      endpoint,
      queryParameters: queryParams,
    );
    return response;
  }
}
