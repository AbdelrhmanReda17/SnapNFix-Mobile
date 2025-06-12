import 'package:snapnfix/core/infrastructure/networking/error/api_error.dart';
import 'package:snapnfix/core/utils/result.dart';
import 'package:snapnfix/modules/reports/domain/repositories/base_report_repository.dart';

class SyncPendingReportsUseCase {
  final BaseReportRepository _repository;

  SyncPendingReportsUseCase(this._repository);

  Future<Result<bool, ApiError>> call() async {
    try {
      final success = await _repository.syncPendingReports();
      if (success) {
        return const Result.success(true);
      } else {
        return Result.failure(
          ApiError(message: 'Failed to sync pending reports'),
        );
      }
    } catch (e) {
      return Result.failure(
        ApiError(message: 'Failed to sync pending reports: ${e.toString()}'),
      );
    }
  }
}
