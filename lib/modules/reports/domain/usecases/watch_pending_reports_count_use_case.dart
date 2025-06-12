import 'package:flutter/foundation.dart';
import 'package:snapnfix/modules/reports/domain/repositories/base_report_repository.dart';

class WatchPendingReportsCountUseCase {
  final BaseReportRepository _repository;

  WatchPendingReportsCountUseCase(this._repository);

  ValueListenable<int> call() {
    return _repository.watchPendingReportsCount();
  }
}
