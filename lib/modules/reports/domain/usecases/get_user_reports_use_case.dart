import 'package:snapnfix/core/utils/result.dart';
import 'package:snapnfix/modules/reports/data/models/snap_report_model.dart';
import 'package:snapnfix/modules/reports/domain/repositories/base_report_repository.dart';

class GetUserReportsUseCase {
  final BaseReportRepository _repository;

  GetUserReportsUseCase(this._repository);

  Future<Result<MapEntry<List<SnapReportModel>, bool>, String>> call({
    String? status,
    String? sort,
    String? category,
    int page = 1,
    int limit = 10,
  }) {
    return _repository.getUserReports(
      status: status,
      category: category,
      sort: sort,
      page: page,
      limit: limit,
    );
  }
}
