import 'package:snapnfix/core/infrastructure/networking/api_error_handler.dart';
import 'package:snapnfix/core/infrastructure/networking/api_result.dart';
import 'package:snapnfix/core/infrastructure/networking/api_service.dart';
import 'package:snapnfix/modules/authentication/data/models/dtos/register_dto.dart';
import 'package:snapnfix/modules/authentication/data/models/session_model.dart';
import 'package:snapnfix/modules/authentication/data/models/tokens_model.dart';
import 'package:snapnfix/modules/authentication/data/models/user_model.dart';

abstract class BaseAuthenticationRemoteDataSource {
  Future<ApiResult<SessionModel>> login(String emailOrPhone, String password);
  Future<ApiResult<SessionModel>> register(
    String firstName,
    String lastName,
    String phoneNumber,
    String password,
    String confirmPassword,
  );
  Future<ApiResult<SessionModel>> verifyOtp(String code);
  Future<ApiResult<void>> resendOtp();
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
    String firstName,
    String lastName,
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
          user: UserModel(
            id: "1",
            firstName: firstName,
            lastName: lastName,
            phoneNumber: phoneNumber,
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
}
