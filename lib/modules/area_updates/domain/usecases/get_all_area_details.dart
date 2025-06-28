import 'package:flutter/foundation.dart';
import 'package:snapnfix/core/infrastructure/networking/error/api_error.dart';
import 'package:snapnfix/core/utils/result.dart';
import 'package:snapnfix/modules/area_updates/domain/entities/area_details.dart';
import 'package:snapnfix/modules/area_updates/domain/entities/area_health_metrics.dart';
import 'package:snapnfix/modules/area_updates/domain/entities/area_info.dart';
import 'package:snapnfix/modules/area_updates/domain/entities/area_issue.dart';
import 'package:snapnfix/modules/area_updates/domain/repositories/base_area_updates_repository.dart';

class GetAreaDetailsUseCase {
  final BaseAreaUpdatesRepository _repository;

  GetAreaDetailsUseCase(this._repository);

  Future<Result<AreaDetails, ApiError>> call({
    required AreaInfo area,
    bool isSubscribed = false,
    int page = 1,
    int limit = 1,
  }) async {
    try {
      debugPrint(
        '📍 GetAreaDetailsUseCase: Fetching details for area ${area.name} (ID: ${area.id}) (limit : $limit)',
      );
      final results = await Future.wait([
        _repository.getAreaIssues(area.id, page: page, limit: limit),
        _repository.getAreaHealth(area.id),
      ]);
      final issuesResult =
          results[0] as Result<MapEntry<List<AreaIssue>, bool>, ApiError>;
      final healthResult = results[1] as Result<AreaHealthMetrics, ApiError>;

      final issuesData = issuesResult.when(
        success: (data) => data,
        failure: (error) => throw error,
      );

      debugPrint(
        '📍 issuesData: Fetched ${issuesData.key.length} issues for area ${area.name}',
      );

      final healthMetrics = healthResult.when(
        success: (metrics) => metrics,
        failure: (error) => throw error,
      );

      final areaDetails = AreaDetails(
        area,
        issues: issuesData.key,
        healthMetrics: healthMetrics,
        isSubscribed: isSubscribed,
        hasNext: issuesData.value,
      );

      return Result.success(areaDetails);
    } catch (e) {
      return Result.failure(
        ApiError(message: 'Failed to get area details: ${e.toString()}'),
      );
    }
  }
}
