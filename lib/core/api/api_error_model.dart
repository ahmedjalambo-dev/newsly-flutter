class ApiErrorModel {
  final String status;
  final String? code;
  final String message;

  ApiErrorModel({
    required this.status,
    this.code,
    required this.message,
  });

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) {
    return ApiErrorModel(
      status: json['status'] ?? 'error',
      code: json['code'],
      message: json['message'] ?? 'An unknown error occurred',
    );
  }

  @override
  String toString() {
    return 'Error(status: $status, code: $code, message: $message)';
  }
}
