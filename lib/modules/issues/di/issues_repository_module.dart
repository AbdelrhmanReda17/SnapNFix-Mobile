import 'package:injectable/injectable.dart';
import 'package:snapnfix/core/infrastructure/location/location_service.dart';
import 'package:snapnfix/modules/issues/data/datasource/issue_local_data_source.dart';
import 'package:snapnfix/modules/issues/data/datasource/issue_remote_data_source.dart';
import 'package:snapnfix/modules/issues/data/repositories/issue_repository.dart';
import 'package:snapnfix/modules/issues/domain/repositories/base_issue_repository.dart';

@module
abstract class IssuesRepositoryModule {
  @lazySingleton
  BaseIssueRepository provideIssueRepository(
    BaseIssueRemoteDataSource remoteDataSource,
    BaseIssueLocalDataSource localDataSource,
    LocationService locationService,
  ) => IssueRepository(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
    locationService: locationService,
  );
}
