import 'package:dio/dio.dart';
import 'package:newsly/core/api/api_constants.dart';

class CategoryService {
  final Dio dio = Dio();

  Future<dynamic> getNewsByCategory(
      {required String category, required int page, int pageSize = 20}) async {
    final response = await dio.get(
      ApiConstants.topHeadlines,
      queryParameters: {
        'country': ApiConstants.defaultCountry,
        'category': category.toLowerCase(),
        'page': page,
        'pageSize': pageSize,
        'apiKey': ApiConstants.apiKey,
      },
    );
    return response.data;
  }
}
