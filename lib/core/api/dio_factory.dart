import 'package:dio/dio.dart';
import 'api_constants.dart';

class DioFactory {
  static Dio createDio() {
    final dio = Dio();

    dio.options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        "Authorization": "Bearer ${ApiConstants.apiKey}",
        "Content-Type": "application/json",
      },
    );

    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));

    return dio;
  }
}
