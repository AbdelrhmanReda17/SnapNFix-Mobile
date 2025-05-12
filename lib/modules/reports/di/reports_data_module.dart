import 'package:injectable/injectable.dart';
import 'package:snapnfix/core/infrastructure/networking/api_service.dart';
import 'package:snapnfix/core/infrastructure/storage/shared_preferences_service.dart';
import 'package:snapnfix/modules/reports/data/datasource/report_local_data_source.dart';
import 'package:snapnfix/modules/reports/data/datasource/report_remote_data_source.dart';

@module
abstract class ReportsDataModule {
  @lazySingleton
  BaseReportRemoteDataSource provideReportRemoteDataSource(
    ApiService apiService,
  ) => ReportRemoteDataSource(apiService);

  @lazySingleton
  BaseReportLocalDataSource provideReportLocalDataSource(
    SharedPreferencesService sharedPreferencesService,
  ) => ReportLocalDataSource(sharedPreferencesService);
}
