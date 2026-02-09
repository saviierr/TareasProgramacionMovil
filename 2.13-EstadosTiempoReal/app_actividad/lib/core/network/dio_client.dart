import 'package:dio/dio.dart';
import 'package:app_resilencia/core/constants/api_constants.dart';
import 'package:app_resilencia/core/network/network_interceptor.dart';

/// Singleton Dio client configured with custom interceptor
class DioClient {
  // Private constructor
  DioClient._();

  // Singleton instance
  static final DioClient _instance = DioClient._();

  // Factory constructor returns singleton instance
  factory DioClient() => _instance;

  // Dio instance
  late final Dio _dio;

  /// Initialize the Dio client with base configuration
  void init() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: Duration(milliseconds: ApiConstants.connectTimeout),
        receiveTimeout: Duration(milliseconds: ApiConstants.receiveTimeout),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add the custom network interceptor
    _dio.interceptors.add(NetworkInterceptor());

    print('✨ [DIO CLIENT] Initialized with base URL: ${ApiConstants.baseUrl}');
  }

  /// Get the Dio instance
  Dio get dio => _dio;
}
