import 'package:flutter/widgets.dart';
import 'package:snapnfix/core/dependency_injection/dependency_injection.dart';
import 'package:snapnfix/core/exceptions/unverified_user_exception.dart';
import 'package:snapnfix/core/infrastructure/device_info/device_info_service.dart';
import 'package:snapnfix/core/infrastructure/networking/api_error_handler.dart';
import 'package:snapnfix/core/infrastructure/networking/api_error_model.dart';
import 'package:snapnfix/core/infrastructure/networking/api_result.dart';
import 'package:snapnfix/core/infrastructure/networking/api_service.dart';
import 'package:snapnfix/modules/authentication/data/models/dtos/login_dto.dart';
import 'package:snapnfix/modules/authentication/data/models/dtos/otp_verify_dto.dart';
import 'package:snapnfix/modules/authentication/data/models/dtos/register_dto.dart';
import 'package:snapnfix/modules/authentication/data/models/session_model.dart';
import 'package:snapnfix/modules/authentication/data/models/tokens_model.dart';
import 'package:snapnfix/modules/authentication/data/models/user_model.dart';

abstract class BaseAuthenticationRemoteDataSource {
  Future<ApiResult<SessionModel>> login(LoginDTO loginDTO);
  Future<ApiResult<SessionModel>> register(RegisterDTO registerDTO);
  Future<ApiResult<bool>> verifyOtp(OTPVerifyDTO otpVerifyDTO);
  Future<ApiResult<void>> resendOtp();
  Future<ApiResult<SessionModel>> forgotPassword(String emailOrPhoneNumber);
  Future<ApiResult<bool>> resetPassword(
    String newPassword,
    String confirmPassword,
  );
}

class AuthenticationRemoteDataSource
    implements BaseAuthenticationRemoteDataSource {
  final ApiService _apiService;

  AuthenticationRemoteDataSource(this._apiService);

  @override
  Future<ApiResult<SessionModel>> login(LoginDTO loginDTO) async {
    try {
      final deviceInfo = await getIt<DeviceInfoService>().getDeviceInfo();
      final LoginDTO updatedDTO = LoginDTO.withDeviceInfo(
        emailOrPhoneNumber: loginDTO.emailOrPhoneNumber,
        password: loginDTO.password,
        deviceId: deviceInfo['deviceId']!,
        deviceName: deviceInfo['deviceName']!,
        deviceType: deviceInfo['deviceType']!,
        platform: deviceInfo['platform']!,
      );
      final response = await _apiService.login(updatedDTO);
      return ApiResult.success(response.data);
    } catch (error) {
      if (ApiErrorHandler.isAuthenticationError(error)) {
        throw UnverifiedUserException(phoneNumber: loginDTO.emailOrPhoneNumber);
      }
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<SessionModel>> register(RegisterDTO registerDTO) async {
    try {
      final response = await _apiService.register(registerDTO);
      return ApiResult.success(
        SessionModel.unverified(
          user: UserModel.unverified(
            phoneNumber: registerDTO.phoneNumber,
            id: response.data.userId,
          ),
          verificationToken: response.data.verificationToken,
        ),
      );
    } catch (error) {
      debugPrint(error.toString());
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<bool>> verifyOtp(OTPVerifyDTO otpVerifyDTO) async {
    try {
      final response = await _apiService.verifyOtp(otpVerifyDTO);
      if (response.data) {
        return ApiResult.success(response.data);
      } else {
        return ApiResult.failure(ApiErrorModel(message: response.message));
      }
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<void>> resendOtp() async {
    try {
      // Edit this
      // final response = await _apiService.post('/auth/resend-otp');
      // return ApiResult.success(OtpResendResponseModel.fromJson(response.data));

      // For testing, return mock data
      return ApiResult.success(null);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<SessionModel>> forgotPassword(
    String emailOrPhoneNumber,
  ) async {
    try {
      // Edit this
      // final response = await _apiService.post(
      //   '/auth/forget-password',
      //   data: {
      //     'emailOrPhoneNumber': emailOrPhoneNumber,
      //   },
      // );
      // return ApiResult.success(response.data);
      return ApiResult.success(
        SessionModel.unverified(
          user: UserModel(id: "1", phoneNumber: emailOrPhoneNumber),
          verificationToken: "TEST_OTP_VERIFICATION_TOKEN",
        ),
      );
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<bool>> resetPassword(
    String newPassword,
    String confirmPassword,
  ) async {
    try {
      // Edit this
      // final response = await _apiService.post(
      //   '/auth/reset-password',
      //   data: {
      //     'newPassword': newPassword,
      //     'confirmPassword': confirmPassword,
      //   },
      // );
      // return ApiResult.success(response.data);

      return ApiResult.success(true);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
