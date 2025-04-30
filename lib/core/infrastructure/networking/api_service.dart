import 'package:dio/dio.dart';
import 'package:snapnfix/core/infrastructure/networking/api_constants.dart';
import 'package:retrofit/retrofit.dart';
import 'package:snapnfix/core/infrastructure/networking/base_response.dart';
import 'package:snapnfix/modules/authentication/data/models/dtos/otp_verify_dto.dart';
import 'package:snapnfix/modules/authentication/data/models/dtos/register_dto.dart';
import 'package:snapnfix/modules/authentication/data/models/dtos/register_respone_dto.dart';
import 'package:snapnfix/modules/authentication/data/models/session_model.dart';
import 'package:snapnfix/modules/authentication/data/models/dtos/login_dto.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {required String baseUrl}) = _ApiService;

  @POST(ApiConstants.login)
  Future<BaseResponse<SessionModel>> login(@Body() LoginDTO loginDTO);

  @POST(ApiConstants.signUp)
  Future<BaseResponse<RegisterResponeDTO>> register(@Body() RegisterDTO registerDTO);


  @POST(ApiConstants.verifyOtp)
  Future<BaseResponse<bool>> verifyOtp(@Body() OTPVerifyDTO verifyDTO);
}
