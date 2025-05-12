import 'package:injectable/injectable.dart';
import 'package:snapnfix/core/infrastructure/networking/api_service.dart';
import 'package:snapnfix/core/infrastructure/storage/shared_preferences_service.dart';
import 'package:snapnfix/modules/issues/data/datasource/issue_local_data_source.dart';
import 'package:snapnfix/modules/issues/data/datasource/issue_remote_data_source.dart';

@module
abstract class IssuesDataModule {
  @lazySingleton
  BaseIssueRemoteDataSource provideIssueRemoteDataSource(
    ApiService apiService,
  ) => IssueRemoteDataSource(apiService);

  @lazySingleton
  BaseIssueLocalDataSource provideIssueLocalDataSource(
    SharedPreferencesService sharedPreferencesService,
  ) => IssueLocalDataSource(sharedPreferencesService);
}