import 'dart:async';
import 'package:snapnfix/index.dart';
import 'package:snapnfix/modules/area_updates/data/models/area_health_metrics_model.dart';
import 'package:snapnfix/modules/area_updates/data/models/area_info_model.dart';


abstract class BaseAreaUpdatesRemoteDataSource {
  Future<Result<List<IssueModel>, ApiError>> getAreaIssues(
    String areaName, {
    int page = 1,
    int limit = 20,
  });
  Future<Result<AreaHealthMetricsModel, ApiError>> getAreaHealth(
    String areaName,
  );
  Future<Result<List<AreaInfoModel>, ApiError>> getAllAreas();
  Future<Result<List<String>, ApiError>> getSubscribedAreas();
  Future<Result<void, ApiError>> subscribeToArea(String areaName);
  Future<Result<void, ApiError>> unsubscribeFromArea(String areaName);
}

class AreaUpdatesRemoteDataSource extends BaseAreaUpdatesRemoteDataSource {
  final ApiService _apiService;
  AreaUpdatesRemoteDataSource(this._apiService);

  @override
  Future<Result<List<AreaInfoModel>, ApiError>> getAllAreas() {
    throw UnimplementedError();
  }

  @override
  Future<Result<AreaHealthMetricsModel, ApiError>> getAreaHealth(
    String areaName,
  ) {
    throw UnimplementedError();
  }

  @override
  Future<Result<List<IssueModel>, ApiError>> getAreaIssues(
    String areaName, {
    int page = 1,
    int limit = 20,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Result<List<String>, ApiError>> getSubscribedAreas() {
    throw UnimplementedError();
  }

  @override
  Future<Result<void, ApiError>> subscribeToArea(String areaName) {
    throw UnimplementedError();
  }

  @override
  Future<Result<void, ApiError>> unsubscribeFromArea(String areaName) {
    throw UnimplementedError();
  }
}
