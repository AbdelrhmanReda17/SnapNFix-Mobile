import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  /// private constructor as I don't want to allow creating an instance of this class
  DioFactory._();

  static Dio? dio;

  static Dio getDio() {
    Duration timeOut = const Duration(seconds: 30);

    if (dio == null) {
      dio = Dio();
      dio!
        ..options.connectTimeout = timeOut
        ..options.receiveTimeout = timeOut;
      addDioInterceptor();
      return dio!;
    } else {
      return dio!;
    }
  }

  static void setTokenIntoHeaderAfterLogin(String token) {
    if (token.isEmpty) {
      return;
    }
    dio?.options.headers = {'Authorization': 'Bearer $token'};
  }

  static void setVerificationTokenHeader(String? verificationToken) {
    if (verificationToken != null) {
      dio?.options.headers = {
        ...dio?.options.headers ?? {},
        'Authorization': 'Bearer $verificationToken',
      };
    }
  }

  static void clearVerificationTokenHeader() {
    if (dio?.options.headers != null) {
      dio?.options.headers.remove('Authorization');
    }
  }

  static void addDioInterceptor() {
    dio?.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );
  }
}
