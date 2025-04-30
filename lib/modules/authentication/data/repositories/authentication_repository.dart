import 'package:flutter/widgets.dart';
import 'package:snapnfix/core/config/application_configurations.dart';
import 'package:snapnfix/core/dependency_injection/dependency_injection.dart';
import 'package:snapnfix/core/exceptions/unverified_user_exception.dart';
import 'package:snapnfix/core/infrastructure/networking/api_error_handler.dart';
import 'package:snapnfix/core/infrastructure/networking/api_result.dart';
import 'package:snapnfix/modules/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:snapnfix/modules/authentication/data/models/dtos/login_dto.dart';
import 'package:snapnfix/modules/authentication/data/models/dtos/otp_verify_dto.dart';
import 'package:snapnfix/modules/authentication/data/models/dtos/register_dto.dart';
import 'package:snapnfix/modules/authentication/data/models/session_model.dart';
import 'package:snapnfix/modules/authentication/data/models/user_model.dart';
import 'package:snapnfix/modules/authentication/domain/entities/authentication_result.dart';
import 'package:snapnfix/modules/authentication/domain/entities/session.dart';
import '../../domain/repositories/base_authentication_repository.dart';

class AuthenticationRepository implements BaseAuthenticationRepository {
  final BaseAuthenticationRemoteDataSource remoteDataSource;
  AuthenticationRepository(this.remoteDataSource);

  @override
  Future<ApiResult<AuthenticationResult>> login({
    required String phoneOrEmail,
    required String password,
  }) async {
    try {
      final result = await remoteDataSource.login(
        LoginDTO(emailOrPhoneNumber: phoneOrEmail, password: password),
      );
      return result.when(
        success: (session) async {
          await getIt<ApplicationConfigurations>().setUserSession(session);
          return ApiResult.success(AuthenticationResult.authenticated(session));
        },
        failure: (error) => ApiResult.failure(error),
      );
    } on UnverifiedUserException catch (e) {
      return ApiResult.success(
        AuthenticationResult.unverified(phoneNumber: e.phoneNumber),
      );
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  @override
  Future<void> logout() async {
    try {
      await getIt<ApplicationConfigurations>().logout();
    } catch (e) {
      throw Exception('Failed to logout: ${e.toString()}');
    }
  }

  @override
  Future<ApiResult<AuthenticationResult>> register({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final result = await remoteDataSource.register(
        RegisterDTO(
          firstName: firstName,
          lastName: lastName,
          phoneNumber: phoneNumber,
          password: password,
          confirmPassword: confirmPassword,
        ),
      );

      return result.when(
        success: (responeDTO) async {
          return ApiResult.success(
            AuthenticationResult.requiresOtp(
              phoneNumber: phoneNumber,
              verificationToken: responeDTO.verificationToken!,
              purpose: OtpPurpose.registration,
            ),
          );
        },
        failure: (error) {
          return ApiResult.failure(error);
        },
      );
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<bool>> verifyOtp({
    required String code,
    required String verificationToken,
    required String phoneNumber,
  }) async {
    try {
      final result = await remoteDataSource.verifyOtp(
        OTPVerifyDTO(
          otp: code,
          verificationToken: verificationToken,
          phoneNumber: phoneNumber,
        ),
      );

      return result.when(
        success: (res) {
          return ApiResult.success(res);
        },
        failure: (error) {
          return ApiResult.failure(error);
        },
      );
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<void>> resendOtp() async {
    try {
      final result = await remoteDataSource.resendOtp();

      return result.when(
        success: (_) {
          return ApiResult.success(null);
        },
        failure: (error) {
          return ApiResult.failure(error);
        },
      );
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<AuthenticationResult>> forgotPassword({
    required String emailOrPhoneNumber,
  }) async {
    try {
      final result = await remoteDataSource.forgotPassword(emailOrPhoneNumber);

      return result.when(
        success: (response) {
          return ApiResult.success(
            AuthenticationResult.requiresOtp(
              phoneNumber: emailOrPhoneNumber,
              verificationToken: response.verificationToken!,
              purpose: OtpPurpose.passwordReset,
            ),
          );
        },
        failure: (error) => ApiResult.failure(error),
      );
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<bool>> resetPassword({
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      final result = await remoteDataSource.resetPassword(
        newPassword,
        confirmPassword,
      );

      return result.when(
        success: (result) async {
          return ApiResult.success(result);
        },
        failure: (error) {
          return ApiResult.failure(error);
        },
      );
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
}
