import 'package:injectable/injectable.dart';
import 'package:snapnfix/core/config/application_configurations.dart';
import 'package:snapnfix/core/infrastructure/networking/api_service.dart';
import 'package:snapnfix/core/infrastructure/networking/http_client_factory.dart';
import 'package:snapnfix/core/infrastructure/networking/managers/base_token_manager.dart';
import 'package:snapnfix/core/infrastructure/networking/managers/token_manager.dart';

@module
abstract class ManagerModule {
  @singleton
  BaseTokenManager provideTokenManager(ApplicationConfigurations appConfig) {
    final tokenRefreshApiService = ApiService(HttpClientFactory.getClient());

    return TokenManager(
      appConfig: appConfig,
      apiService: tokenRefreshApiService,
    );
  }
}
