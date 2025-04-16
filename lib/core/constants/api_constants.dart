class ApiConstants {
  // static const String apiKey = '555c2576b0fc4f7f874703cb16e58319';
  static const String apiKey = 'b7cb59bd33984fb49e88ff6358253082';
  // static const String apiKey = 'cb6bb43325dc4fafaa810d5c8a360ef8';
  static const String baseUrl = 'https://newsapi.org/v2';
  static const String topHeadlines = '$baseUrl/top-headlines';
  static const String everything = '$baseUrl/everything';
  static const String sources = '$baseUrl/top-headlines/sources';

  // Default parameters
  static const String defaultCountry = 'us';
  static const int defaultPageSize = 20;
  static const int firstPage = 1;

  // Timeout durations
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}
