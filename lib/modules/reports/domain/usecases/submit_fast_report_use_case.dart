import 'package:snapnfix/core/infrastructure/networking/error/api_error.dart';
import 'package:snapnfix/core/utils/result.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_severity.dart';
import 'package:snapnfix/modules/reports/domain/repositories/base_report_repository.dart';

class SubmitFastReportUseCase {
  final BaseReportRepository _repository;

  SubmitFastReportUseCase(this._repository);

  Future<Result<bool, ApiError>> call({
    required String issueId,
    required String comment,
    required ReportSeverity severity,
  }) {
    return _repository.submitFastReport(issueId, comment, severity);
  }
}