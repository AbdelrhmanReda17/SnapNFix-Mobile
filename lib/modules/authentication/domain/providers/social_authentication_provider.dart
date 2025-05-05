import 'package:snapnfix/modules/authentication/domain/providers/social_authentication_result.dart';

enum SocialAuthenticationProvider {
  google("Google"),
  facebook("Facebook");

  final String name;
  const SocialAuthenticationProvider(this.name);
}

abstract class BaseSocialAuthenticationProvider {
  Future<SocialAuthenticationResult> signIn();
  Future<void> signOut();
  SocialAuthenticationProvider get providerType;
}
