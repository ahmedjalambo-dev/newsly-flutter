import 'package:dio/dio.dart';
import 'api_error_model.dart';

class ApiErrorHandler {
  static ApiErrorModel handle(dynamic error) {
    if (error is DioException) {
      try {
        final responseData = error.response?.data;
        if (responseData is Map<String, dynamic>) {
          return ApiErrorModel.fromJson(responseData);
        }
      } catch (_) {
        // If parsing fails, fall back to a default message
      }

      return ApiErrorModel(
        status: "error",
        code: error.response?.statusCode.toString(),
        message: error.message ?? "Something went wrong",
      );
    } else {
      return ApiErrorModel(
        status: "error",
        message: "Unexpected error",
      );
    }
  }

  static handleError(DioException e) {}
}
