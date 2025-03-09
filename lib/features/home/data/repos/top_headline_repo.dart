import 'dart:developer';

import 'package:newsly/features/home/data/models/top_headline_model.dart';
import 'package:newsly/features/home/data/services/top_headline_service.dart';

class TopHeadlineRepo {
  final TopHeadlineService topHeadlineService;

  TopHeadlineRepo(this.topHeadlineService);

  Future<List<TopHeadlineModel>> getTopHeadlines() async {
    try {
      final topHeadlinesData = await topHeadlineService.fetchTopHeadlines();

      List<TopHeadlineModel> topHeadlines = topHeadlinesData
          .map((headlineData) => TopHeadlineModel.fromMap(headlineData))
          .toList();
      return topHeadlines;
    } catch (e) {
      log('Error fetching top headlines: $e');
      return [];
    }
  }
}
