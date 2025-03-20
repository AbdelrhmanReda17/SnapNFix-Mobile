import 'dart:developer';

import 'package:snapnfix/core/networking/api_error_handler.dart';
import 'package:snapnfix/core/networking/api_result.dart';
import 'package:snapnfix/core/networking/api_service.dart';
import 'package:snapnfix/features/login/data/models/login_dto.dart';
import 'package:snapnfix/features/login/data/models/login_response.dart';

class LoginRepository {
  final ApiService _apiService;

  LoginRepository(this._apiService);

  Future<ApiResult<LoginResponse>> login(LoginDTO loginDTO) async {
    try {
      // final response = await _apiService.login(loginDTO);
      return ApiResult.success(data: LoginResponse());
    } catch (error) {
      return ApiResult.failure(
        error: ApiErrorHandler(error).apiErrorModel.message,
      );
    }
  }
}
