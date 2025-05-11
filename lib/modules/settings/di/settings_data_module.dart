import 'package:injectable/injectable.dart';
import 'package:snapnfix/core/infrastructure/networking/api_service.dart';
import 'package:snapnfix/modules/settings/data/datasources/settings_remote_data_source.dart';

@module
abstract class SettingsDataModule {
  @lazySingleton
  BaseSettingsRemoteDataSource provideSettingsRemoteDataSource(
    ApiService apiService,
  ) => SettingsRemoteDataSource(apiService);
}
