import 'package:snapnfix/core/infrastructure/networking/error/api_error.dart';
import 'package:snapnfix/core/utils/result.dart';
import 'package:snapnfix/modules/area_updates/domain/entities/area_health_metrics.dart';
import 'package:snapnfix/modules/area_updates/domain/entities/area_issue.dart';
import 'package:snapnfix/modules/area_updates/domain/entities/area_info.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_status.dart';

abstract class BaseAreaUpdatesRepository {
  Future<Result<MapEntry<List<AreaIssue>, bool>, ApiError>> getAreaIssues(
    String areaId, {
    IssueStatus? status,
    int page = 1,
    int limit = 20,
  });

  Future<Result<AreaHealthMetrics, ApiError>> getAreaHealth(String areaId);
  Future<Result<MapEntry<List<AreaInfo>, bool>, ApiError>> getAllAreas({
    int page = 1,
    int limit = 10,
    String? searchTerm,
  });
  Future<Result<MapEntry<List<AreaInfo>, bool>, ApiError>> getSubscribedAreas({
    int page = 1,
    int limit = 10,
    String? searchTerm,
  });
  Future<Result<void, ApiError>> subscribeToArea(String areaName);
  Future<Result<void, ApiError>> unsubscribeFromArea(String areaName);
}
