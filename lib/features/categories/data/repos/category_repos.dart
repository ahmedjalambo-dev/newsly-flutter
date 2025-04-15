import 'package:newsly/features/categories/data/services/category_service.dart';
import 'package:newsly/core/models/article_model.dart';

class CategoryRepo {
  final CategoryService categoryService;

  CategoryRepo({required this.categoryService});

  Future<List<ArticleModel>> fetchNewsByCategory(
      {required String category, required int page, int pageSize = 20}) async {
    try {
      return await categoryService
          .getNewsByCategory(
            category: category,
            page: page,
            pageSize: pageSize,
          )
          .then(
            (newsModel) => newsModel.articles ?? [],
          );
    } catch (e) {
      throw Exception('Failed to fetch news: $e');
    }
  }
}
