import 'package:snapnfix/core/infrastructure/networking/api_error_handler.dart';
import 'package:snapnfix/core/infrastructure/networking/api_result.dart';
import 'package:snapnfix/core/infrastructure/networking/api_service.dart';
import 'package:snapnfix/modules/settings/data/models/change_password_dto.dart';
class ChangePasswordRepository {
  final ApiService _apiService;
  ChangePasswordRepository(this._apiService);
  Future<ApiResult<String>> changePassword(
    ChangePasswordDTO changePasswordDTO,
  ) async {
    try {
      // final response = await _apiService.changePassword(loginDTO);
      return ApiResult.success( "Password changed successfully");
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
