import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:snapnfix/core/infrastructure/networking/api_configuration.dart';
import 'package:snapnfix/core/infrastructure/networking/interceptors/error_interceptor.dart';
import 'package:snapnfix/core/infrastructure/networking/interceptors/language_interceptor.dart';

class HttpClientFactory {
  HttpClientFactory._();

  static Dio? _instance;

  static Dio getClient() {
    return _instance ??= _createClient();
  }

  static Dio _createClient() {
    final dio = Dio();

    _configureTimeouts(dio);
    _configureHeaders(dio, null);
    dio.options.baseUrl = ApiEndpoints.baseUrl;
    dio.interceptors.addAll([
      LanguageInterceptor(),
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ),
      ErrorInterceptor(),
    ]);

    return dio;
  }

  static void addInterceptor(Interceptor interceptor) {
    final client = getClient();
    client.interceptors.removeWhere(
      (i) => i.runtimeType == interceptor.runtimeType,
    );
    final errorInterceptorIndex = client.interceptors.indexWhere(
      (i) => i is ErrorInterceptor,
    );
    if (errorInterceptorIndex != -1) {
      client.interceptors.insert(errorInterceptorIndex, interceptor);
    } else {
      client.interceptors.add(interceptor);
    }
  }

  static void removeInterceptor<T extends Interceptor>() {
    final client = getClient();
    client.interceptors.removeWhere((i) => i is T);
  }

  static void _configureTimeouts(Dio dio) {
    dio.options
      ..connectTimeout = NetworkConfig.connectionTimeout
      ..receiveTimeout = NetworkConfig.receiveTimeout
      ..sendTimeout = NetworkConfig.sendTimeout;
  }

  static void _configureHeaders(Dio dio, Map<String, String>? headers) {
    dio.options.headers.addAll({
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      ...?headers,
    });
  }

  static void setAuthToken(String token) {
    if (token.isEmpty) return;
    debugPrint('Setting auth token: $token');

    final bearerToken = 'Bearer $token';
    getClient().options.headers['Authorization'] = bearerToken;

    debugPrint('Auth token updated in HTTP client');
  }

  static void clearAuthToken() {
    getClient().options.headers.remove('Authorization');
    debugPrint('Auth token cleared from HTTP client');
  }

  static void resetInstance() {
    _instance?.close();
    _instance = null;
    debugPrint('HTTP client instance reset');
  }
}
