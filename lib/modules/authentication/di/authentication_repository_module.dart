import 'package:injectable/injectable.dart';
import 'package:snapnfix/core/config/application_configurations.dart';
import 'package:snapnfix/modules/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:snapnfix/modules/authentication/data/repositories/authentication_repository.dart';
import 'package:snapnfix/modules/authentication/domain/repositories/base_authentication_repository.dart';
import 'package:snapnfix/modules/authentication/domain/services/base_social_authentication_service.dart';

@module
abstract class AuthenticationRepositoryModule {
  @singleton
  BaseAuthenticationRepository provideAuthRepository(
    BaseAuthenticationRemoteDataSource remoteDataSource,
    BaseSocialAuthenticationService socialAuthService,
    ApplicationConfigurations appConfig,
  ) => AuthenticationRepository(remoteDataSource, appConfig, socialAuthService);
}
