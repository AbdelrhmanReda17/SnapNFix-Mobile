import 'package:flutter/material.dart';
import 'package:snapnfix/core/infrastructure/networking/api_error_handler.dart';
import 'package:snapnfix/core/infrastructure/networking/api_result.dart';
import 'package:snapnfix/core/infrastructure/networking/api_service.dart';
import 'package:snapnfix/modules/authentication/data/models/session_model.dart';
import 'package:snapnfix/modules/authentication/data/models/tokens_model.dart';
import 'package:snapnfix/modules/authentication/data/models/user_model.dart';
import 'package:snapnfix/modules/authentication/domain/entities/user_gender.dart';

abstract class BaseAuthenticationRemoteDataSource {
  Future<ApiResult<SessionModel>> login(String emailOrPhone, String password);
  Future<ApiResult<SessionModel>> register(
    String phoneNumber,
    String password,
    String confirmPassword,
  );
  Future<ApiResult<SessionModel>> verifyOtp(String code);
  Future<ApiResult<void>> resendOtp();

  Future<ApiResult<SessionModel>> completeProfile({
    required String firstName,
    required String lastName,
    UserGender? gender,
    DateTime? dateOfBirth,
  });

  Future<ApiResult<void>> forgotPassword(String emailOrPhoneNumber);
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
  Future<ApiResult<SessionModel>> login(
    String emailOrPhoneNumber,
    String password,
  ) async {
    try {
      // final response = await _apiService.login(
      //   LoginDTO(emailOrPhoneNumber: emailOrPhoneNumber, password: password),
      // );
      // return ApiResult.success(response );
      return ApiResult.success(
        SessionModel(
          user: UserModel(
            id: "1",
            firstName: "Test",
            lastName: "User",
            phoneNumber: "123456789",
          ),
          tokens: TokensModel(
            accessToken: "TEST_ACCESS_TOKEN",
            refreshToken: "TEST_REFRESH_TOKEN",
            expiresIn: 3600,
            issuedAt: DateTime.now(),
          ),
        ),
      );
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<SessionModel>> register(
    String phoneNumber,
    String password,
    String confirmPassword,
  ) async {
    try {
      // final response = await _apiService.register(
      //   RegisterDTO(
      //     firstName: firstName,
      //     lastName: lastName,
      //     phoneNumber: phoneNumber,
      //     password: password,
      //     confirmPassword: confirmPassword,
      //   ),
      // );
      // return ApiResult.success(response);
      return ApiResult.success(
        SessionModel(
          user: UserModel.unverified(id: "1", phoneNumber: phoneNumber),
          tokens: TokensModel(
            accessToken: "TEST_ACCESS_TOKEN",
            refreshToken: "TEST_REFRESH_TOKEN",
            expiresIn: 3600,
            issuedAt: DateTime.now(),
          ),
        ),
      );
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<SessionModel>> verifyOtp(String code) async {
    try {
      // Edit this
      // final response = await _apiService.post(
      //   '/auth/verify-otp',
      //   data: {
      //     'code': code,
      //   },
      // );
      // return ApiResult.success(OtpVerificationResponseModel.fromJson(response.data));
      return ApiResult.success(
        SessionModel(
          user: UserModel(
            id: "1",
            phoneNumber: "123456789",
            isVerified: true,
            isProfileComplete: false,
          ),
          tokens: TokensModel(
            accessToken: "TEST_ACCESS_TOKEN",
            refreshToken: "TEST_REFRESH_TOKEN",
            expiresIn: 3600,
            issuedAt: DateTime.now(),
          ),
        ),
      );
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<SessionModel>> completeProfile({
    required String firstName,
    required String lastName,
    UserGender? gender,
    DateTime? dateOfBirth,
  }) async {
    try {
      // Real API call would look like this:
      // final response = await _apiService.post(
      //   '/auth/complete-profile',
      //   data: {
      //     'firstName': firstName,
      //     'lastName': lastName,
      //     'gender': gender?.name,
      //     'dateOfBirth': dateOfBirth?.toIso8601String(),
      //   },
      // );
      // return ApiResult.success(SessionModel.fromJson(response.data));
      debugPrint(
        "First Name: $firstName, Last Name: $lastName , gender: $gender, dateOfBirth: $dateOfBirth",
      );

      return ApiResult.success(
        SessionModel(
          user: UserModel(
            id: "1",
            firstName: firstName,
            lastName: lastName,
            phoneNumber: "123456789",
            gender: gender,
            dateOfBirth: dateOfBirth,
            isVerified: true,
            isProfileComplete: true,
          ),
          tokens: TokensModel(
            accessToken: "TEST_ACCESS_TOKEN",
            refreshToken: "TEST_REFRESH_TOKEN",
            expiresIn: 3600,
            issuedAt: DateTime.now(),
          ),
        ),
      );
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
  Future<ApiResult<void>> forgotPassword(String emailOrPhoneNumber) async {
    try {
      // Edit this
      // final response = await _apiService.post(
      //   '/auth/forget-password',
      //   data: {
      //     'emailOrPhoneNumber': emailOrPhoneNumber,
      //   },
      // );
      // return ApiResult.success(response.data);

      return ApiResult.success(null);
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
