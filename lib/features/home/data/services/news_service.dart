import 'package:dio/dio.dart';
import 'package:newsly/core/constants/api_constants.dart';

class HomeService {
  final dio = Dio();

  Future<dynamic> getBreakingNews() async {
    Response response = await dio.get(
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
    Response response = await dio.get(
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
