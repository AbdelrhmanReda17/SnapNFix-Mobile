import 'package:snapnfix/core/infrastructure/networking/api_result.dart';
import 'package:snapnfix/modules/authentication/domain/entities/authentication_result.dart';
import 'package:snapnfix/modules/authentication/domain/entities/session.dart';

abstract class BaseAuthenticationRepository {
  Future<ApiResult<AuthenticationResult>> login({
    required String phoneOrEmail,
    required String password,
  });
  Future<ApiResult<AuthenticationResult>> requestOTP({
    required String phoneNumber,
    required OtpPurpose purpose,
  });
  Future<void> logout();

  Future<ApiResult<AuthenticationResult>> verifyOTP({
    required String code,
    required OtpPurpose purpose,
  });

  Future<ApiResult<bool>> resendOTP({required OtpPurpose purpose});

  Future<ApiResult<bool>> resetPassword({
    required String newPassword,
    required String confirmPassword,
  });

  Future<ApiResult<Session>> completeProfile({
    required String firstName,
    required String lastName,
    required String password,
  });

  Future<ApiResult<AuthenticationResult>> loginWithGoogle();
  Future<ApiResult<AuthenticationResult>> loginWithFacebook();
}
