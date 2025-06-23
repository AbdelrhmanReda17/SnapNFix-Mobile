import 'package:dio/dio.dart';
import 'package:snapnfix/core/infrastructure/device_info/device_info_service.dart';
import 'package:snapnfix/core/infrastructure/networking/error/api_error.dart';
import 'package:snapnfix/core/utils/result.dart';
import 'package:snapnfix/core/infrastructure/networking/api_service.dart';
import 'package:snapnfix/core/infrastructure/networking/responses/api_response.dart';
import 'package:snapnfix/core/infrastructure/networking/http_client_factory.dart';
import 'package:snapnfix/modules/authentication/data/models/index.dart';
import 'package:snapnfix/modules/authentication/domain/entities/authentication_result.dart';
import 'package:flutter/material.dart';

abstract class BaseAuthenticationRemoteDataSource {
  // Login and Register
  Future<Result<SessionModel, ApiError>> login({
    required String emailOrPhoneNumber,
    required String password,
  });
  Future<Result<String, ApiError>> requestOTP(
    String emailOrPhoneNumber,
    OtpPurpose purpose,
  );
  // OTP Verification
  Future<Result<String, ApiError>> verifyOtp(String otp, OtpPurpose purpose);
  Future<Result<bool, ApiError>> resendOtp(OtpPurpose purpose);

  // Password Reset and Forgot Password
  Future<Result<bool, ApiError>> resetPassword({
    required String newPassword,
    required String confirmPassword,
  });

  // Profile Completion
  Future<Result<SessionModel, ApiError>> register({
    required String firstName,
    required String lastName,
    required String password,
  });

  // Third Party Login
  Future<Result<SessionModel, ApiError>> loginWithGoogle(String accessToken);
  Future<Result<SessionModel, ApiError>> loginWithFacebook(String accessToken);

  Future<Result<void, ApiError>> logout();
}

class AuthenticationRemoteDataSource
    implements BaseAuthenticationRemoteDataSource {
  final ApiService _apiService;
  final DeviceInfoService _deviceInfoService;

  AuthenticationRemoteDataSource(this._apiService, this._deviceInfoService);

  Future<Result<T, ApiError>> _handleApiCall<T>({
    required Future<ApiResponse<T>> Function() apiCall,
    bool setVerificationToken = false,
    bool requiresSuccess = false,
    bool removeVerificationToken = false,
    bool isLoginOrRegister = false,
  }) async {
    try {
      final response = await apiCall();

      if (setVerificationToken && response.data is String) {
        HttpClientFactory.setAuthToken(response.data as String);
      }

      if (requiresSuccess && response.data is bool && response.data == false) {
        return Result.failure(ApiError(message: response.message));
      }

      if (removeVerificationToken && !setVerificationToken) {
        HttpClientFactory.clearAuthToken();
      }

      if (isLoginOrRegister && response.data is SessionModel) {
        HttpClientFactory.setAuthToken(
          (response.data as SessionModel).tokens.accessToken,
        );
      }

      return Result.success(response.data as T);
    } catch (error) {
      return Result.failure(
        error is DioException && error.error is ApiError
            ? error.error as ApiError
            : ApiError(message: 'An unexpected error occurred'),
      );
    }
  }

  @override
  Future<Result<SessionModel, ApiError>> login({
    required String emailOrPhoneNumber,
    required String password,
  }) async {
    final loginRequest = LoginRequest.withDeviceInfo(
      emailOrPhoneNumber: emailOrPhoneNumber,
      password: password,
      deviceId: _deviceInfoService.deviceId,
      deviceType: _deviceInfoService.deviceType,
      deviceName: _deviceInfoService.deviceName,
      platform: _deviceInfoService.platform,
      fcmToken: _deviceInfoService.fcmToken,
    );
    return _handleApiCall(
      apiCall: () => _apiService.login(loginRequest),
      isLoginOrRegister: true,
    );
  }

  @override
  Future<Result<String, ApiError>> requestOTP(
    String phoneNumber,
    OtpPurpose purpose,
  ) async {
    return _handleApiCall(
      apiCall:
          () =>
              purpose == OtpPurpose.registration
                  ? _apiService.requestOtp(OtpRequest(phoneNumber: phoneNumber))
                  : _apiService.requestPasswordReset(
                    PasswordResetRequest(emailOrPhoneNumber: phoneNumber),
                  ),
      setVerificationToken: true,
    );
  }

  @override
  Future<Result<String, ApiError>> verifyOtp(String otp, OtpPurpose purpose) {
    return _handleApiCall(
      apiCall:
          () =>
              purpose == OtpPurpose.registration
                  ? _apiService.verifyOtp(VerifyOtpRequest(otp: otp))
                  : _apiService.verifyPasswordResetOtp(
                    VerifyOtpRequest(otp: otp),
                  ),
      setVerificationToken: true,
    );
  }

  @override
  Future<Result<bool, ApiError>> resendOtp(OtpPurpose purpose) {
    return _handleApiCall(
      apiCall: () => _apiService.resendOtp(ResendOtpRequest()),
      requiresSuccess: true,
    );
  }

  @override
  Future<Result<bool, ApiError>> resetPassword({
    required String newPassword,
    required String confirmPassword,
  }) {
    return _handleApiCall(
      apiCall:
          () => _apiService.resetPassword(
            ResetPasswordRequest(
              newPassword: newPassword,
              confirmPassword: confirmPassword,
            ),
          ),
      requiresSuccess: true,
    );
  }

  @override
  Future<Result<SessionModel, ApiError>> register({
    required String firstName,
    required String lastName,
    required String password,
  }) async {
    final registerRequest = RegisterRequest.withDeviceInfo(
      firstName: firstName,
      lastName: lastName,
      password: password,
      deviceId: _deviceInfoService.deviceId,
      deviceType: _deviceInfoService.deviceType,
      deviceName: _deviceInfoService.deviceName,
      platform: _deviceInfoService.platform,
      fcmToken: _deviceInfoService.fcmToken,
    );
    return _handleApiCall(
      apiCall: () => _apiService.register(registerRequest),
      isLoginOrRegister: true,
    );
  }

  @override
  Future<Result<SessionModel, ApiError>> loginWithFacebook(
    String idToken,
  ) async {
    final loginWithFacebookRequest = FacebookLoginRequest.withDeviceInfo(
      idToken: idToken,
      deviceId: _deviceInfoService.deviceId,
      deviceType: _deviceInfoService.deviceType,
      deviceName: _deviceInfoService.deviceName,
      platform: _deviceInfoService.platform,
      fcmToken: _deviceInfoService.fcmToken,
    );
    return await _handleApiCall(
      apiCall: () => _apiService.loginWithFacebook(loginWithFacebookRequest),
    );
  }

  @override
  Future<Result<SessionModel, ApiError>> loginWithGoogle(
    String accessToken,
  ) async {
    final loginWithGoogleRequest = GoogleLoginRequest.withDeviceInfo(
      idToken: accessToken,
      deviceId: _deviceInfoService.deviceId,
      deviceType: _deviceInfoService.deviceType,
      deviceName: _deviceInfoService.deviceName,
      platform: _deviceInfoService.platform,
      fcmToken: _deviceInfoService.fcmToken,
    );
    return await _handleApiCall(
      apiCall: () => _apiService.loginWithGoogle(loginWithGoogleRequest),
    );
  }

  @override
  Future<Result<void, ApiError>> logout() {
    return _handleApiCall(
      apiCall: () => _apiService.logout(),
      requiresSuccess: true,
      removeVerificationToken: true,
    );
  }
}
