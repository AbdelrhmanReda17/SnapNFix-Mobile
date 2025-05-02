import 'package:flutter/material.dart';
import 'package:snapnfix/core/exceptions/unverified_user_exception.dart';
import 'package:snapnfix/core/infrastructure/device_info/device_info_service.dart';
import 'package:snapnfix/core/infrastructure/networking/api_error_handler.dart';
import 'package:snapnfix/core/infrastructure/networking/api_error_model.dart';
import 'package:snapnfix/core/infrastructure/networking/api_result.dart';
import 'package:snapnfix/core/infrastructure/networking/api_service.dart';
import 'package:snapnfix/core/infrastructure/networking/base_response.dart';
import 'package:snapnfix/core/infrastructure/networking/dio_factory.dart';
import 'package:snapnfix/modules/authentication/data/models/dtos/complete_profile_dto.dart';
import 'package:snapnfix/modules/authentication/data/models/dtos/login_dto.dart';
import 'package:snapnfix/modules/authentication/data/models/dtos/reset_password_dto.dart';
import 'package:snapnfix/modules/authentication/data/models/session_model.dart';

abstract class BaseAuthenticationRemoteDataSource {
  // Login and Register
  Future<ApiResult<SessionModel>> login(LoginDTO loginDTO);
  Future<ApiResult<String>> requestOTP(
    String emailOrPhoneNumber, {
    bool isRegister = false,
  });

  // OTP Verification
  Future<ApiResult<String>> verifyOtp(String otp, {bool isRegister = false});
  Future<ApiResult<bool>> resendOtp({bool isRegister = false});

  // Password Reset and Forgot Password
  Future<ApiResult<bool>> resetPassword(ResetPasswordDTO resetPasswordDTO);

  // Profile Completion
  Future<ApiResult<SessionModel>> completeProfile(
    CompleteProfileDTO completeProfileDTO,
  );
}

class AuthenticationRemoteDataSource
    implements BaseAuthenticationRemoteDataSource {
  final ApiService _apiService;
  final DeviceInfoService _deviceInfoService;

  AuthenticationRemoteDataSource(this._apiService, this._deviceInfoService);

  Future<ApiResult<T>> _handleApiCall<T>({
    required Future<BaseResponse<T>> Function() apiCall,
    bool setVerificationToken = false,
    bool requiresSuccess = false,
  }) async {
    try {
      final response = await apiCall();

      if (setVerificationToken && response.data is String) {
        DioFactory.setVerificationTokenHeader(response.data as String);
      }

      if (requiresSuccess && response.data is bool && response.data == false) {
        return ApiResult.failure(ApiErrorModel(message: response.message));
      }

      return ApiResult.success(response.data);
    } catch (error) {
      debugPrint('Error in AuthenticationRemoteDataSource: $error');
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<SessionModel>> login(LoginDTO loginDTO) async {
    try {
      final deviceInfo = await _deviceInfoService.getDeviceInfo();
      final updatedDTO = LoginDTO.withDeviceInfo(
        emailOrPhoneNumber: loginDTO.emailOrPhoneNumber,
        password: loginDTO.password,
        deviceId: deviceInfo['deviceId']!,
        deviceName: deviceInfo['deviceName']!,
        deviceType: deviceInfo['deviceType']!,
        platform: deviceInfo['platform']!,
      );

      return _handleApiCall(apiCall: () => _apiService.login(updatedDTO));
    } catch (error) {
      if (ApiErrorHandler.isAuthenticationError(error)) {
        throw UnverifiedUserException(phoneNumber: loginDTO.emailOrPhoneNumber);
      }
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<String>> requestOTP(
    String phoneNumber, {
    bool isRegister = false,
  }) async {
    debugPrint('Requesting OTP for phone number: $phoneNumber');
    return _handleApiCall(
      apiCall:
          () =>
              isRegister
                  ? _apiService.requestOTP({'phoneNumber': phoneNumber})
                  : _apiService.forgotPassword({
                    'emailOrPhoneNumber': phoneNumber,
                  }),
      setVerificationToken: true,
    );
  }

  @override
  Future<ApiResult<String>> verifyOtp(String otp, {bool isRegister = false}) {
    return _handleApiCall(
      apiCall:
          () =>
              isRegister
                  ? _apiService.verifyOtp({'otp': otp})
                  : _apiService.verifyForgotPasswordOtp({'otp': otp}),
      setVerificationToken: true,
    );
  }

  @override
  Future<ApiResult<bool>> resendOtp({bool isRegister = false}) {
    return _handleApiCall(
      apiCall:
          () =>
              isRegister
                  ? _apiService.resendOtp({})
                  : _apiService.verifyForgotPasswordOtpResend({}),
      requiresSuccess: true,
    );
  }

  @override
  Future<ApiResult<bool>> resetPassword(ResetPasswordDTO resetPasswordDTO) {
    return _handleApiCall(
      apiCall: () => _apiService.resetPassword(resetPasswordDTO),
      requiresSuccess: true,
    );
  }

  @override
  Future<ApiResult<SessionModel>> completeProfile(
    CompleteProfileDTO completeProfileDTO,
  ) async {
    final deviceInfo = await _deviceInfoService.getDeviceInfo();
    final updatedDTO = CompleteProfileDTO.withDeviceInfo(
      firstName: completeProfileDTO.firstName,
      lastName: completeProfileDTO.lastName,
      password: completeProfileDTO.password,
      deviceId: deviceInfo['deviceId']!,
      deviceName: deviceInfo['deviceName']!,
      deviceType: deviceInfo['deviceType']!,
      platform: deviceInfo['platform']!,
    );
    return _handleApiCall(
      apiCall: () => _apiService.completeProfile(updatedDTO),
    );
  }
}
