import 'dart:developer';

import 'package:newsly/core/api/api_error_handler.dart';
import 'package:newsly/core/api/api_result.dart';
import 'package:newsly/core/models/article_model.dart';
import 'package:newsly/core/models/news_model.dart';
import 'package:newsly/features/search/data/search_service.dart';

class SearchRepo {
  final SearchService searchService;
  SearchRepo({required this.searchService});

  Future<ApiResult<List<ArticleModel>?>> searchNews(
      {required String query, required int page, int pageSize = 20}) async {
    try {
      final response =
          await searchService.getSearchNews(query: query, page: page);
      final newsModel = NewsModel.fromJson(response);
      return ApiResult.success(newsModel.articles);
    } catch (error) {
      log('Search news error: $error');
      return ApiResult.failure(ApiErrorHandler.handle(error).message);
    }
  }
}
