import 'dart:developer';

import 'package:newsly/core/api/api_error_handler.dart';
import 'package:newsly/core/api/api_result.dart';
import 'package:newsly/core/models/news_model.dart';
import 'package:newsly/features/categories/data/category_service.dart';
import 'package:newsly/core/models/article_model.dart';

class CategoryRepo {
  final CategoryService categoryService;

  CategoryRepo({required this.categoryService});

  Future<ApiResult<List<ArticleModel>?>> fetchNewsByCategory(
      {required String category, required int page, int pageSize = 20}) async {
    try {
      var response = await categoryService.getNewsByCategory(
        category: category,
        page: page,
        pageSize: pageSize,
      );
      log('CategoryRepo: $response');
      return ApiResult.success(NewsModel.fromJson(response).articles);
    } catch (e) {
      log('CategoryRepo error: $e');
      return ApiResult.failure(ApiErrorHandler.handle(e).message);
    }
  }
}
