import 'package:dio/dio.dart';
import 'package:newsly/core/api/api_constants.dart';
import 'package:newsly/core/api/dio_factory.dart';

class HomeService {
  final Dio _dio = DioFactory.createDio();

  Future<dynamic> getBreakingNews() async {
    Response response = await _dio.get(
      ApiConstants.topHeadlines,
      queryParameters: {
        'country': ApiConstants.defaultCountry,
        'pageSize': 10,
        'apiKey': ApiConstants.apiKey,
      },
    );
    return response.data;
  }

  Future<dynamic> getRecommendationNews() async {
    Response response = await _dio.get(
      ApiConstants.topHeadlines,
      queryParameters: {
        'country': ApiConstants.defaultCountry,
        'page': 2,
        'apiKey': ApiConstants.apiKey,
      },
    );
    return response.data;
  }
}
