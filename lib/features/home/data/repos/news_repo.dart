import 'dart:developer';

import 'package:newsly/core/models/news_model.dart';
import 'package:newsly/features/home/data/services/news_service.dart';

class NewsRepo {
  final NewsService newsService;

  NewsRepo({required this.newsService});
  Future<NewsModel> getBreakingNews() async {
    try {
      final topheadlineJson = await newsService.getBreakingNews();
      final topheadlineModel = NewsModel.fromJson(topheadlineJson);
      log('fetching breacking news successful in repo');
      return topheadlineModel;
    } catch (e) {
      log('fetching breacking news successful in repo: $e');
      throw Exception('Error fetching top headlines: $e');
    }
  }

  Future<NewsModel> getRecommendationNews() async {
    try {
      final topheadlineJson = await newsService.getRecommendationNews();
      final topheadlineModel = NewsModel.fromJson(topheadlineJson);
      log('fetching recommendation news successful in repo');
      return topheadlineModel;
    } catch (e) {
      log('fetching recommendation news successful in repo: $e');
      throw Exception('Error fetching top headlines: $e');
    }
  }
}
