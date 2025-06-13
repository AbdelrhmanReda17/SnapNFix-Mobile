import 'package:snapnfix/core/utils/result.dart';
import 'package:snapnfix/modules/reports/data/models/snap_report_model.dart';
import 'package:snapnfix/modules/reports/domain/repositories/base_report_repository.dart';

class GetIssueSnapReportsUseCase {
  final BaseReportRepository _repository;

  GetIssueSnapReportsUseCase(this._repository);

  Future<Result<MapEntry<List<SnapReportModel>, bool>, String>> call({
    required String issueId,
    String? sort,
    int page = 1,
    int limit = 10,
  }) {
    return _repository.getIssueSnapReports(
      issueId: issueId,
      sort: sort,
      page: page,
      limit: limit,
    );
  }
}
