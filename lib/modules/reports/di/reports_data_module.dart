import 'package:injectable/injectable.dart';
import 'package:snapnfix/core/infrastructure/networking/api_service.dart';
import 'package:snapnfix/modules/reports/data/datasources/report_local_data_source.dart';
import 'package:snapnfix/modules/reports/data/datasources/report_remote_data_source.dart';

@module
abstract class ReportsDataModule {
  @lazySingleton
  BaseReportRemoteDataSource provideReportRemoteDataSource(
    ApiService apiService,
  ) => ReportRemoteDataSource(apiService);

  @lazySingleton
  BaseReportLocalDataSource provideReportLocalDataSource() =>
      ReportLocalDataSource();
}
