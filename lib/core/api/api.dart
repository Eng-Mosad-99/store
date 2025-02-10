// ignore_for_file: override_on_non_overriding_member, annotate_overrides, overridden_fields, depend_on_referenced_packages
import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:store_app/core/cache/local_cache.dart';
import 'package:store_app/core/constants/constants.dart';
import 'package:store_app/core/service/service_locator.dart';
import 'package:store_app/features/auth/data/models/auth_model.dart';

class API {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.baseURL,
      responseType: ResponseType.json,
      sendTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  )..interceptors.add(CustomDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      error: true,
    ));

  static Future<Map<String, dynamic>> _header() async {
    final cachedUser = await serviceLocator<LocalCache>().getData(key: 'user');

    final AuthResponse? userData =
        cachedUser == null ? null : AuthResponse.fromJson(cachedUser);
    return {
      'token': userData?.token ?? '',
    };
  }

  /// GET Method
  static Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(headers: await _header()),
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      throw Exception(_handleDioError(e as DioException));
    }
  }

  /// POST Method
  static Future<Response> post(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: await _header()),
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      throw Exception(_handleDioError(e as DioException));
    }
  }

  /// PUT Method
  static Future<Response> put(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: await _header()),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      throw Exception(_handleDioError(e as DioException));
    }
  }

  /// DELETE Method
  static Future<Response> delete(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: await _header()),
        cancelToken: cancelToken,
      );
      return response;
    } catch (e) {
      throw Exception(_handleDioError(e as DioException));
    }
  }

  /// File Upload Method
  static Future<Response> uploadFile({
    required String filePath,
    required String className,
  }) async {
    try {
      final formData = FormData.fromMap({
        'file': [
          await MultipartFile.fromFile(filePath, filename: basename(filePath))
        ],
        'class_name': className,
      });

      final response = await post(
        'upload.php?action=uploadAttachment',
        data: formData,
      );

      return response;
    } catch (e) {
      throw Exception(_handleDioError(e as DioException));
    }
  }

  /// Handles errors from Dio
  static String _handleDioError(DioException e) {
    if (e.response != null) {
      return 'Error: ${e.response?.statusCode}, Message: ${e.response?.data}';
    } else if (e.message != null) {
      return 'Error: ${e.message}';
    } else {
      return 'Unknown Error';
    }
  }
}

class CustomDioLogger extends PrettyDioLogger {
  final bool requestHeader, requestBody, responseBody, error, compact;
  final int maxWidth;
  CustomDioLogger({
    this.requestHeader = false,
    this.requestBody = false,
    this.responseBody = true,
    this.error = true,
    this.compact = true,
    this.maxWidth = 90,
  }) : super(
          requestHeader: requestHeader,
          requestBody: requestBody,
          responseBody: responseBody,
          error: error,
          compact: compact,
          maxWidth: maxWidth,
        );

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response != null) {
      logPrint('🔴 Response Data: ${err.response?.data}');
      logPrint('🔴 Status Code: ${err.response?.statusCode}');
      logPrint('🔴 Headers: ${err.response?.headers}');
    } else if (err.message != null) {
      logPrint('🔴 Error Message: ${err.message}');
    } else {
      logPrint('🔴 Error Details: ${err.error}');
    }
    super.onError(err, handler);
  }
}
