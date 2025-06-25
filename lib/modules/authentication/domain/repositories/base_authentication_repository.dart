import 'package:snapnfix/core/index.dart';
import 'package:snapnfix/modules/authentication/index.dart';

abstract class BaseAuthenticationRepository {
  Future<Result<AuthenticationResult, ApiError>> login({
    required String phoneOrEmail,
    required String password,
  });
  Future<Result<AuthenticationResult, ApiError>> requestOTP({
    required String phoneNumber,
    required OtpPurpose purpose,
  });
  Future<Result<void, ApiError>> logout();

  Future<Result<AuthenticationResult, ApiError>> verifyOTP({
    required String code,
    required OtpPurpose purpose,
  });

  Future<Result<bool, ApiError>> resendOTP({required OtpPurpose purpose});

  Future<Result<bool, ApiError>> resetPassword({
    required String newPassword,
    required String confirmPassword,
  });

  Future<Result<Session, ApiError>> register({
    required String firstName,
    required String lastName,
    required String password,
  });

  Future<Result<AuthenticationResult, ApiError>> loginWithGoogle();
  Future<Result<AuthenticationResult, ApiError>> loginWithFacebook();
}
