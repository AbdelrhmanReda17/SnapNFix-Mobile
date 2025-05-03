import 'package:snapnfix/core/infrastructure/networking/api_result.dart';
import 'package:snapnfix/modules/authentication/domain/entities/authentication_result.dart';
import 'package:snapnfix/modules/authentication/domain/repositories/base_authentication_repository.dart';

class SocialSignInUseCase {
  final BaseAuthenticationRepository _authRepository;

  SocialSignInUseCase(this._authRepository);

  Future<ApiResult<AuthenticationResult>> callGoogleSignIn() async {
    return _authRepository.loginWithGoogle();
  }

  Future<ApiResult<AuthenticationResult>> callFacebookSignIn() async {
    return _authRepository.loginWithFacebook();
  }
}
