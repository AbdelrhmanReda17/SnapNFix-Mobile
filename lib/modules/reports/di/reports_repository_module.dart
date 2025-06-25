import 'package:injectable/injectable.dart';
import 'package:snapnfix/core/infrastructure/connectivity/connectivity_service.dart';
import 'package:snapnfix/modules/reports/data/datasources/report_local_data_source.dart';
import 'package:snapnfix/modules/reports/data/datasources/report_remote_data_source.dart';
import 'package:snapnfix/modules/reports/data/repositories/report_repository.dart';
import 'package:snapnfix/modules/reports/domain/repositories/base_report_repository.dart';

@module
abstract class ReportsRepositoryModule {
  @lazySingleton
  BaseReportRepository provideReportRepository(
    BaseReportLocalDataSource localDataSource,
    BaseReportRemoteDataSource remoteDataSource,
    ConnectivityService connectivityService,
  ) => ReportRepository(localDataSource, remoteDataSource, connectivityService);
}
