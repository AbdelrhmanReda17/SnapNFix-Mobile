import 'package:snapnfix/modules/reports/domain/repositories/base_report_repository.dart';

class WatchPendingReportsCountUseCase {
  final BaseReportRepository _repository;

  WatchPendingReportsCountUseCase(this._repository);

  Stream<int> call() {
    return _repository.watchPendingReportsCount();
  }
}
