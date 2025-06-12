import 'package:snapnfix/core/infrastructure/networking/error/api_error.dart';
import 'package:snapnfix/core/utils/result.dart';
import 'package:snapnfix/modules/settings/data/models/edit_profile_request.dart';
import 'package:snapnfix/modules/settings/domain/repositories/base_settings_repository.dart';

class EditProfileUseCase {
  final BaseSettingsRepository _repository;

  EditProfileUseCase(this._repository);

  Future<Result<String, ApiError>> call(EditProfileRequest editProfileDTO) {
    return _repository.editProfile(editProfileDTO);
  }
}
