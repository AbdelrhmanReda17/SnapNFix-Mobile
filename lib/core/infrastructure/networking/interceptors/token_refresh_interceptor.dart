import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:snapnfix/core/infrastructure/networking/api_configuration.dart';
import 'package:snapnfix/core/infrastructure/networking/http_client_factory.dart';
import 'package:snapnfix/core/infrastructure/networking/managers/base_token_manager.dart';

class TokenRefreshInterceptor extends Interceptor {
  final BaseTokenManager _tokenManager;
  final Future<void> Function()? _onTokenRefreshFailed;

  bool _isRefreshing = false;
  final List<Completer<void>> _pendingRequests = [];

  TokenRefreshInterceptor({
    required BaseTokenManager tokenManager,
    Future<void> Function()? onTokenRefreshFailed,
  }) : _tokenManager = tokenManager,
       _onTokenRefreshFailed = onTokenRefreshFailed;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (_isRefreshTokenEndpoint(options.path)) {
      handler.next(options);
      return;
    }

    final token = _tokenManager.accessToken;
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    if (_tokenManager.isTokenExpired && _tokenManager.refreshToken != null) {
      debugPrint('Token is expired, refreshing before request...');
      try {
        await _refreshTokenIfNeeded();
        final newToken = _tokenManager.accessToken;
        if (newToken != null && newToken.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $newToken';
        }
      } catch (e) {
        debugPrint('Token refresh failed in onRequest: $e');
        handler.reject(
          DioException(
            requestOptions: options,
            error: 'Token refresh failed: $e',
            type: DioExceptionType.unknown,
          ),
        );
        return;
      }
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    debugPrint('TokenRefreshInterceptor onError: ${err.message}');

    if (_shouldRetryWithTokenRefresh(err)) {
      debugPrint('Attempting token refresh due to 401 error...');

      try {
        await _refreshTokenIfNeeded();
        final retryResponse = await _retryRequest(err.requestOptions);
        handler.resolve(retryResponse);
        return;
      } catch (e) {
        debugPrint('Token refresh failed in onError: $e');
        await _handleTokenRefreshFailure();
        final authError = DioException(
          requestOptions: err.requestOptions,
          response: err.response,
          error: 'Authentication failed - please login again',
          type: DioExceptionType.badResponse,
        );
        handler.next(authError);
        return;
      }
    }
    handler.next(err);
  }

  bool _isRefreshTokenEndpoint(String path) {
    return path.contains(ApiEndpoints.refreshToken) ||
        path.endsWith(ApiEndpoints.refreshToken);
  }

  bool _shouldRetryWithTokenRefresh(DioException error) {
    return error.response?.statusCode == 401 &&
        !_isRefreshTokenEndpoint(error.requestOptions.path) &&
        _tokenManager.refreshToken != null;
  }

  Future<void> _refreshTokenIfNeeded() async {
    if (_isRefreshing) {
      final completer = Completer<void>();
      _pendingRequests.add(completer);
      return completer.future;
    }

    _isRefreshing = true;

    try {
      debugPrint('Starting token refresh...');
      final newToken = await _tokenManager.refreshAccessToken();

      if (newToken == null || newToken.isEmpty) {
        throw Exception('Token refresh returned null or empty token');
      }

      HttpClientFactory.setAuthToken(newToken);

      debugPrint('Token refresh successful');
      _completePendingRequests();
    } catch (e) {
      debugPrint('Token refresh failed: $e');
      _completePendingRequestsWithError(e);
      await _handleTokenRefreshFailure();
      rethrow;
    } finally {
      _isRefreshing = false;
    }
  }

  void _completePendingRequests() {
    for (final completer in _pendingRequests) {
      if (!completer.isCompleted) {
        completer.complete();
      }
    }
    _pendingRequests.clear();
  }

  void _completePendingRequestsWithError(Object error) {
    for (final completer in _pendingRequests) {
      if (!completer.isCompleted) {
        completer.completeError(error);
      }
    }
    _pendingRequests.clear();
  }

  Future<Response> _retryRequest(RequestOptions originalRequest) async {
    final newToken = _tokenManager.accessToken;
    if (newToken != null && newToken.isNotEmpty) {
      originalRequest.headers['Authorization'] = 'Bearer $newToken';
    }

    debugPrint('Retrying request with new token: ${originalRequest.path}');

    return HttpClientFactory.getClient().request(
      originalRequest.path,
      options: Options(
        method: originalRequest.method,
        headers: originalRequest.headers,
        responseType: originalRequest.responseType,
        contentType: originalRequest.contentType,
        validateStatus: originalRequest.validateStatus,
        receiveTimeout: originalRequest.receiveTimeout,
        sendTimeout: originalRequest.sendTimeout,
        extra: originalRequest.extra,
      ),
      data: originalRequest.data,
      queryParameters: originalRequest.queryParameters,
      cancelToken: originalRequest.cancelToken,
    );
  }

  Future<void> _handleTokenRefreshFailure() async {
    await _tokenManager.clearTokens();
    HttpClientFactory.clearAuthToken();
    await _onTokenRefreshFailed?.call();
  }
}
