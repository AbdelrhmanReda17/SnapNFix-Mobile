import 'package:snapnfix/core/infrastructure/networking/error/api_error.dart';
import 'package:snapnfix/core/utils/result.dart';
import 'package:snapnfix/modules/area_updates/domain/entities/area_health_metrics.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue.dart';
import 'package:snapnfix/modules/area_updates/domain/entities/area_info.dart';

abstract class BaseAreaUpdatesRepository {
  Future<Result<List<Issue>, ApiError>> getAreaIssues(
    String areaName, {
    int page = 1,
    int limit = 20,
  });
  Future<Result<AreaHealthMetrics, ApiError>> getAreaHealth(String areaName);
  Future<Result<List<AreaInfo>, ApiError>> getAllAreas();
  Future<Result<List<String>, ApiError>> getSubscribedAreas();
  Future<Result<void, ApiError>> subscribeToArea(String areaName);
  Future<Result<void, ApiError>> unsubscribeFromArea(String areaName);
}
