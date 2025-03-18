import 'package:dio/dio.dart';
import 'package:snapnfix/core/networking/api_error_model.dart';

// extension DataSourceExtension on DataSource {}

class ApiErrorHandler implements Exception {
  late final ApiErrorModel apiErrorModel;

  ApiErrorHandler(dynamic error) {
    if (error is DioException) {
      handleDioException(error);
    } else {
      apiErrorModel = ApiErrorModel(message: error.toString());
    }
  }

  void handleDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        apiErrorModel = ApiErrorModel(message: "Connection timeout");
        break;
      case DioExceptionType.sendTimeout:
        apiErrorModel = ApiErrorModel(message: "Send timeout");
        break;
      case DioExceptionType.receiveTimeout:
        apiErrorModel = ApiErrorModel(message: "Receive timeout");
        break;
      case DioExceptionType.badResponse:
        apiErrorModel = ApiErrorModel(message: error.response!.data['message']);
        break;
      case DioExceptionType.cancel:
        apiErrorModel = ApiErrorModel(message: "Request cancelled");
        break;
      case DioExceptionType.badCertificate:
        apiErrorModel = ApiErrorModel(message: "Bad certificate");
      case DioExceptionType.connectionError:
        apiErrorModel = ApiErrorModel(message: "Connection error");
        break;
      case DioExceptionType.unknown:
        apiErrorModel = ApiErrorModel(message: "Something went wrong");
        break;
    }
  }
}
