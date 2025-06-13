import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:snapnfix/modules/issues/data/models/get_nearby_issues_query.dart';
import 'package:snapnfix/modules/issues/data/models/markers.dart';
import 'package:snapnfix/modules/reports/data/models/report_statistics_model.dart';
import '../../../index.dart';
part 'api_service.g.dart';

@RestApi(baseUrl: ApiEndpoints.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  // Authentication
  @POST(ApiEndpoints.login)
  Future<ApiResponse<SessionModel>> login(@Body() LoginRequest request);

  @POST(ApiEndpoints.register)
  Future<ApiResponse<SessionModel>> register(@Body() RegisterRequest request);

  @POST(ApiEndpoints.logout)
  Future<ApiResponse<void>> logout();

  @POST(ApiEndpoints.refreshToken)
  Future<ApiResponse<TokensModel>> refreshToken(
    @Body() Map<String, dynamic> request,
  );

  @PUT(ApiEndpoints.editProfile)
  Future<ApiResponse<bool>> editProfile(
    @Body() Map<String, dynamic> request,
  );

  // OTP operations
  @POST(ApiEndpoints.requestOtp)
  Future<ApiResponse<String>> requestOtp(@Body() OtpRequest request);

  @POST(ApiEndpoints.verifyOtp)
  Future<ApiResponse<String>> verifyOtp(@Body() VerifyOtpRequest request);

  @POST(ApiEndpoints.resendOtp)
  Future<ApiResponse<bool>> resendOtp(@Body() ResendOtpRequest request);

  // Password operations
  @POST(ApiEndpoints.forgotPassword)
  Future<ApiResponse<String>> requestPasswordReset(
    @Body() PasswordResetRequest request,
  );

  @POST(ApiEndpoints.verifyForgotPasswordOtp)
  Future<ApiResponse<String>> verifyPasswordResetOtp(
    @Body() VerifyOtpRequest request,
  );

  @POST(ApiEndpoints.resetPassword)
  Future<ApiResponse<bool>> resetPassword(@Body() ResetPasswordRequest request);

  // Social login
  @POST(ApiEndpoints.googleLogin)
  Future<ApiResponse<SessionModel>> loginWithGoogle(
    @Body() GoogleLoginRequest request,
  );

  @POST(ApiEndpoints.facebookLogin)
  Future<ApiResponse<SessionModel>> loginWithFacebook(
    @Body() FacebookLoginRequest request,
  );

  @POST(ApiEndpoints.createSnapReport)
  @MultiPart()
  Future<ApiResponse<ReportModel>> createSnapReport(
    @Part(name: "comment") String comment,
    @Part(name: "severity") String severity,
    @Part(name: "latitude") double latitude,
    @Part(name: "longitude") double longitude,
    @Part(name: "road") String road,
    @Part(name: "city") String city,
    @Part(name: "state") String state,
    @Part(name: "country") String country,
    @Part(name: "image") File image,
  );

  // @POST(ApiEndpoints.createFastReport)
  // Future<ApiResponse<ReportModel>> createFastReport(
  //   @Body() CreateFastReportRequest request,
  // );
  @GET(ApiEndpoints.userReports)
  Future<ApiResponse<PaginatedResponse<ReportModel>>> getUserReports(
    @Queries() GetReportsQuery query,
  );

  @GET(ApiEndpoints.reportStatistics)
  Future<ApiResponse<ReportStatisticsModel>> getReportStatistics();

  @GET(ApiEndpoints.getNearbyIssues)
  Future<ApiResponse<List<IssueMarker>>> getNearbyIssues(
    @Queries() GetNearbyIssuesQuery query,
  );

  @GET(ApiEndpoints.getIssueById)
  Future<ApiResponse<IssueModel>> getIssueById(@Path('id') String id);

  // @GET(ApiEndpoints.getUserIssues)
  // Future<ApiResponse<PaginatedData<IssueModel>>> getUserIssues(
  //   @Queries() GetUserIssuesQuery query,
  // );
}
