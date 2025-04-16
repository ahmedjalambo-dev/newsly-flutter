import 'dart:developer';

import 'package:newsly/features/categories/data/services/category_service.dart';
import 'package:newsly/core/models/article_model.dart';

class CategoryRepo {
  final CategoryService categoryService;

  CategoryRepo({required this.categoryService});

  Future<List<ArticleModel>> fetchNewsByCategory(
      {required String category, required int page, int pageSize = 20}) async {
    try {
      final newsByCategoryJson = await categoryService.getNewsByCategory(
          category: category, page: page, pageSize: pageSize);
      final newsByCategoryModel = newsByCategoryJson.articles;
      log('fetching news by category successful in repo');
      return newsByCategoryModel ?? [];
    } catch (e) {
      log('Error fetching news by category in repo: $e');
      throw Exception('Failed to fetch news: $e');
    }
  }
}
