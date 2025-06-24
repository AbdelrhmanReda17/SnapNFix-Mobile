import 'package:injectable/injectable.dart';
import 'package:snapnfix/core/infrastructure/networking/api_service.dart';
import 'package:snapnfix/modules/area_updates/data/datasources/area_updates_remote_data_source.dart';

@module
abstract class AreaUpdatesDataModule {
  @singleton
  BaseAreaUpdatesRemoteDataSource provideAreaUpdatesRemoteDataSource(
    ApiService apiService,
  ) => AreaUpdatesRemoteDataSource(apiService);
}
