import 'package:flutter/material.dart';
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
      debugPrint('Google sign in started ${_googleSignIn.clientId}');
      debugPrint('Google sign in started ${_googleSignIn.serverClientId}');
      debugPrint('Google sign in started ${_googleSignIn.scopes}');
      debugPrint('Google sign in started ${_googleSignIn.signInOption}');
      final GoogleSignInAccount? account = await _googleSignIn.signIn();

      if (account == null) {
        return const SocialAuthenticationResult.cancelled();
      }

      final GoogleSignInAuthentication auth = await account.authentication;

      if (auth.idToken == null) {
        return const SocialAuthenticationResult.failure(
          errorMessage: 'Failed to get access token',
        );
      }

      return SocialAuthenticationResult.success(idToken: auth.idToken!);
    } catch (e) {
      debugPrint('Google sign in error: $e');
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
