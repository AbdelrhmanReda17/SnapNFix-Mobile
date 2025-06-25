import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:snapnfix/core/config/application_configurations.dart';
import 'package:snapnfix/core/dependency_injection/dependency_injection.dart';
import 'package:snapnfix/core/infrastructure/networking/api_service.dart';
import 'package:snapnfix/core/infrastructure/networking/http_client_factory.dart';
import 'package:snapnfix/core/infrastructure/networking/interceptors/token_refresh_interceptor.dart';
import 'package:snapnfix/core/infrastructure/networking/managers/base_token_manager.dart';
import 'package:snapnfix/presentation/navigation/navigation_service.dart';

@module
abstract class NetworkModule {
  @singleton
  Dio provideDio() {
    return HttpClientFactory.getClient();
  }

  @singleton
  TokenRefreshInterceptor provideTokenRefreshInterceptor(
    BaseTokenManager tokenManager,
  ) {
    return TokenRefreshInterceptor(
      tokenManager: tokenManager,
      onTokenRefreshFailed: () async {
        getIt<NavigationService>().showSessionExpiredSnackBar();
        await Future.delayed(const Duration(milliseconds: 500));
        await getIt<BaseTokenManager>().clearTokens();
        await getIt<ApplicationConfigurations>().logout();
      },
    );
  }

  @singleton
  ApiService provideApiService(
    Dio dio,
    TokenRefreshInterceptor tokenRefreshInterceptor,
  ) {
    HttpClientFactory.addInterceptor(tokenRefreshInterceptor);
    return ApiService(dio);
  }
}
