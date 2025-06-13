import 'package:injectable/injectable.dart';
import 'package:snapnfix/core/config/application_configurations.dart';
import 'package:snapnfix/modules/settings/data/datasources/settings_remote_data_source.dart';
import 'package:snapnfix/modules/settings/data/repositories/settings_repository.dart';
import 'package:snapnfix/modules/settings/domain/repositories/base_settings_repository.dart';

@module
abstract class SettingsRepositoryModule {
  @lazySingleton
  BaseSettingsRepository provideSettingsRepository(
    BaseSettingsRemoteDataSource remoteDataSource,
    ApplicationConfigurations appConfig,
  ) => SettingsRepository(remoteDataSource, appConfig);
}
