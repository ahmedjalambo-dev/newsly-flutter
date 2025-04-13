class ApiConstants {
  static const String apiKey = '555c2576b0fc4f7f874703cb16e58319';
  static const String baseUrl = 'https://newsapi.org/v2';
  static const String topHeadlines = '$baseUrl/top-headlines';
  static const String everything = '$baseUrl/everything';
  static const String sources = '$baseUrl/top-headlines/sources';

  // Default parameters
  static const String defaultCountry = 'us';
  static const int defaultPageSize = 10;
  static const int firstPage = 1;

  // Timeout durations
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}
