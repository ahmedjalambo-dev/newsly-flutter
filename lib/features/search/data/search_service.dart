import 'package:dio/dio.dart';
import 'package:newsly/core/api/api_constants.dart';
import 'package:newsly/core/api/dio_factory.dart';

class SearchService {
  Dio dio = DioFactory.createDio();

  Future<dynamic> getSearchNews(String query) async {
    Response response = await dio.get(
      ApiConstants.everything,
      queryParameters: {
        'apiKey': ApiConstants.apiKey,
        'q': query,
      },
    );
    return response.data;
  }
}
