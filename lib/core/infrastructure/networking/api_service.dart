import 'dart:io';

import 'package:dio/dio.dart';
import 'package:snapnfix/core/infrastructure/networking/api_constants.dart';
import 'package:retrofit/retrofit.dart';
import 'package:snapnfix/core/infrastructure/networking/base_response.dart';
import 'package:snapnfix/core/infrastructure/networking/paginated_response.dart';
import 'package:snapnfix/modules/authentication/data/models/dtos/reset_password_dto.dart';
import 'package:snapnfix/modules/authentication/data/models/session_model.dart';
import 'package:snapnfix/modules/authentication/data/models/tokens_model.dart';
import 'package:snapnfix/modules/reports/data/model/report_model.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {required String baseUrl}) = _ApiService;

  @POST(ApiConstants.login)
  Future<BaseResponse<SessionModel>> login(
    @Body() Map<String, dynamic> loginDTO,
  );

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
  Future<BaseResponse<bool>> resendOtp(@Body() Map<String, dynamic> body);

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
    @Body() Map<String, dynamic> completeProfileDTO,
  );

  @POST(ApiConstants.verifyForgotPasswordOtp)
  Future<BaseResponse<String>> verifyForgotPasswordOtp(
    @Body() Map<String, dynamic> verifyDTO,
  );

  @POST(ApiConstants.loginWithGoogle)
  Future<BaseResponse<SessionModel>> loginWithGoogle(
    @Body() Map<String, dynamic> googleLoginDTO,
  );

  @POST(ApiConstants.loginWithFacebook)
  Future<BaseResponse<SessionModel>> loginWithFacebook(
    @Body() Map<String, dynamic> facebookLoginDTO,
  );

  @POST(ApiConstants.logout)
  Future<BaseResponse<void>> logout();

  @POST(ApiConstants.createReport)
  @MultiPart()
  Future<BaseResponse<ReportModel>> createReport({
    @Part(name: 'Image') required File image,
    @Part(name: 'Latitude') required double latitude,
    @Part(name: 'Longitude') required double longitude,
    @Part(name: 'Severity') required String severity,
    @Part(name: 'Comment') required String comment,
  });

  @GET(ApiConstants.userReports)
  Future<BaseResponse<PaginatedResponse<ReportModel>>> getUserReports({
    @Query("Status") String? status,
    @Query("Category") String? category,
    @Query("PageNumber") required int page,
    @Query("PageSize") required int limit,
  });

  @POST(ApiConstants.refreshToken)
  Future<BaseResponse<TokensModel>> refreshToken(
    @Body() Map<String, dynamic> refreshTokenDTO,
  );
}
