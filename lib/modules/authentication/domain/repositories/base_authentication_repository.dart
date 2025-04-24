import 'package:snapnfix/core/infrastructure/networking/api_result.dart';
import 'package:snapnfix/modules/authentication/domain/entities/session.dart';

abstract class BaseAuthenticationRepository {
  Future<ApiResult<Session>> login({
    required String phoneOrEmail,
    required String password,
  });
  Future<ApiResult<Session>> register({
    required String fistName,
    required String lastName,
    required String phoneNumber,
    required String password,
    required String confirmPassword,
  });
  Future<void> logout();

  Future<ApiResult<Session>> verifyOtp({
    required String code,
  });

  Future<ApiResult<void>> resendOtp();
}
