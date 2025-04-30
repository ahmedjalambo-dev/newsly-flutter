import 'dart:developer';

import 'package:newsly/core/api/api_error_handler.dart';
import 'package:newsly/core/api/api_result.dart';
import 'package:newsly/core/models/article_model.dart';
import 'package:newsly/core/models/news_model.dart';
import 'package:newsly/features/home/data/home_service.dart';

class HomeRepo {
  final HomeService homeService;
  HomeRepo({
    required this.homeService,
  });

  Future<ApiResult<List<ArticleModel>?>> getBreakingNews() async {
    try {
      final response = await homeService.getBreakingNews();
      final newsModel = NewsModel.fromJson(response);
      log('Breaking news: ${newsModel.articles}');
      return ApiResult.success(newsModel.articles);
    } catch (error) {
      log('Breaking news error: $error');
      return ApiResult.failure(ApiErrorHandler.handle(error).message);
    }
  }

  Future<ApiResult<List<ArticleModel>?>> getRecommendationNews() async {
    try {
      final response = await homeService.getRecommendationNews();
      final newsModel = NewsModel.fromJson(response);
      log('Recommendation news: ${newsModel.articles}');
      return ApiResult.success(newsModel.articles);
    } catch (error) {
      log('Recommendation news error: $error');
      return ApiResult.failure(ApiErrorHandler.handle(error).message);
    }
  }
}
