import 'package:dio/dio.dart';

class HomeService {
  final dio = Dio();

  Future<dynamic> getBreakingNews() async {
    Response response = await dio.get(
        'https://newsapi.org/v2/top-headlines?country=us&pageSize=10&apiKey=555c2576b0fc4f7f874703cb16e58319');
    return response.data;
  }

  Future<dynamic> getRecommendationNews() async {
    Response response = await dio.get(
        'https://newsapi.org/v2/top-headlines?country=us&page=2&apiKey=555c2576b0fc4f7f874703cb16e58319');
    return response.data;
  }
}
