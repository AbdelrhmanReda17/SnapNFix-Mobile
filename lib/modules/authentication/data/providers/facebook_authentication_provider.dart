import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:snapnfix/modules/authentication/domain/providers/social_authentication_provider.dart';
import 'package:snapnfix/modules/authentication/domain/providers/social_authentication_result.dart';

class FacebookAuthProvider implements BaseSocialAuthenticationProvider {
  final FacebookAuth _facebookAuth;

  FacebookAuthProvider({FacebookAuth? facebookAuth})
    : _facebookAuth = facebookAuth ?? FacebookAuth.instance;

  @override
  SocialAuthenticationProvider get providerType =>
      SocialAuthenticationProvider.facebook;

  @override
  Future<SocialAuthenticationResult> signIn() async {
    try {
      final LoginResult result = await _facebookAuth.login();

      switch (result.status) {
        case LoginStatus.success:
          if (result.accessToken?.tokenString == null) {
            return const SocialAuthenticationResult.failure(
              errorMessage: 'Failed to get access token',
            );
          }

          return SocialAuthenticationResult.success(
            idToken: result.accessToken!.tokenString,
          );

        case LoginStatus.cancelled:
          return const SocialAuthenticationResult.cancelled();

        case LoginStatus.failed:
          return SocialAuthenticationResult.failure(
            errorMessage: result.message ?? 'Facebook sign in failed',
          );

        default:
          return const SocialAuthenticationResult.failure(
            errorMessage: 'Unknown error occurred',
          );
      }
    } catch (e) {
      return SocialAuthenticationResult.failure(
        errorMessage: 'Facebook sign in failed',
      );
    }
  }

  @override
  Future<void> signOut() async {
    await _facebookAuth.logOut();
  }
}
