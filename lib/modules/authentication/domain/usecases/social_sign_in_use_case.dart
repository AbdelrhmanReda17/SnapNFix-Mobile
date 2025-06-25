import 'package:snapnfix/modules/authentication/index.dart';
import 'package:snapnfix/core/index.dart';

class SocialSignInUseCase {
  final BaseAuthenticationRepository _authRepository;

  SocialSignInUseCase(this._authRepository);
  Future<Result<AuthenticationResult, ApiError>> callGoogleSignIn() async {
    return _authRepository.loginWithGoogle();
  }

  Future<Result<AuthenticationResult, ApiError>> callFacebookSignIn() async {
    return _authRepository.loginWithFacebook();
  }
}
