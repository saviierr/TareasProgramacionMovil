/// API constants for the application
class ApiConstants {
  // Private constructor to prevent instantiation
  ApiConstants._();

  /// Base URL for JSONPlaceholder API
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  /// Posts endpoint
  static const String postsEndpoint = '/posts';

  /// Request timeout in milliseconds
  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;
}
