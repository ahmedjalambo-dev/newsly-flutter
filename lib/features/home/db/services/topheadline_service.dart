import 'package:dio/dio.dart';

class TopheadlineService {
  final dio = Dio();

  Future<dynamic> getTopheadlineNews() async {
    Response response = await dio.get(
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=555c2576b0fc4f7f874703cb16e58319');
    return response.data;
  }
}
