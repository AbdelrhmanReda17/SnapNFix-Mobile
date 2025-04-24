import 'package:flutter/widgets.dart';
import 'package:snapnfix/modules/reports/domain/repositories/base_report_repository.dart';

class SyncPendingReportsUseCase {
  final BaseReportRepository _repository;

  SyncPendingReportsUseCase(this._repository);

  Future<bool> call() {
    debugPrint('Syncing pending reports...');
    return _repository.syncPendingReports();
  }
}
