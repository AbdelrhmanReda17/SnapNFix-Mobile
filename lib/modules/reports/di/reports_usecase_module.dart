import 'package:injectable/injectable.dart';
import 'package:snapnfix/modules/reports/domain/repositories/base_report_repository.dart';
import 'package:snapnfix/modules/reports/domain/usecases/get_pending_reports_count_use_case.dart';
import 'package:snapnfix/modules/reports/domain/usecases/submit_report_use_case.dart';
import 'package:snapnfix/modules/reports/domain/usecases/sync_prending_reports_use_case.dart';
import 'package:snapnfix/modules/reports/domain/usecases/watch_pending_reports_count_use_case.dart';

@module
abstract class ReportsUsecaseModule {
  @lazySingleton
  SubmitReportUseCase provideSubmitReportUseCase(
    BaseReportRepository repository,
  ) => SubmitReportUseCase(repository);

  @lazySingleton
  SyncPendingReportsUseCase provideSyncPendingReportsUseCase(
    BaseReportRepository repository,
  ) => SyncPendingReportsUseCase(repository);

  @lazySingleton
  WatchPendingReportsCountUseCase provideWatchPendingReportsCountUseCase(
    BaseReportRepository repository,
  ) => WatchPendingReportsCountUseCase(repository);

  @lazySingleton
  GetPendingReportsCountUseCase provideGetPendingReportsCountUseCase(
    BaseReportRepository repository,
  ) => GetPendingReportsCountUseCase(repository);
}
