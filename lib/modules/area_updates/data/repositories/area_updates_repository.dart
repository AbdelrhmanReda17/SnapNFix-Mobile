import 'package:snapnfix/core/infrastructure/networking/error/api_error.dart';
import 'package:snapnfix/core/utils/result.dart';
import 'package:snapnfix/modules/area_updates/data/datasources/area_updates_remote_data_source.dart';
import 'package:snapnfix/modules/area_updates/domain/entities/area_health_metrics.dart';
import 'package:snapnfix/modules/area_updates/domain/entities/area_info.dart';
import 'package:snapnfix/modules/area_updates/domain/repositories/base_area_updates_repository.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue.dart';

class AreaUpdatesRepository implements BaseAreaUpdatesRepository {
  final BaseAreaUpdatesRemoteDataSource _remoteDataSource;

  AreaUpdatesRepository(this._remoteDataSource);

  @override
  Future<Result<List<Issue>, ApiError>> getAreaIssues(
    String areaName, {
    int page = 1,
    int limit = 20,
  }) async {
    final result = await _remoteDataSource.getAreaIssues(areaName, page: page, limit: limit);
    return result.when(
      success: (models) => Result.success(models.cast<Issue>()),
      failure: (error) => Result.failure(error),
    );
  }

  @override
  Future<Result<AreaHealthMetrics, ApiError>> getAreaHealth(String areaName) async {
    final result = await _remoteDataSource.getAreaHealth(areaName);
    return result.when(
      success: (model) => Result.success(model as AreaHealthMetrics),
      failure: (error) => Result.failure(error),
    );
  }

  @override
  Future<Result<List<AreaInfo>, ApiError>> getAllAreas() async {
    final result = await _remoteDataSource.getAllAreas();
    return result.when(
      success: (models) => Result.success(models.cast<AreaInfo>()),
      failure: (error) => Result.failure(error),
    );
  }
  @override
  Future<Result<List<AreaInfo>, ApiError>> getSubscribedAreas() async {
    final result = await _remoteDataSource.getSubscribedAreas();
    return result.when(
      success: (models) => Result.success(models.cast<AreaInfo>()),
      failure: (error) => Result.failure(error),
    );
  }

  @override
  Future<Result<void, ApiError>> subscribeToArea(String areaName) async {
    return _remoteDataSource.subscribeToArea(areaName);
  }

  @override
  Future<Result<void, ApiError>> unsubscribeFromArea(String areaName) async {
    return _remoteDataSource.unsubscribeFromArea(areaName);
  }
}