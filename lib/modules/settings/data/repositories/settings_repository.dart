import 'package:snapnfix/core/infrastructure/networking/error/api_error.dart';
import 'package:snapnfix/core/utils/result.dart';
import 'package:snapnfix/modules/settings/data/datasources/settings_remote_data_source.dart';
import 'package:snapnfix/modules/settings/data/models/change_password_request.dart';
import 'package:snapnfix/modules/settings/data/models/edit_profile_request.dart';
import 'package:snapnfix/modules/settings/domain/repositories/base_settings_repository.dart';

class SettingsRepository implements BaseSettingsRepository {
  final BaseSettingsRemoteDataSource _remoteDataSource;

  SettingsRepository(this._remoteDataSource);

  @override
  Future<Result<String, ApiError>> changePassword(
    ChangePasswordRequest changePasswordDTO,
  ) {
    return _remoteDataSource.changePassword(changePasswordDTO);
  }

  @override
  Future<Result<String, ApiError>> editProfile(
    EditProfileRequest editProfileDTO,
  ) {
    return _remoteDataSource.editProfile(editProfileDTO);
  }
}
