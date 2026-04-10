import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class DioClient {
  static const String apiKey = "YOUR_API_KEY_HERE"; // Đăng ký tại newsapi.org
  
  late Dio _dio;
  final Logger _logger = Logger();

  DioClient() {
    _dio = Dio(BaseOptions(
      baseUrl: "https://newsapi.org/v2",
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
      },
    ));
    
    _setupInterceptors();
  }

  Dio get dio => _dio;

  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          _logger.i('📤 Request: ${options.method} ${options.path}');
          _logger.i('📦 Query Parameters: ${options.queryParameters}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          _logger.i('📥 Response: ${response.statusCode} ${response.requestOptions.path}');
          return handler.next(response);
        },
        onError: (DioException error, handler) {
          _logger.e('❌ Error: ${error.message}');
          _logger.e('🎯 URL: ${error.requestOptions.uri}');
          
          // Xử lý lỗi chi tiết
          String errorMessage = _handleError(error);
          return handler.next(error);
        },
      ),
    );
  }

  String _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return 'Kết nối quá thời gian. Vui lòng thử lại.';
      case DioExceptionType.sendTimeout:
        return 'Gửi dữ liệu quá thời gian.';
      case DioExceptionType.receiveTimeout:
        return 'Nhận dữ liệu quá thời gian.';
      case DioExceptionType.badResponse:
        return _handleStatusCode(error.response?.statusCode);
      case DioExceptionType.cancel:
        return 'Đã hủy yêu cầu.';
      default:
        return 'Không thể kết nối đến máy chủ.';
    }
  }

  String _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Yêu cầu không hợp lệ.';
      case 401:
        return 'API Key không hợp lệ. Vui lòng kiểm tra lại.';
      case 403:
        return 'Từ chối truy cập.';
      case 404:
        return 'Không tìm thấy dữ liệu.';
      case 500:
        return 'Lỗi máy chủ nội bộ.';
      default:
        return 'Đã có lỗi xảy ra. Mã lỗi: $statusCode';
    }
  }
}