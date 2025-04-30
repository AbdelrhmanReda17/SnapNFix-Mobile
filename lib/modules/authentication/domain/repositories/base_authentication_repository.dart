import 'package:snapnfix/core/infrastructure/networking/api_result.dart';
import 'package:snapnfix/modules/authentication/domain/entities/authentication_result.dart';
import 'package:snapnfix/modules/authentication/domain/entities/session.dart';

abstract class BaseAuthenticationRepository {
  Future<ApiResult<AuthenticationResult>> login({
    required String phoneOrEmail,
    required String password,
  });
  Future<ApiResult<AuthenticationResult>> register({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String password,
    required String confirmPassword,
  });
  Future<void> logout();

  Future<ApiResult<bool>> verifyOtp({
    required String code,
    required String verificationToken,
    required String phoneNumber,
  });

  Future<ApiResult<void>> resendOtp();

  Future<ApiResult<AuthenticationResult>> forgotPassword({
    required String emailOrPhoneNumber,
  });

  Future<ApiResult<bool>> resetPassword({
    required String newPassword,
    required String confirmPassword,
  });
}
