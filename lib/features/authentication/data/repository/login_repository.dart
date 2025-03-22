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
          id: " ",
          password: " ",
          phoneNumber: ' ',
          name: ' ',
          token: ' ',
        ),
      );
    } catch (error) {
      return ApiResult.failure(
        error: ApiErrorHandler(error).apiErrorModel.message,
      );
    }
  }
}
