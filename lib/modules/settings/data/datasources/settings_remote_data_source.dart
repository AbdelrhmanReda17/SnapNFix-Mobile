import 'package:snapnfix/core/infrastructure/networking/error/api_error.dart';
import 'package:snapnfix/core/utils/result.dart';
import 'package:snapnfix/core/infrastructure/networking/api_service.dart';
import 'package:snapnfix/modules/settings/data/models/change_password_request.dart';
import 'package:snapnfix/modules/settings/data/models/edit_profile_request.dart';

abstract class BaseSettingsRemoteDataSource {
  Future<Result<String, ApiError>> changePassword(
    ChangePasswordRequest changePasswordDTO,
  );
  Future<Result<String, ApiError>> editProfile(
    EditProfileRequest editProfileDTO,
  );
}

class SettingsRemoteDataSource implements BaseSettingsRemoteDataSource {
  final ApiService _apiService;

  SettingsRemoteDataSource(this._apiService);

  @override
  Future<Result<String, ApiError>> changePassword(
    ChangePasswordRequest changePasswordDTO,
  ) async {
    try {
      // final response = await _apiService.changePassword(loginDTO);
      return Result.success('Password changed successfully');
    } catch (error) {
      return Result.failure(
        ApiError(
          message: 'Failed to change password: ${error.toString()}',
          code: error is ApiError ? error.code : null,
        ),
      );
    }
  }

  @override
  Future<Result<String, ApiError>> editProfile(
    EditProfileRequest editProfileDTO,
  ) async {
    try {
      // final response = await _apiService.ChangeProfile(changeProfileDTO);
      return Result.success('Profile updated successfully');
    } catch (error) {
      return Result.failure(
        ApiError(
          message: 'Failed to change password: ${error.toString()}',
          code: error is ApiError ? error.code : null,
        ),
      );
    }
  }
}
