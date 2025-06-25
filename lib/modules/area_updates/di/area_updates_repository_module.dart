import 'package:injectable/injectable.dart';
import 'package:snapnfix/modules/area_updates/data/datasources/area_updates_remote_data_source.dart';
import 'package:snapnfix/modules/area_updates/data/repositories/area_updates_repository.dart';
import 'package:snapnfix/modules/area_updates/domain/repositories/base_area_updates_repository.dart';

@module
abstract class AreaUpdatesRepositoryModule {
  @singleton
  BaseAreaUpdatesRepository provideAreaUpdatesRepository(
    BaseAreaUpdatesRemoteDataSource remoteDataSource,
  ) => AreaUpdatesRepository(remoteDataSource);
}
