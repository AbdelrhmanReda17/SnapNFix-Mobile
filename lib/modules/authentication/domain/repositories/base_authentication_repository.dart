import 'package:snapnfix/core/infrastructure/networking/api_result.dart';
import 'package:snapnfix/modules/authentication/domain/entities/session.dart';
import 'package:snapnfix/modules/authentication/domain/entities/user_gender.dart';

abstract class BaseAuthenticationRepository {
  Future<ApiResult<Session>> login({
    required String phoneOrEmail,
    required String password,
  });
  Future<ApiResult<Session>> register({
    required String phoneNumber,
    required String password,
    required String confirmPassword,
  });
  Future<void> logout();

  Future<ApiResult<Session>> verifyOtp({required String code});

  Future<ApiResult<void>> resendOtp();

  Future<ApiResult<void>> forgotPassword({required String emailOrPhoneNumber});

  Future<ApiResult<bool>> resetPassword({
    required String newPassword,
    required String confirmPassword,
  });

  Future<ApiResult<Session>> completeProfile({
    required String firstName,
    required String lastName,
    UserGender? gender,
    DateTime? dateOfBirth,
  });
}
