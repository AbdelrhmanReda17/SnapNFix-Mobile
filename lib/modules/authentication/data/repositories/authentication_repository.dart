import 'package:snapnfix/core/config/application_configurations.dart';
import 'package:snapnfix/core/infrastructure/networking/api_error_handler.dart';
import 'package:snapnfix/core/infrastructure/networking/api_result.dart';
import 'package:snapnfix/modules/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:snapnfix/modules/authentication/data/models/dtos/complete_profile_dto.dart';
import 'package:snapnfix/modules/authentication/data/models/dtos/login_dto.dart';
import 'package:snapnfix/modules/authentication/data/models/dtos/reset_password_dto.dart';
import 'package:snapnfix/modules/authentication/data/models/session_model.dart';
import 'package:snapnfix/modules/authentication/domain/entities/authentication_result.dart';
import '../../domain/repositories/base_authentication_repository.dart';

class AuthenticationRepository implements BaseAuthenticationRepository {
  final BaseAuthenticationRemoteDataSource remoteDataSource;
  final ApplicationConfigurations _appConfig;

  AuthenticationRepository(this.remoteDataSource, this._appConfig);

  Future<ApiResult<R>> _handleApiCall<T, R>({
    required Future<ApiResult<T>> Function() call,
    Future<ApiResult<R>> Function(T data)? onSuccess,
  }) async {
    try {
      final result = await call();
      return result.when(
        success: (data) async {
          if (onSuccess != null) {
            return await onSuccess(data);
          }
          return ApiResult.success(data as R);
        },
        failure: (error) => ApiResult.failure(error),
      );
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<AuthenticationResult>> login({
    required String phoneOrEmail,
    required String password,
  }) async {
    return _handleApiCall<SessionModel, AuthenticationResult>(
      call:
          () => remoteDataSource.login(
            LoginDTO(emailOrPhoneNumber: phoneOrEmail, password: password),
          ),
      onSuccess: (session) async {
        await _appConfig.setUserSession(session);
        return ApiResult.success(AuthenticationResult.authenticated(session));
      },
    );
  }

  @override
  Future<void> logout() async {
    try {
      await _appConfig.logout();
    } catch (e) {
      throw Exception('Failed to logout: ${e.toString()}');
    }
  }

  @override
  Future<ApiResult<AuthenticationResult>> requestOTP({
    required String phoneNumber,
    bool isRegister = false,
  }) async {
    return _handleApiCall<String, AuthenticationResult>(
      call:
          () =>
              remoteDataSource.requestOTP(phoneNumber, isRegister: isRegister),
      onSuccess: (verificationToken) async {
        return ApiResult.success(
          AuthenticationResult.requiresOtp(
            purpose:
                isRegister ? OtpPurpose.registration : OtpPurpose.passwordReset,
          ),
        );
      },
    );
  }

  @override
  Future<ApiResult<AuthenticationResult>> verifyOTP({
    required String code,
    required OtpPurpose purpose,
    String? password,
  }) async {
    return _handleApiCall(
      call:
          () => remoteDataSource.verifyOtp(
            code,
            isRegister: purpose == OtpPurpose.registration,
          ),
      onSuccess: (res) async {
        switch (purpose) {
          case OtpPurpose.registration:
            return ApiResult.success(
              AuthenticationResult.requiresProfileCompletion(),
            );
          case OtpPurpose.passwordReset:
            return ApiResult.success(
              AuthenticationResult.requiresResetPassword(),
            );
        }
      },
    );
  }

  @override
  Future<ApiResult<bool>> resendOTP({bool isRegister = false}) async {
    return _handleApiCall(
      call: () => remoteDataSource.resendOtp(isRegister: isRegister),
    );
  }

  @override
  Future<ApiResult<bool>> resetPassword({
    required String newPassword,
    required String confirmPassword,
  }) async {
    return _handleApiCall(
      call:
          () => remoteDataSource.resetPassword(
            ResetPasswordDTO(
              newPassword: newPassword,
              confirmPassword: confirmPassword,
            ),
          ),
    );
  }

  @override
  Future<ApiResult<SessionModel>> completeProfile({
    required String firstName,
    required String lastName,
    required String password,
  }) async {
    return _handleApiCall<SessionModel, SessionModel>(
      call:
          () => remoteDataSource.completeProfile(
            CompleteProfileDTO(
              firstName: firstName,
              lastName: lastName,
              password: password,
            ),
          ),
      onSuccess: (session) async {
        await _appConfig.setUserSession(session);
        return ApiResult.success(session);
      },
    );
  }
}
