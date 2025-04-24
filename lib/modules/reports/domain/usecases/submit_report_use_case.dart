import 'package:snapnfix/core/infrastructure/networking/api_result.dart';
import 'package:snapnfix/modules/reports/data/model/report_model.dart';
import 'package:snapnfix/modules/reports/domain/repositories/base_report_repository.dart';

class SubmitReportUseCase {
  final BaseReportRepository _repository;

  SubmitReportUseCase(this._repository);

  Future<ApiResult<String>> call(ReportModel report) {
    return _repository.submitReport(report);
  }
}
