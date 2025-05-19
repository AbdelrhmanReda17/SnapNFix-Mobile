import 'package:snapnfix/core/infrastructure/networking/api_result.dart';
import 'package:snapnfix/modules/reports/data/model/report_model.dart';
import 'package:snapnfix/modules/reports/domain/repositories/base_report_repository.dart';

class GetUserReportsUseCase {
  final BaseReportRepository _repository;

  GetUserReportsUseCase(this._repository);

  Future<ApiResult<List<ReportModel>>> call({
    String? status,
    String? category,
    int page = 1,
    int limit = 10,
  }) {
    return _repository.getUserReports(
      status: status,
      category: category,
      page: page,
      limit: limit,
    );
  }
}
