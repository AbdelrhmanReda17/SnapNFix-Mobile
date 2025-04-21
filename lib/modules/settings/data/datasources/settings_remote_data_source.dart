import 'package:snapnfix/core/infrastructure/networking/api_error_handler.dart';
import 'package:snapnfix/core/infrastructure/networking/api_result.dart';
import 'package:snapnfix/core/infrastructure/networking/api_service.dart';
import 'package:snapnfix/modules/settings/data/models/dtos/change_password_dto.dart';
import 'package:snapnfix/modules/settings/data/models/dtos/edit_profile_dto.dart';

abstract class BaseSettingsRemoteDataSource {
  Future<ApiResult<String>> changePassword(ChangePasswordDTO changePasswordDTO);
  Future<ApiResult<String>> editProfile(EditProfileDTO editProfileDTO);
}

class SettingsRemoteDataSource implements BaseSettingsRemoteDataSource {
  final ApiService _apiService;

  SettingsRemoteDataSource(this._apiService);

  @override
  Future<ApiResult<String>> changePassword(ChangePasswordDTO changePasswordDTO) async {
    try {
      // final response = await _apiService.changePassword(loginDTO);
      return ApiResult.success('Password changed successfully');
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }


  @override
  Future<ApiResult<String>> editProfile(EditProfileDTO editProfileDTO) async {
    try {
      // final response = await _apiService.ChangeProfile(changeProfileDTO);
      return ApiResult.success('Profile updated successfully');
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}