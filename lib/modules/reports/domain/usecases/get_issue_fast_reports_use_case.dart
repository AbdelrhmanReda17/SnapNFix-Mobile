import 'package:snapnfix/core/utils/result.dart';
import 'package:snapnfix/modules/reports/data/models/fast_report_model.dart';
import 'package:snapnfix/modules/reports/domain/repositories/base_report_repository.dart';

class GetIssueFastReportsUseCase {
  final BaseReportRepository _repository;

  GetIssueFastReportsUseCase(this._repository);

  Future<Result<MapEntry<List<FastReportModel>, bool>, String>> call({
    required String issueId,
    String? sort,
    int page = 1,
    int limit = 10,
  }) {
    return _repository.getIssueFastReports(
      issueId: issueId,
      sort: sort,
      page: page,
      limit: limit,
    );
  }
}
