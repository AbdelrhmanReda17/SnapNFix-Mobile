import 'package:flutter/widgets.dart';
import 'package:snapnfix/modules/reports/domain/repositories/base_report_repository.dart';

class GetPendingReportsCountUseCase {
  final BaseReportRepository _repository;

  GetPendingReportsCountUseCase(this._repository);

  int call() {
    debugPrint('Syncing pending reports...');
    return _repository.getPendingReportsCount();
  }
}
