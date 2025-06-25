import 'package:snapnfix/core/infrastructure/networking/error/api_error.dart';
import 'package:snapnfix/core/utils/result.dart';
import 'package:snapnfix/modules/area_updates/domain/entities/area_details.dart';
import 'package:snapnfix/modules/area_updates/domain/entities/area_health_metrics.dart';
import 'package:snapnfix/modules/area_updates/domain/entities/area_info.dart';
import 'package:snapnfix/modules/area_updates/domain/repositories/base_area_updates_repository.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue.dart';

class GetAreaDetailsUseCase {
  final BaseAreaUpdatesRepository _repository;

  GetAreaDetailsUseCase(this._repository);

  Future<Result<AreaDetails, ApiError>> call({
    required String areaName,
    int page = 1,
    int limit = 20,
  }) async {
    if (areaName.trim().isEmpty) {
      return Result.failure(ApiError(message: 'Area name cannot be empty'));
    }

    try {
      // Execute all calls concurrently
      final results = await Future.wait([
        _repository.getAreaIssues(areaName, page: page, limit: limit),
        _repository.getAreaHealth(areaName),
        _repository.getSubscribedAreas(),
      ]);      
      final issuesResult = results[0] as Result<List<Issue>, ApiError>;
      final healthResult = results[1] as Result<AreaHealthMetrics, ApiError>;
      final subscriptionsResult = results[2] as Result<List<AreaInfo>, ApiError>;
      final issues = issuesResult.when(
        success: (issues) => issues,
        failure: (error) => throw error,
      );
      final healthMetrics = healthResult.when(
        success: (metrics) => metrics,
        failure: (error) => throw error,
      );      final subscribedAreas = subscriptionsResult.when(
        success: (areas) => areas,
        failure: (error) => throw error,
      );
      final areaDetails = AreaDetails(
        areaName,
        issues: issues,
        healthMetrics: healthMetrics,
        isSubscribed: subscribedAreas.any((area) => area.name == areaName),
      );

      return Result.success(areaDetails);
    } catch (e) {
      return Result.failure(
        ApiError(message: 'Failed to get area details: ${e.toString()}'),
      );
    }
  }
}
