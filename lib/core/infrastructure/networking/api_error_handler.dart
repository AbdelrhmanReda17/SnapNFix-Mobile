import 'package:dio/dio.dart';
import 'package:snapnfix/core/exceptions/unverified_user_exception.dart';

import 'api_error_model.dart';

class ApiErrorHandler {
  static ApiErrorModel handle(dynamic error) {
    if (error is UnverifiedUserException) {
      return ApiErrorModel(
        message: error.message,
        errors: [
          {'propertyName': 'PhoneNumberUnconfirmed', 'message': error.message},
        ],
      );
    }
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionError:
          return ApiErrorModel(message: "Connection to server failed");
        case DioExceptionType.cancel:
          return ApiErrorModel(message: "Request to the server was cancelled");
        case DioExceptionType.connectionTimeout:
          return ApiErrorModel(message: "Connection timeout with the server");
        case DioExceptionType.unknown:
          return ApiErrorModel(
            message: "Connection to the server failed due to internet connection",
          );
        case DioExceptionType.receiveTimeout:
          return ApiErrorModel(
            message: "Receive timeout in connection with the server",
          );
        case DioExceptionType.badResponse:
          return _handleError(error.response!.data);
        case DioExceptionType.sendTimeout:
          return ApiErrorModel(
            message: "Send timeout in connection with the server",
          );
        default:
          return ApiErrorModel(message: "Something went wrong");
      }
    } else {
      return ApiErrorModel(message: "Unknown error occurred");
    }
  }

  static bool isUnverifiedUser(dynamic error) {
    if (error is DioException) {
      final response = error.response?.data;
      return response != null &&
          response['errors']?.any(
                (e) => e['propertyName'] == 'PhoneNumberUnconfirmed',
              ) ==
              true;
    }
    return false;
  }

  static bool isAuthenticationError(dynamic error) {
    if (error is DioException) {
      final response = error.response?.data;
      return response != null &&
          response['errors']?.any(
                (e) => e['propertyName'] == 'Authentication',
              ) ==
              true;
    }
    return false;
  }
}

ApiErrorModel _handleError(dynamic data) {
  return ApiErrorModel.fromJson(data);
}
