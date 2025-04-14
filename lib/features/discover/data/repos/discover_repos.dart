import 'package:newsly/features/discover/data/services/discover_service.dart';
import 'package:newsly/core/models/article_model.dart';

class DiscoverRepo {
  final DiscoverService discoverService;

  DiscoverRepo({required this.discoverService});

  Future<List<ArticleModel>> fetchNewsByCategory(
      {required String category, required int page, int pageSize = 20}) async {
    try {
      return await discoverService
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
