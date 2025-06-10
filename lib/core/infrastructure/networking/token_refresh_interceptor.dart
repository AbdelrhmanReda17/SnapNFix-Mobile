import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:snapnfix/core/config/application_configurations.dart';
import 'package:snapnfix/core/dependency_injection/dependency_injection.dart';
import 'package:snapnfix/core/infrastructure/networking/api_constants.dart';
import 'package:snapnfix/core/infrastructure/networking/api_service.dart';
import 'package:snapnfix/core/infrastructure/networking/dio_factory.dart';
import 'package:snapnfix/presentation/navigation/navigation_service.dart';

class TokenRefreshInterceptor extends Interceptor {
  final Dio _dio;
  bool _isRefreshing = false;
  final List<Completer<void>> _pendingRequests = [];

  ApplicationConfigurations get _appConfig =>
      getIt<ApplicationConfigurations>();
  ApiService get _apiService => getIt<ApiService>();

  TokenRefreshInterceptor(this._dio);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Skip token validation for refresh token API to prevent infinite loop
    if (options.path.contains(ApiConstants.refreshToken)) {
      debugPrint('🔄 Skipping token validation for refresh token API');
      handler.next(options);
      return;
    }

    // For testing purposes - set to true to force refresh, false for normal operation
    final isExpired = _appConfig.currentSession?.tokens.isExpired ?? false;
    if (isExpired && _appConfig.isAuthenticated) {
      debugPrint('🔄 Token is expired, refreshing...');
      try {
        await _refreshToken();
        final newToken = _appConfig.currentSession?.tokens.accessToken;
        if (newToken != null) {
          options.headers['Authorization'] = 'Bearer $newToken';
        }
        handler.next(options);
      } catch (e) {
        debugPrint('❌ Pre-request token refresh failed: $e');
        await _handleRefreshFailure();
        handler.reject(
          DioException(requestOptions: options, error: 'Token refresh failed'),
        );
      }
    } else {
      handler.next(options);
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 &&
        !err.requestOptions.path.contains(ApiConstants.refreshToken)) {
      try {
        await _refreshToken();
        final retryResponse = await _retryOriginalRequest(err.requestOptions);
        handler.resolve(retryResponse);
        return;
      } catch (e) {
        debugPrint('❌ Token refresh failed: $e');
        await _handleRefreshFailure();
      }
    }

    handler.next(err);
  }

  Future<void> _refreshToken() async {
    if (_isRefreshing) {
      debugPrint('🔄 Already refreshing token, waiting for completion...');
      final completer = Completer<void>();
      _pendingRequests.add(completer);
      return completer.future;
    }

    _isRefreshing = true;

    try {
      final refreshToken = _appConfig.currentSession?.tokens.refreshToken;
      debugPrint('🔄 Current refresh token: $refreshToken');
      if (refreshToken == null) {
        throw Exception('No refresh token available');
      }

      debugPrint('🔄 Calling refresh token API...');
      final response = await _apiService.refreshToken({
        'refreshToken': refreshToken,
      });

      final tokens = response.data;
      await _appConfig.updateSessionTokens(tokens);
      DioFactory.setTokenIntoHeaderAfterLogin(tokens.accessToken);
      debugPrint('✅ Token refreshed successfully');

      // Complete all pending requests
      for (final completer in _pendingRequests) {
        completer.complete();
      }
      _pendingRequests.clear();
    } catch (e) {
      debugPrint('❌ Token refresh error: $e');

      // Complete all pending requests with error
      for (final completer in _pendingRequests) {
        completer.completeError(e);
      }
      _pendingRequests.clear();
      rethrow;
    } finally {
      _isRefreshing = false;
    }
  }

  Future<Response> _retryOriginalRequest(RequestOptions requestOptions) async {
    debugPrint('🔄 Retrying original request: ${requestOptions.path}');
    final token = _appConfig.currentSession?.tokens.accessToken;

    if (token == null) {
      throw Exception('No access token available after refresh');
    }

    // Create a new request with updated headers
    final updatedHeaders = Map<String, dynamic>.from(requestOptions.headers);
    updatedHeaders['Authorization'] = 'Bearer $token';

    // Use base URL from constants instead of complex path parsing
    String fullUrl;
    if (requestOptions.path.startsWith('http')) {
      // Already a full URL
      fullUrl = requestOptions.path;
    } else {
      // Build URL using ApiConstants.apiBaseUrl
      final baseUrl = ApiConstants.apiBaseUrl;
      final path =
          requestOptions.path.startsWith('/')
              ? requestOptions.path.substring(1)
              : requestOptions.path;

      fullUrl = baseUrl.endsWith('/') ? '$baseUrl$path' : '$baseUrl/$path';
    }

    dynamic requestData = requestOptions.data;
    if (requestOptions.data is FormData) {
      final originalFormData = requestOptions.data as FormData;
      final newFormData = FormData();
      for (final field in originalFormData.fields) {
        newFormData.fields.add(MapEntry(field.key, field.value));
      }
      for (final file in originalFormData.files) {
        newFormData.files.add(
          MapEntry(
            file.key,
            MultipartFile.fromBytes(
              await file.value.finalize().expand((chunk) => chunk).toList(),
              filename: file.value.filename,
              contentType: file.value.contentType,
            ),
          ),
        );
      }
      requestData = newFormData;
    }

    try {
      final response = await _dio.request(
        fullUrl,
        options: Options(
          method: requestOptions.method,
          headers: updatedHeaders,
          sendTimeout: requestOptions.sendTimeout,
          receiveTimeout: requestOptions.receiveTimeout,
          extra: requestOptions.extra,
          responseType: requestOptions.responseType,
          contentType: requestOptions.contentType,
        ),
        data: requestData, // Use the potentially recreated FormData
        queryParameters: requestOptions.queryParameters,
        cancelToken: requestOptions.cancelToken,
        onSendProgress: requestOptions.onSendProgress,
        onReceiveProgress: requestOptions.onReceiveProgress,
      );

      debugPrint('✅ Request retry successful');
      return response;
    } catch (e) {
      debugPrint('❌ Request retry failed: $e');
      rethrow;
    }
  }

  Future<void> _handleRefreshFailure() async {
    try {
      getIt<NavigationService>().showSessionExpiredSnackBar();
      await Future.delayed(const Duration(milliseconds: 500));
      await _appConfig.logout();
      debugPrint('🚪 User logged out due to refresh failure');
    } catch (e) {
      debugPrint('❌ Error during logout: $e');
    }
  }
}

