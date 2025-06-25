import 'package:injectable/injectable.dart';
import 'package:snapnfix/modules/settings/domain/repositories/base_settings_repository.dart';
import 'package:snapnfix/modules/settings/domain/usecases/edit_profile_use_case.dart';

@module
abstract class SettingsUsecaseModule {
  @lazySingleton
  EditProfileUseCase provideEditProfileUseCase(
    BaseSettingsRepository repository,
  ) => EditProfileUseCase(repository);
}
