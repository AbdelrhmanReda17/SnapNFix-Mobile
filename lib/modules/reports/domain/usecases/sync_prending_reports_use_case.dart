import 'package:snapnfix/core/infrastructure/networking/api_error_model.dart';
import 'package:snapnfix/core/infrastructure/networking/api_result.dart';
import 'package:snapnfix/modules/reports/domain/repositories/base_report_repository.dart';

class SyncPendingReportsUseCase {
  final BaseReportRepository _repository;

  SyncPendingReportsUseCase(this._repository);

  Future<ApiResult<bool>> call() async {
    try {
      final success = await _repository.syncPendingReports();
      if (success) {
        return const ApiResult.success(true);
      } else {
        return ApiResult.failure(ApiErrorModel(
          message: 'Failed to sync pending reports',
        ));
      }
    } catch (e) {
      return ApiResult.failure(ApiErrorModel(
        message: 'Failed to sync pending reports: ${e.toString()}',
      ));
    }
  }
}
