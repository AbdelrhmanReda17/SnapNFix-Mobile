import 'package:snapnfix/core/networking/api_error_handler.dart';
import 'package:snapnfix/core/networking/api_result.dart';
import 'package:snapnfix/core/networking/api_service.dart';
import 'package:snapnfix/features/authentication/data/models/sign_up_dto.dart';
import 'package:snapnfix/features/authentication/data/models/user.dart';

class SignUpRepository {
  final ApiService _apiService;

  SignUpRepository(this._apiService);

  Future<ApiResult<User>> signUp(SignUpDTO signUpDTO) async {
    try {
      // final response = await _apiService.signUp(loginDTO);
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
