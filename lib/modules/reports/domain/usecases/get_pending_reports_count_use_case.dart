import 'package:snapnfix/modules/reports/domain/repositories/base_report_repository.dart';

class GetPendingReportsCountUseCase {
  final BaseReportRepository _repository;

  GetPendingReportsCountUseCase(this._repository);

  int call() {
    return _repository.getPendingReportsCount();
  }
}
