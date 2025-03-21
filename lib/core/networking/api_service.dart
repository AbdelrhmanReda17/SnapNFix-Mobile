import 'package:dio/dio.dart';
import 'package:snapnfix/core/networking/api_constants.dart';
import 'package:retrofit/retrofit.dart';
import 'package:snapnfix/features/authentication/data/models/login_dto.dart';
import 'package:snapnfix/features/authentication/data/models/sign_up_dto.dart';
import 'package:snapnfix/features/authentication/data/models/user.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {required String baseUrl}) = _ApiService;

  @POST(ApiConstants.login)
  Future<User> login(@Body() LoginDTO body);

  @POST(ApiConstants.signUp)
  Future<User> signup(@Body() SignUpDTO body);
}
