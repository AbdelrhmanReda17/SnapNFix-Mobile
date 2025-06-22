import 'package:snapnfix/core/config/application_configurations.dart';
import 'package:snapnfix/core/infrastructure/networking/error/api_error.dart';
import 'package:snapnfix/core/utils/result.dart';
import 'package:snapnfix/modules/authentication/data/models/user_model.dart';
import 'package:snapnfix/modules/authentication/domain/entities/user_gender.dart';
import 'package:snapnfix/modules/settings/data/datasources/settings_remote_data_source.dart';
import 'package:snapnfix/modules/settings/data/models/edit_profile_request.dart';
import 'package:snapnfix/modules/settings/domain/repositories/base_settings_repository.dart';

class SettingsRepository implements BaseSettingsRepository {
  final BaseSettingsRemoteDataSource _remoteDataSource;
  final ApplicationConfigurations _appConfig;

  SettingsRepository(this._remoteDataSource, this._appConfig);

  @override
  Future<Result<bool, ApiError>> editProfile(
    EditProfileRequest editProfileDTO,
  ) async {
    final result = await _remoteDataSource.editProfile(editProfileDTO);

    return result.when(
      success: (isEdited) async {
        if (isEdited) {
          final currentUser = _appConfig.currentSession!.user;

          final updatedUser = UserModel(
            id: currentUser.id,
            firstName: editProfileDTO.firstName ?? currentUser.firstName,
            lastName: editProfileDTO.lastName ?? currentUser.lastName,
            email: currentUser.email,
            phoneNumber: currentUser.phoneNumber,
            gender: editProfileDTO.gender,
            birthDate:
                editProfileDTO.birthDate != null
                    ? DateTime.parse(editProfileDTO.birthDate!)
                    : currentUser.birthDate,
            profileImage:
                editProfileDTO.profileImage?.path ?? currentUser.profileImage,
          );

          await _appConfig.updateSessionUser(updatedUser);
        }
        return Result.success(isEdited);
      },
      failure: (error) => Result.failure(error),
    );
  }
}
