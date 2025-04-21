import 'package:snapnfix/core/infrastructure/networking/api_result.dart';
import 'package:snapnfix/modules/settings/data/models/dtos/change_password_dto.dart';
import 'package:snapnfix/modules/settings/domain/repositories/base_settings_repository.dart';

class ChangePasswordUseCase {
  final BaseSettingsRepository _repository;

  ChangePasswordUseCase(this._repository);

  Future<ApiResult<String>> call(ChangePasswordDTO changePasswordDTO) {
    return _repository.changePassword(changePasswordDTO);
  }
}
