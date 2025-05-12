import 'package:injectable/injectable.dart';
import 'package:snapnfix/modules/settings/domain/repositories/base_settings_repository.dart';
import 'package:snapnfix/modules/settings/domain/usecases/change_password_use_case.dart';
import 'package:snapnfix/modules/settings/domain/usecases/edit_profile_use_case.dart';

@module
abstract class SettingsUsecaseModule {
  @lazySingleton
  ChangePasswordUseCase provideChangePasswordUseCase(
    BaseSettingsRepository repository,
  ) => ChangePasswordUseCase(repository);

  @lazySingleton
  EditProfileUseCase provideEditProfileUseCase(
    BaseSettingsRepository repository,
  ) => EditProfileUseCase(repository);
}
