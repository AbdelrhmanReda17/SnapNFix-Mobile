import 'package:snapnfix/core/infrastructure/networking/api_result.dart';
import 'package:snapnfix/modules/settings/data/datasources/settings_remote_data_source.dart';
import 'package:snapnfix/modules/settings/data/models/dtos/change_password_dto.dart';
import 'package:snapnfix/modules/settings/data/models/dtos/edit_profile_dto.dart';
import 'package:snapnfix/modules/settings/domain/repositories/base_settings_repository.dart';

class SettingsRepositoryImpl implements BaseSettingsRepository {
  final BaseSettingsRemoteDataSource _remoteDataSource;

  SettingsRepositoryImpl(this._remoteDataSource);

  @override
  Future<ApiResult<String>> changePassword(
    ChangePasswordDTO changePasswordDTO,
  ) {
    return _remoteDataSource.changePassword(changePasswordDTO);
  }

  @override
  Future<ApiResult<String>> editProfile(EditProfileDTO editProfileDTO) {
    return _remoteDataSource.editProfile(editProfileDTO);
  }
}
