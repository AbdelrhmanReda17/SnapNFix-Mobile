import 'package:flutter/material.dart';
import 'package:snapnfix/core/config/application_configurations.dart';
import 'package:snapnfix/core/infrastructure/networking/api_error_handler.dart';
import 'package:snapnfix/core/infrastructure/networking/api_error_model.dart';
import 'package:snapnfix/core/infrastructure/networking/api_result.dart';
import 'package:snapnfix/modules/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:snapnfix/modules/authentication/data/models/dtos/complete_profile_dto.dart';
import 'package:snapnfix/modules/authentication/data/models/dtos/login_dto.dart';
import 'package:snapnfix/modules/authentication/data/models/dtos/reset_password_dto.dart';
import 'package:snapnfix/modules/authentication/data/models/session_model.dart';
import 'package:snapnfix/modules/authentication/data/services/social_authentication_service.dart';
import 'package:snapnfix/modules/authentication/domain/entities/authentication_result.dart';
import 'package:snapnfix/modules/authentication/domain/providers/social_authentication_provider.dart';
import '../../domain/repositories/base_authentication_repository.dart';

class AuthenticationRepository implements BaseAuthenticationRepository {
  final BaseAuthenticationRemoteDataSource remoteDataSource;
  final ApplicationConfigurations _appConfig;
  final SocialAuthenticationService _socialAuthService;

  AuthenticationRepository(
    this.remoteDataSource,
    this._appConfig,
    this._socialAuthService,
  );

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
    required OtpPurpose purpose,
  }) async {
    return _handleApiCall<String, AuthenticationResult>(
      call: () => remoteDataSource.requestOTP(phoneNumber, purpose),
      onSuccess: (verificationToken) async {
        return ApiResult.success(
          AuthenticationResult.requiresOtp(purpose: purpose),
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
      call: () => remoteDataSource.verifyOtp(code, purpose),
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
  Future<ApiResult<bool>> resendOTP({required OtpPurpose purpose}) async {
    return _handleApiCall(call: () => remoteDataSource.resendOtp(purpose));
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

  @override
  Future<ApiResult<AuthenticationResult>> loginWithFacebook() async {
    final socialResult = await _socialAuthService.signIn(
      SocialAuthenticationProvider.facebook,
    );

    return socialResult.when(
      success: (accessToken) {
        return remoteDataSource
            .loginWithFacebook(accessToken)
            .then(_mapToAuthenticationResult);
      },
      cancelled: () {
        return ApiResult.failure(
          ApiErrorModel(message: 'Authentication was cancelled'),
        );
      },
      failure: (errorMessage) {
        debugPrint('Facebook login error: $errorMessage');
        return ApiResult.failure(ApiErrorModel(message: errorMessage));
      },
    );
  }

  @override
  Future<ApiResult<AuthenticationResult>> loginWithGoogle() async {
    final socialResult = await _socialAuthService.signIn(
      SocialAuthenticationProvider.google,
    );
    return socialResult.when(
      success: (accessToken) {
        debugPrint('Google access token: $accessToken');
        return remoteDataSource
            .loginWithGoogle(accessToken)
            .then(_mapToAuthenticationResult);
      },
      cancelled: () {
        return ApiResult.failure(
          ApiErrorModel(message: 'Authentication was cancelled'),
        );
      },
      failure: (errorMessage) {
        return ApiResult.failure(ApiErrorModel(message: errorMessage));
      },
    );
  }

  ApiResult<AuthenticationResult> _mapToAuthenticationResult(
    ApiResult<SessionModel> result,
  ) {
    return result.when(
      success:
          (sessionModel) => ApiResult.success(
            AuthenticationResult.authenticated(sessionModel),
          ),
      failure: (error) => ApiResult.failure(error),
    );
  }
}
