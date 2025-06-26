import 'package:snapnfix/index.dart';


class AreaUpdatesRepository implements BaseAreaUpdatesRepository {
  final BaseAreaUpdatesRemoteDataSource _remoteDataSource;

  AreaUpdatesRepository(this._remoteDataSource);
  @override
  Future<Result<MapEntry<List<AreaIssue>, bool>, ApiError>> getAreaIssues(
    String areaId, {
    IssueStatus? status,
    int page = 1,
    int limit = 20,
  }) async {
    final result = await _remoteDataSource.getAreaIssues(
      areaId,
      status: status,
      page: page,
      limit: limit,
    );
    return result.when(
      success: (data) => Result.success(MapEntry(data.key, data.value)),
      failure: (error) => Result.failure(error),
    );
  }

  @override
  Future<Result<AreaHealthMetrics, ApiError>> getAreaHealth(
    String areaId,
  ) async {
    final result = await _remoteDataSource.getAreaHealth(areaId);
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
      success:
          (data) =>
              Result.success(MapEntry(data.key.cast<AreaInfo>(), data.value)),
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
      success:
          (data) =>
              Result.success(MapEntry(data.key.cast<AreaInfo>(), data.value)),
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
