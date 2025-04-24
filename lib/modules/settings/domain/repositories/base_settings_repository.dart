import 'package:snapnfix/core/infrastructure/networking/api_result.dart';
import 'package:snapnfix/modules/settings/data/models/dtos/change_password_dto.dart';
import 'package:snapnfix/modules/settings/data/models/dtos/edit_profile_dto.dart';

abstract class BaseSettingsRepository {
  Future<ApiResult<String>> changePassword(ChangePasswordDTO changePasswordDTO);
  Future<ApiResult<String>> editProfile(EditProfileDTO editProfileDTO);
}
