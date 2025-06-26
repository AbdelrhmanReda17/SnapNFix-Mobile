import 'package:flutter/material.dart';
import 'package:snapnfix/core/config/application_configurations.dart';
import 'package:snapnfix/modules/authentication/domain/entities/authentication_result.dart';
import 'package:snapnfix/modules/authentication/domain/entities/session.dart';
import 'package:snapnfix/modules/authentication/domain/providers/social_authentication_provider.dart';
import 'package:snapnfix/modules/authentication/domain/repositories/base_authentication_repository.dart';
import 'package:snapnfix/modules/authentication/domain/services/base_social_authentication_service.dart';

import '../../../../core/infrastructure/networking/error/index.dart';
import '../../../../core/utils/index.dart';
import '../index.dart';

class AuthenticationRepository implements BaseAuthenticationRepository {
  final BaseAuthenticationRemoteDataSource remoteDataSource;
  final ApplicationConfigurations _appConfig;
  final BaseSocialAuthenticationService _socialAuthService;

  AuthenticationRepository(
    this.remoteDataSource,
    this._appConfig,
    this._socialAuthService,
  );
  @override
  Future<Result<AuthenticationResult, ApiError>> login({
    required String phoneOrEmail,
    required String password,
  }) async {
    final result = await remoteDataSource.login(
      emailOrPhoneNumber: phoneOrEmail,
      password: password,
    );

    return result.when(
      success: (session) async {
        await _appConfig.setUserSession(session);
        return Result.success(AuthenticationResult.authenticated(session));
      },
      failure: (error) => Result.failure(error),
    );
  }

  @override
  Future<Result<void, ApiError>> logout() async {
    final result = await remoteDataSource.logout();
    return result.when(
      success: (_) async {
        await _appConfig.logout();
        return Result.success(null);
      },
      failure: (error) => Result.failure(error),
    );
  }

  @override
  Future<Result<AuthenticationResult, ApiError>> requestOTP({
    required String phoneNumber,
    required OtpPurpose purpose,
  }) async {
    final result = await remoteDataSource.requestOTP(phoneNumber, purpose);

    return result.when(
      success:
          (verificationToken) => Result.success(
            AuthenticationResult.requiresOtp(purpose: purpose),
          ),
      failure: (error) => Result.failure(error),
    );
  }

  @override
  Future<Result<AuthenticationResult, ApiError>> verifyOTP({
    required String code,
    required OtpPurpose purpose,
  }) async {
    final result = await remoteDataSource.verifyOtp(code, purpose);

    return result.when(
      success: (res) {
        switch (purpose) {
          case OtpPurpose.registration:
            return Result.success(
              AuthenticationResult.requiresProfileCompletion(),
            );
          case OtpPurpose.passwordReset:
            return Result.success(AuthenticationResult.requiresResetPassword());
        }
      },
      failure: (error) => Result.failure(error),
    );
  }

  @override
  Future<Result<bool, ApiError>> resendOTP({
    required OtpPurpose purpose,
  }) async {
    final result = await remoteDataSource.resendOtp(purpose);

    return result.when(
      success: (success) => Result.success(success),
      failure: (error) => Result.failure(error),
    );
  }

  @override
  Future<Result<bool, ApiError>> resetPassword({
    required String newPassword,
    required String confirmPassword,
  }) async {
    final result = await remoteDataSource.resetPassword(
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );

    return result.when(
      success: (success) => Result.success(success),
      failure: (error) => Result.failure(error),
    );
  }

  @override
  Future<Result<Session, ApiError>> register({
    required String firstName,
    required String lastName,
    required String password,
  }) async {
    final result = await remoteDataSource.register(
      firstName: firstName,
      lastName: lastName,
      password: password,
    );

    return result.when(
      success: (sessionModel) async {
        await _appConfig.setUserSession(sessionModel);
        return Result.success(sessionModel);
      },
      failure: (error) => Result.failure(error),
    );
  }

  @override
  Future<Result<AuthenticationResult, ApiError>> loginWithFacebook() async {
    try {
      final socialResult = await _socialAuthService.signIn(
        SocialAuthenticationProvider.facebook,
      );

      return await socialResult.when(
        success: (accessToken) async {
          final result = await remoteDataSource.loginWithFacebook(accessToken);
          return _mapToAuthenticationResult(result);
        },
        cancelled: () async {
          return Result.failure(
            ApiError(
              message: 'Facebook authentication was cancelled',
              code: 'facebook_auth_cancelled',
              statusCode: 400,
            ),
          );
        },
        failure: (errorMessage) async {
          return Result.failure(
            ApiError(
              message: errorMessage,
              code: 'facebook_auth_failure',
              statusCode: 500,
            ),
          );
        },
      );
    } catch (e) {
      return Result.failure(
        ApiError(
          message: 'An error occurred during Facebook login: ${e.toString()}',
          code: 'facebook_auth_error',
          statusCode: 500,
        ),
      );
    }
  }

  @override
  Future<Result<AuthenticationResult, ApiError>> loginWithGoogle() async {
    try {
      final socialResult = await _socialAuthService.signIn(
        SocialAuthenticationProvider.google,
      );

      return await socialResult.when(
        success: (accessToken) async {
          final result = await remoteDataSource.loginWithGoogle(accessToken);
          return _mapToAuthenticationResult(result);
        },
        cancelled: () async {
          return Result.failure(
            ApiError(
              message: 'Google authentication was cancelled',
              code: 'google_auth_cancelled',
              statusCode: 400,
            ),
          );
        },
        failure: (errorMessage) async {
          return Result.failure(
            ApiError(
              message: errorMessage,
              code: 'google_auth_failure',
              statusCode: 500,
            ),
          );
        },
      );
    } catch (e) {
      return Result.failure(
        ApiError(
          message: 'An error occurred during Google login: ${e.toString()}',
          code: 'google_auth_error',
          statusCode: 500,
        ),
      );
    }
  }

  Result<AuthenticationResult, ApiError> _mapToAuthenticationResult(
    Result<SessionModel, ApiError> result,
  ) {
    return result.when(
      success: (sessionModel) {
        _appConfig.setUserSession(sessionModel);
        return Result.success(AuthenticationResult.authenticated(sessionModel));
      },
      failure: (error) => Result.failure(error),
    );
  }
}
