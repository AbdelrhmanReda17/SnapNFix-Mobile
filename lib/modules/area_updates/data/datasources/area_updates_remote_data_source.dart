import 'dart:async';
import 'package:flutter/material.dart';
import 'package:snapnfix/index.dart';
import 'package:snapnfix/modules/area_updates/data/models/get_all_areas_query.dart';
import 'package:snapnfix/modules/area_updates/data/models/get_all_subscribed_areas_query.dart';
import 'package:snapnfix/modules/area_updates/data/models/get_area_issues_query.dart';

abstract class BaseAreaUpdatesRemoteDataSource {
  Future<Result<MapEntry<List<AreaIssue>, bool>, ApiError>> getAreaIssues(
    String areaId, {
    IssueStatus? status,
    int page = 1,
    int limit = 20,
  });

  Future<Result<AreaHealthMetricsModel, ApiError>> getAreaHealth(String areaId);
  Future<Result<MapEntry<List<AreaInfoModel>, bool>, ApiError>> getAllAreas({
    int page = 1,
    int limit = 10,
    String? searchTerm,
  });

  Future<Result<MapEntry<List<AreaInfoModel>, bool>, ApiError>>
  getSubscribedAreas({int page = 1, int limit = 10, String? searchTerm});
  Future<Result<void, ApiError>> subscribeToArea(String cityId);
  Future<Result<void, ApiError>> unsubscribeFromArea(String cityId);
}

class AreaUpdatesRemoteDataSource extends BaseAreaUpdatesRemoteDataSource {
  final ApiService _apiService;
  AreaUpdatesRemoteDataSource(this._apiService);

  Future<Result<T, ApiError>> _handleApiCall<T>({
    required Future<ApiResponse<T>> Function() apiCall,
  }) async {
    try {
      final response = await apiCall();
      return Result.success(response.data as T);
    } catch (error) {
      ApiError apiError;
      if (error is Map<String, dynamic>) {
        apiError = ApiError.fromJson(error);
      } else {
        apiError = ApiError(message: error.toString());
      }
      return Result.failure(apiError);
    }
  }

  @override
  Future<Result<MapEntry<List<AreaInfoModel>, bool>, ApiError>> getAllAreas({
    int page = 1,
    int limit = 10,
    String? searchTerm,
  }) async {
    try {
      final response = await _handleApiCall<PaginatedResponse<AreaInfoModel>>(
        apiCall:
            () => _apiService.getAllAreas(
              GetAllAreasQuery(
                searchTerm: searchTerm,
                pageNumber: page,
                pageSize: limit,
              ),
            ),
      );
      return response
          .when<Result<MapEntry<List<AreaInfoModel>, bool>, ApiError>>(
            success: (data) {
              return Result.success(MapEntry(data.items, data.hasNextPage));
            },
            failure: (error) {
              return Result.failure(error);
            },
          );
    } catch (e) {
      return Result.failure(ApiError(message: 'Failed to load areas: $e'));
    }
  }

  @override
  Future<Result<AreaHealthMetricsModel, ApiError>> getAreaHealth(
    String areaId,
  ) async {
    try {
      return await _handleApiCall<AreaHealthMetricsModel>(
        apiCall: () => _apiService.getAreaHealth(areaId),
      );
    } catch (e) {
      return Result.failure(
        ApiError(message: 'Failed to load area health: $e'),
      );
    }
  }

  @override
  Future<Result<MapEntry<List<AreaIssue>, bool>, ApiError>> getAreaIssues(
    String areaId, {
    IssueStatus? status,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await _handleApiCall<PaginatedResponse<AreaIssue>>(
        apiCall:
            () => _apiService.getAreaIssues(
              areaId,
              GetAreaIssuesQuery(pageNumber: page, pageSize: limit, status: status),
            ),
      );
      return response.when<Result<MapEntry<List<AreaIssue>, bool>, ApiError>>(
        success: (data) {
          return Result.success(MapEntry(data.items, data.hasNextPage));
        },
        failure: (error) {
          return Result.failure(error);
        },
      );
    } catch (e) {
      return Result.failure(
        ApiError(message: 'Failed to load area issues: $e'),
      );
    }
  }

  @override
  Future<Result<void, ApiError>> subscribeToArea(String areaId) async {
    try {
      final response = await _handleApiCall<bool>(
        apiCall: () => _apiService.subscribeToArea({'cityId': areaId}),
      );
      return response.when<Result<void, ApiError>>(
        success: (data) {
          if (data) {
            return Result.success(null);
          } else {
            return Result.failure(ApiError(message: 'Subscription failed'));
          }
        },
        failure: (error) {
          return Result.failure(error);
        },
      );
    } catch (e) {
      return Result.failure(
        ApiError(message: 'Failed to subscribe to area: $e'),
      );
    }
  }

  @override
  Future<Result<void, ApiError>> unsubscribeFromArea(String cityId) async {
    try {
      final response = await _handleApiCall<bool>(
        apiCall: () => _apiService.unsubscribeFromArea(cityId),
      );
      return response.when<Result<void, ApiError>>(
        success: (data) {
          if (data) {
            return Result.success(null);
          } else {
            return Result.failure(ApiError(message: 'Unsubscription failed'));
          }
        },
        failure: (error) {
          return Result.failure(error);
        },
      );
    } catch (e) {
      return Result.failure(
        ApiError(message: 'Failed to unsubscribe from area: $e'),
      );
    }
  }

  @override
  Future<Result<MapEntry<List<AreaInfoModel>, bool>, ApiError>>
  getSubscribedAreas({int page = 1, int limit = 10, String? searchTerm}) {
    try {
      return _handleApiCall<PaginatedResponse<AreaInfoModel>>(
        apiCall:
            () => _apiService.getAllSubscribedAreas(
              GetAllSubscribedAreasQuery(
                searchTerm: searchTerm,
                pageNumber: page,
                pageSize: limit,
              ),
            ),
      ).then((response) {
        return response
            .when<Result<MapEntry<List<AreaInfoModel>, bool>, ApiError>>(
              success: (data) {
                return Result.success(MapEntry(data.items, data.hasNextPage));
              },
              failure: (error) {
                return Result.failure(error);
              },
            );
      });
    } catch (e) {
      return Future.value(
        Result.failure(
          ApiError(message: 'Failed to load subscribed areas: $e'),
        ),
      );
    }
  }
}
