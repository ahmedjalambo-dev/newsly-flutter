import 'package:dio/dio.dart';
import 'package:newsly/core/api/api_constants.dart';
import 'package:newsly/core/api/dio_factory.dart';

class SearchService {
  Dio dio = DioFactory.createDio();

  Future<dynamic> getSearchNews(
      {required String query, required int page, int pageSize = 20}) async {
    Response response = await dio.get(
      ApiConstants.everything,
      queryParameters: {
        'apiKey': ApiConstants.apiKey,
        'page': page,
        'pageSize': pageSize,
        'q': query,
      },
    );
    return response.data;
  }
}
