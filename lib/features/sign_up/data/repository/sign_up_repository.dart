import 'package:snapnfix/core/networking/api_service.dart';
import 'package:snapnfix/features/sign_up/data/models/sign_up_dto.dart';
import 'package:snapnfix/features/sign_up/data/models/sign_up_response.dart';
import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';

class SignUpRepository{
  final ApiService _apiService;

  SignUpRepository(this._apiService);

  Future<ApiResult<SignUpResponse>> signup(SignUpDTO signUpDTO) async {
    try {
      // final response = await _apiService.signup(signUpDTO);
      return ApiResult.success(data: SignUpResponse());
    } catch (error) {
      return ApiResult.failure(
        error: ApiErrorHandler(error).apiErrorModel.message,
      );
    }
  }
}