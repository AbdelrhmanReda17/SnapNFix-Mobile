import 'package:google_sign_in/google_sign_in.dart';
import 'package:snapnfix/modules/authentication/domain/providers/social_authentication_provider.dart';
import 'package:snapnfix/modules/authentication/domain/providers/social_authentication_result.dart';

class GoogleAuthProvider implements BaseSocialAuthenticationProvider {
  final GoogleSignIn _googleSignIn;

  GoogleAuthProvider({GoogleSignIn? googleSignIn})
    : _googleSignIn = googleSignIn ?? GoogleSignIn();

  @override
  SocialAuthenticationProvider get providerType =>
      SocialAuthenticationProvider.google;

  @override
  Future<SocialAuthenticationResult> signIn() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();

      if (account == null) {
        return const SocialAuthenticationResult.cancelled();
      }

      final GoogleSignInAuthentication auth = await account.authentication;

      if (auth.accessToken == null) {
        return const SocialAuthenticationResult.failure(
          errorMessage: 'Failed to get access token',
        );
      }

      return SocialAuthenticationResult.success(accessToken: auth.accessToken!);
    } catch (e) {
      return SocialAuthenticationResult.failure(
        errorMessage: 'Google sign in failed',
      );
    }
  }

  @override
  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
}
