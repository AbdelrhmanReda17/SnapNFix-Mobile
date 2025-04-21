import 'package:snapnfix/core/infrastructure/networking/api_result.dart';
import 'package:snapnfix/modules/settings/data/models/dtos/edit_profile_dto.dart';
import 'package:snapnfix/modules/settings/domain/repositories/base_settings_repository.dart';

class EditProfileUseCase {
  final BaseSettingsRepository _repository;

  EditProfileUseCase(this._repository);

  Future<ApiResult<String>> call(EditProfileDTO editProfileDTO) {
    return _repository.editProfile(editProfileDTO);
  }
}
