import 'package:snapnfix/core/networking/api_error_handler.dart';
import 'package:snapnfix/core/networking/api_result.dart';
import 'package:snapnfix/core/networking/api_service.dart';
import 'package:snapnfix/features/settings/data/models/change_password_dto.dart';

class ChangePasswordRepository {
  final ApiService _apiService;

  ChangePasswordRepository(this._apiService);

  Future<ApiResult<String>> changePassword(
    ChangePasswordDTO changePasswordDTO,
  ) async {
    try {
      // final response = await _apiService.changePassword(loginDTO);
      return ApiResult.success(data: "Password changed successfully");
    } catch (error) {
      return ApiResult.failure(
        error: ApiErrorHandler(error).apiErrorModel.message,
      );
    }
  }
}
