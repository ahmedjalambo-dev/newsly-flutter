import 'dart:developer';

import 'package:dio/dio.dart';

class TopHeadlineService {
  static const _apiKey = '555c2576b0fc4f7f874703cb16e58319';
  final baseUrl =
      "https://newsapi.org/v2/top-headlines?country=us&apiKey=$_apiKey";
  late Dio _dio;

  TopHeadlineService() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
    );
    _dio = Dio(baseOptions);
  }

  Future<List<Map<String, dynamic>>> fetchTopHeadlines() async {
    try {
      final Response response = await _dio.get(baseUrl);
      log(response.data.toString());
      return response.data;
    } catch (e) {
      log("Error fetching top-headlines: ${e.toString()}");
      return [];
    }
  }
}
