import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:app_resilencia/core/network/dio_client.dart';
import 'package:app_resilencia/core/constants/api_constants.dart';
import 'package:app_resilencia/models/post_model.dart';

enum PostState { loading, success, empty, error }

class PostProvider extends ChangeNotifier {
  // Current state
  PostState _currentState = PostState.loading;
  PostState get currentState => _currentState;

  // Posts list
  List<Post> _posts = [];
  List<Post> get posts => _posts;

  // Error message
  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  // Dio client
  final DioClient _dioClient = DioClient();

  Future<void> fetchPosts() async {
    print('📡 [PROVIDER] Fetching posts...');

    // Set loading state
    _currentState = PostState.loading;
    _errorMessage = '';
    notifyListeners();

    try {
      // Make the API request (will go through the interceptor)
      final response = await _dioClient.dio.get(ApiConstants.postsEndpoint);

      // Parse response
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data as List<dynamic>;

        // Convert to Post models
        _posts = jsonList
            .map((json) => Post.fromJson(json as Map<String, dynamic>))
            .toList();

        print('✅ [PROVIDER] Received ${_posts.length} posts');

        // Determine state based on result
        if (_posts.isEmpty) {
          _currentState = PostState.empty;
          print('📭 [PROVIDER] State: EMPTY (no posts)');
        } else {
          _currentState = PostState.success;
          print('✅ [PROVIDER] State: SUCCESS (${_posts.length} posts)');
        }
      } else {
        // Unexpected status code
        _errorMessage = 'Error del servidor: código ${response.statusCode}';
        _currentState = PostState.error;
        print('❌ [PROVIDER] State: ERROR (unexpected status code)');
      }
    } on DioException catch (e) {
      // Handle Dio-specific errors
      _handleDioError(e);
    } catch (e) {
      // Handle any other errors
      _errorMessage = 'Error inesperado: $e';
      _currentState = PostState.error;
      print('❌ [PROVIDER] State: ERROR (unexpected exception)');
      print('❌ [PROVIDER] Exception: $e');
    }

    notifyListeners();
  }

  /// Handles Dio-specific errors
  void _handleDioError(DioException error) {
    print('❌ [PROVIDER] DioException caught');
    print('❌ [PROVIDER] Type: ${error.type}');
    print('❌ [PROVIDER] Message: ${error.message}');

    _currentState = PostState.error;

    // Provide user-friendly error messages based on error type
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        _errorMessage = 'Tiempo de espera agotado. Verifica tu conexión.';
        break;

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        if (statusCode == 401) {
          _errorMessage = 'No autorizado. Verifica tus credenciales.';
        } else if (statusCode == 500) {
          _errorMessage = 'Error del servidor. Intenta de nuevo más tarde.';
        } else {
          _errorMessage = 'Error del servidor (código $statusCode)';
        }
        break;

      case DioExceptionType.connectionError:
        _errorMessage = 'Error de conexión. Verifica tu red.';
        break;

      case DioExceptionType.cancel:
        _errorMessage = 'Solicitud cancelada.';
        break;

      default:
        _errorMessage = 'Error de red: ${error.message ?? "desconocido"}';
    }

    print('❌ [PROVIDER] User message: $_errorMessage');
  }

  /// Retry fetching posts (used by the retry button in error view)
  Future<void> retry() async {
    print('🔄 [PROVIDER] Retry requested');
    await fetchPosts();
  }
}
