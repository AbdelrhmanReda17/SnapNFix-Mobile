import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:snapnfix/core/config/application_configurations.dart';
import 'package:snapnfix/core/dependency_injection/dependency_injection.dart';
import 'package:snapnfix/core/utils/helpers/shared_pref_keys.dart';
import 'package:snapnfix/core/infrastructure/storage/secure_storage_service.dart';

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
      addDioHeaders();
      addDioInterceptor();
      return dio!;
    } else {
      return dio!;
    }
  }

  static void addDioHeaders() async {
    final token =
        getIt<ApplicationConfigurations>().currentSession?.tokens.accessToken;

    debugPrint("From Dio Header: $token");
    dio?.options.headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token ?? ""}',
    };
  }

  static void setTokenIntoHeaderAfterLogin(String token) {
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
