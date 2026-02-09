import 'dart:math';
import 'package:dio/dio.dart';

/// Custom interceptor that simulates hostile network conditions
///
/// This interceptor adds:
/// - Random delay between 1-4 seconds on every request
/// - 20% probability of forcing server errors (500 or 401)
class NetworkInterceptor extends Interceptor {
  final Random _random = Random();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Generate random delay between 1000ms and 4000ms
    final delayMs = 1000 + _random.nextInt(3001); // 1000 + (0-3000)

    print('🌐 [INTERCEPTOR] Request to: ${options.uri}');
    print('⏱️  [INTERCEPTOR] Adding delay of ${delayMs}ms');

    // Apply the delay
    await Future.delayed(Duration(milliseconds: delayMs));

    // Generate random number between 0-100 to determine if we should force an error
    final errorChance = _random.nextInt(100);

    // 20% probability of error (errorChance < 20)
    if (errorChance < 20) {
      // Randomly choose between 500 (server error) and 401 (unauthorized)
      final errorCode = _random.nextBool() ? 500 : 401;
      final errorMessage = errorCode == 500
          ? 'Internal Server Error (Forced by Interceptor)'
          : 'Unauthorized (Forced by Interceptor)';

      print('❌ [INTERCEPTOR] Forcing error $errorCode: $errorMessage');

      // Create and throw a DioException
      handler.reject(
        DioException(
          requestOptions: options,
          response: Response(
            requestOptions: options,
            statusCode: errorCode,
            statusMessage: errorMessage,
          ),
          type: DioExceptionType.badResponse,
          error: errorMessage,
        ),
      );
      return;
    }

    print('✅ [INTERCEPTOR] Request continued successfully after delay');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('✅ [INTERCEPTOR] Response received: ${response.statusCode}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('❌ [INTERCEPTOR] Error: ${err.message}');
    print('❌ [INTERCEPTOR] Status Code: ${err.response?.statusCode}');
    handler.next(err);
  }
}
