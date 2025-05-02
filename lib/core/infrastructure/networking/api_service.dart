import 'package:dio/dio.dart';
import 'package:snapnfix/core/infrastructure/networking/api_constants.dart';
import 'package:retrofit/retrofit.dart';
import 'package:snapnfix/core/infrastructure/networking/base_response.dart';
import 'package:snapnfix/modules/authentication/data/models/dtos/complete_profile_dto.dart';
import 'package:snapnfix/modules/authentication/data/models/dtos/reset_password_dto.dart';
import 'package:snapnfix/modules/authentication/data/models/session_model.dart';
import 'package:snapnfix/modules/authentication/data/models/dtos/login_dto.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {required String baseUrl}) = _ApiService;

  @POST(ApiConstants.login)
  Future<BaseResponse<SessionModel>> login(@Body() LoginDTO loginDTO);

  @POST(ApiConstants.requestOTP)
  Future<BaseResponse<String>> requestOTP(
    @Body() Map<String, dynamic> requestDTO,
  );

  @POST(ApiConstants.verifyOtp)
  Future<BaseResponse<String>> verifyOtp(
    @Body() Map<String, dynamic> verifyDTO,
  );

  @POST(ApiConstants.verifyForgotPasswordOtpResend)
  Future<BaseResponse<bool>> verifyForgotPasswordOtpResend(
    @Body() Map<String, dynamic> verifyDTO,
  );

  @POST(ApiConstants.resendOtp)
  Future<BaseResponse<bool>> resendOtp(@Body() Map<String, dynamic> xx);

  @POST(ApiConstants.forgotPassword)
  Future<BaseResponse<String>> forgotPassword(
    @Body() Map<String, dynamic> forgotPasswordDTO,
  );

  @POST(ApiConstants.resetPassword)
  Future<BaseResponse<bool>> resetPassword(
    @Body() ResetPasswordDTO resetPasswordDTO,
  );

  @POST(ApiConstants.completeProfile)
  Future<BaseResponse<SessionModel>> completeProfile(
    @Body() CompleteProfileDTO completeProfileDTO,
  );

  @POST(ApiConstants.verifyForgotPasswordOtp)
  Future<BaseResponse<String>> verifyForgotPasswordOtp(
    @Body() Map<String, dynamic> verifyDTO,
  );
}
