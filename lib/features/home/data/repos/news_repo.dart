import 'dart:developer';

import 'package:newsly/core/models/news_model.dart';
import 'package:newsly/features/home/data/services/news_service.dart';

class HomeRepo {
  final HomeService homeService;

  HomeRepo({required this.homeService});
  Future<NewsModel> getBreakingNews() async {
    try {
      final topheadlineJson = await homeService.getBreakingNews();
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
      final topheadlineJson = await homeService.getRecommendationNews();
      final topheadlineModel = NewsModel.fromJson(topheadlineJson);
      log('fetching recommendation news successful in repo');
      return topheadlineModel;
    } catch (e) {
      log('fetching recommendation news successful in repo: $e');
      throw Exception('Error fetching top headlines: $e');
    }
  }
}
