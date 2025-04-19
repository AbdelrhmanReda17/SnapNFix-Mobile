import 'package:snapnfix/core/networking/api_error_handler.dart';
import 'package:snapnfix/core/networking/api_result.dart';
import 'package:snapnfix/core/networking/api_service.dart';
import 'package:snapnfix/features/authentication/data/models/login_dto.dart';
import 'package:snapnfix/features/authentication/data/models/user.dart';

class LoginRepository {
  final ApiService _apiService;

  LoginRepository(this._apiService);

  Future<ApiResult<User>> login(LoginDTO loginDTO) async {
    try {
      // final response = await _apiService.login(loginDTO);
      return ApiResult.success(
        data: User(
          id: "a",
          name: 'John Doe',
          phoneNumber: ' aaa',
          password: '1234567890',
          token: "xd",
        ),
      );
    } catch (error) {
      print('Login error: $error');
      return ApiResult.failure(
        error: ApiErrorHandler(error).apiErrorModel.message,
      );
    }
  }
}
