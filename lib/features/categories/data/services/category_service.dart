import 'package:dio/dio.dart';
import 'package:newsly/core/api/api_constants.dart';
import 'package:newsly/core/models/news_model.dart';

class CategoryService {
  final Dio dio = Dio();

  Future<NewsModel> getNewsByCategory(
      {required String category, required int page, int pageSize = 20}) async {
    try {
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

      return NewsModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load news: $e');
    }
  }
}
