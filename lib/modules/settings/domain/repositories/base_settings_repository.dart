import 'package:snapnfix/core/infrastructure/networking/error/api_error.dart';
import 'package:snapnfix/core/utils/result.dart';
import 'package:snapnfix/modules/settings/data/models/edit_profile_request.dart';

abstract class BaseSettingsRepository {
  Future<Result<bool, ApiError>> editProfile(
    EditProfileRequest editProfileDTO,
  );
}
