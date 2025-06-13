import 'package:injectable/injectable.dart';
import 'package:snapnfix/core/infrastructure/networking/error/api_error.dart';
import 'package:snapnfix/core/utils/result.dart';
import 'package:snapnfix/modules/reports/data/models/report_statistics_model.dart';
import 'package:snapnfix/modules/reports/domain/repositories/base_report_repository.dart';

@injectable
class GetReportStatisticsUseCase {
  final BaseReportRepository _repository;

  GetReportStatisticsUseCase(this._repository);

  Future<Result<ReportStatisticsModel, ApiError>> call() async {
    return await _repository.getReportStatistics();
  }
}
