import 'package:snapnfix/modules/authentication/domain/providers/social_authentication_provider.dart';
import 'package:snapnfix/modules/authentication/domain/providers/social_authentication_result.dart';

abstract class BaseSocialAuthenticationService {
  Future<SocialAuthenticationResult> signIn(
    SocialAuthenticationProvider provider,
  );
  Future<void> signOut(SocialAuthenticationProvider provider);
  Future<void> signOutAll();
}
