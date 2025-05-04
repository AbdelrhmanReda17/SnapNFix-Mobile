import 'package:snapnfix/modules/authentication/data/providers/facebook_authentication_provider.dart';
import 'package:snapnfix/modules/authentication/data/providers/google_authentication_provider.dart';
import 'package:snapnfix/modules/authentication/domain/providers/social_authentication_provider.dart';
import 'package:snapnfix/modules/authentication/domain/providers/social_authentication_result.dart';
import 'package:snapnfix/modules/authentication/domain/services/base_social_authentication_service.dart';

class SocialAuthenticationService implements BaseSocialAuthenticationService {
  final Map<SocialAuthenticationProvider, BaseSocialAuthenticationProvider>
  _providers = {};

  SocialAuthenticationService({
    GoogleAuthProvider? googleProvider,
    FacebookAuthProvider? facebookProvider,
  }) {
    registerProvider(googleProvider ?? GoogleAuthProvider());
    registerProvider(facebookProvider ?? FacebookAuthProvider());
  }

  void registerProvider(BaseSocialAuthenticationProvider provider) {
    _providers[provider.providerType] = provider;
  }

  @override
  Future<SocialAuthenticationResult> signIn(
    SocialAuthenticationProvider provider,
  ) async {
    final authProvider = _providers[provider];
  
    if (authProvider == null) {
      return const SocialAuthenticationResult.failure(
        errorMessage: 'Provider not registered',
      );
    }

    return await authProvider.signIn();
  }

  @override
  Future<void> signOut(SocialAuthenticationProvider provider) async {
    final authProvider = _providers[provider];
    if (authProvider != null) {
      await authProvider.signOut();
    }
  }

  @override
  Future<void> signOutAll() async {
    for (final provider in _providers.values) {
      await provider.signOut();
    }
  }
}
