import 'package:snapnfix/modules/authentication/domain/providers/social_authentication_result.dart';

enum SocialAuthenticationProvider { google, facebook }

abstract class BaseSocialAuthenticationProvider {
  Future<SocialAuthenticationResult> signIn();
  Future<void> signOut();
  SocialAuthenticationProvider get providerType;
}
