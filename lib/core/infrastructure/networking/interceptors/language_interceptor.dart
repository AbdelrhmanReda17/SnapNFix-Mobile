import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:snapnfix/core/config/application_configurations.dart';
import 'package:snapnfix/core/dependency_injection/dependency_injection.dart';

class LanguageInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    try {
      final language = getIt<ApplicationConfigurations>().language;
      debugPrint('Setting Accept-Language header to: $language');
      options.headers['Accept-Language'] = language;
    } catch (e) {
      options.headers['Accept-Language'] = 'en';
    }

    super.onRequest(options, handler);
  }
}
