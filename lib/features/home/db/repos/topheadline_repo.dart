import 'dart:developer';

import 'package:newsly/features/home/db/models/topheadline_model.dart';
import 'package:newsly/features/home/db/services/topheadline_service.dart';

class TopHeadlineRepo {
  final TopheadlineService topheadlineService;

  TopHeadlineRepo({required this.topheadlineService});
  Future<TopheadlineModel> getTopHeadlines() async {
    try {
      final topheadlineJson = await topheadlineService.getTopheadlineNews();
      final topheadlineModel = TopheadlineModel.fromJson(topheadlineJson);
      log('Top headlines fetched successfully');
      return topheadlineModel;
    } catch (e) {
      log('Error fetching top headlines: $e');
      throw Exception('Error fetching top headlines: $e');
    }
  }
}
