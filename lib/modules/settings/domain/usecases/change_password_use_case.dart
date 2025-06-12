import 'package:snapnfix/core/infrastructure/networking/error/api_error.dart';
import 'package:snapnfix/core/utils/result.dart';
import 'package:snapnfix/modules/settings/data/models/change_password_request.dart';
import 'package:snapnfix/modules/settings/domain/repositories/base_settings_repository.dart';

class ChangePasswordUseCase {
  final BaseSettingsRepository _repository;

  ChangePasswordUseCase(this._repository);

  Future<Result<String, ApiError>> call(
    ChangePasswordRequest changePasswordDTO,
  ) {
    return _repository.changePassword(changePasswordDTO);
  }
}
