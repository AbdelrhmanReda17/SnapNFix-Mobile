import 'package:injectable/injectable.dart';
import 'package:snapnfix/core/infrastructure/device_info/device_info_service.dart';
import 'package:snapnfix/core/infrastructure/networking/api_service.dart';
import 'package:snapnfix/modules/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:snapnfix/modules/authentication/data/providers/facebook_authentication_provider.dart';
import 'package:snapnfix/modules/authentication/data/providers/google_authentication_provider.dart';
import 'package:snapnfix/modules/authentication/data/services/social_authentication_service.dart';
import 'package:snapnfix/modules/authentication/domain/providers/social_authentication_provider.dart';
import 'package:snapnfix/modules/authentication/domain/services/base_social_authentication_service.dart';

@module
abstract class AuthenticationDataModule {
  @singleton
  BaseAuthenticationRemoteDataSource provideAuthRemoteDataSource(
    ApiService apiService,
    DeviceInfoService deviceInfoService,
  ) => AuthenticationRemoteDataSource(apiService, deviceInfoService);

  @Named('googleProvider')
  @singleton
  BaseSocialAuthenticationProvider provideGoogleAuthProvider() =>
      GoogleAuthProvider();

  @Named('facebookProvider')
  @singleton
  BaseSocialAuthenticationProvider provideFacebookAuthProvider() =>
      FacebookAuthProvider();

  @singleton
  BaseSocialAuthenticationService provideSocialAuthService(
    @Named('googleProvider') BaseSocialAuthenticationProvider googleProvider,
    @Named('facebookProvider')
    BaseSocialAuthenticationProvider facebookProvider,
  ) => SocialAuthenticationService(
    googleProvider: googleProvider as GoogleAuthProvider,
    facebookProvider: facebookProvider as FacebookAuthProvider,
  );
}
