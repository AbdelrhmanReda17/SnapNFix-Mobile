import 'package:dio/dio.dart'
    show DioException, DioExceptionType, ErrorInterceptorHandler, Interceptor;
import 'package:flutter/material.dart';
import 'package:snapnfix/core/infrastructure/networking/error/api_error.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final apiError = _transformDioError(err);
    debugPrint('API Error: ${apiError.message}');
    debugPrint('API Error Details: ${apiError.fullMessage}');

    final transformedError = DioException(
      requestOptions: err.requestOptions,
      response: err.response,
      error: apiError,
      type: err.type,
      message: apiError.message,
    );

    handler.next(transformedError);
  }

  ApiError _transformDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const ApiError(
          message: 'Connection timeout. Please check your internet connection.',
          code: 'TIMEOUT',
        );

      case DioExceptionType.badResponse:
        return _handleBadResponse(error);

      case DioExceptionType.cancel:
        return const ApiError(
          message: 'Request was cancelled',
          code: 'CANCELLED',
        );

      case DioExceptionType.connectionError:
        return const ApiError(
          message: 'No internet connection',
          code: 'NO_CONNECTION',
        );

      default:
        return ApiError(
          message: error.message ?? 'An unexpected error occurred',
          code: 'UNKNOWN',
        );
    }
  }

  ApiError _handleBadResponse(DioException error) {
    final response = error.response;
    if (response?.data is Map<String, dynamic>) {
      try {
        return ApiError.fromJson(response!.data);
      } catch (e) {
        return ApiError(
          message: 'Failed to parse error response',
          code: 'PARSE_ERROR',
        );
      }
    }
    return ApiError(
      message: _getStatusMessage(response?.statusCode),
      statusCode: response?.statusCode,
      code: 'HTTP_ERROR',
    );
  }

  String _getStatusMessage(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        return 'Unauthorized access';
      case 403:
        return 'Access forbidden';
      case 404:
        return 'Resource not found';
      case 500:
        return 'Internal server error';
      default:
        return 'Network error occurred';
    }
  }
}
