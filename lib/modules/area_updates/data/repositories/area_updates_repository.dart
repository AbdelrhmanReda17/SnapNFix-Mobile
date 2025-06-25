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
  Future<Result<MapEntry<List<Issue>, bool>, ApiError>> getAreaIssues(
    String areaName, {
    int page = 1,
    int limit = 20,
  }) async {
    final result = await _remoteDataSource.getAreaIssues(areaName, page: page, limit: limit);
    return result.when(
      success: (data) => Result.success(MapEntry(data.key.cast<Issue>(), data.value)),
      failure: (error) => Result.failure(error),
    );
  }

  @override
  Future<Result<AreaHealthMetrics, ApiError>> getAreaHealth(String cityId) async {
    final result = await _remoteDataSource.getAreaHealth(cityId);
    return result.when(
      success: (model) => Result.success(model as AreaHealthMetrics),
      failure: (error) => Result.failure(error),
    );
  }

  @override
  Future<Result<MapEntry<List<AreaInfo>, bool>, ApiError>> getAllAreas({
    int page = 1,
    int limit = 10,
    String? searchTerm,
  }) async {
    final result = await _remoteDataSource.getAllAreas(
      page: page,
      limit: limit,
      searchTerm: searchTerm,
    );
    return result.when(
      success: (data) => Result.success(MapEntry(data.key.cast<AreaInfo>(), data.value)),
      failure: (error) => Result.failure(error),
    );
  }

  @override
  Future<Result<MapEntry<List<AreaInfo>, bool>, ApiError>> getSubscribedAreas({
    int page = 1,
    int limit = 10,
    String? searchTerm,
  }) async {
    final result = await _remoteDataSource.getSubscribedAreas(
      page: page,
      limit: limit,
      searchTerm: searchTerm,
    );
    return result.when(
      success: (data) => Result.success(MapEntry(data.key.cast<AreaInfo>(), data.value)),
      failure: (error) => Result.failure(error),
    );
  }

  @override
  Future<Result<void, ApiError>> subscribeToArea(String cityId) async {
    return _remoteDataSource.subscribeToArea(cityId);
  }

  @override
  Future<Result<void, ApiError>> unsubscribeFromArea(String cityId) async {
    return _remoteDataSource.unsubscribeFromArea(cityId);
  }
}