import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:snapnfix/modules/issues/data/models/get_nearby_issues_query.dart';
import 'package:snapnfix/modules/issues/data/models/issue_model.dart';
import 'package:snapnfix/modules/issues/data/models/markers.dart';
import 'package:snapnfix/core/index.dart';

abstract class BaseIssueRemoteDataSource {
  Future<Result<List<IssueMarker>, ApiError>> getNearbyIssues({
    required LatLngBounds bounds,
    required int maxResults,
  });

  Future<Result<IssueModel, ApiError>> getIssueDetails(String issueId);

  Future<Result<List<IssueModel>, ApiError>> getUserIssues(String userId);
}

class IssueRemoteDataSource implements BaseIssueRemoteDataSource {
  final ApiService _apiService;

  IssueRemoteDataSource(this._apiService);

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
  Future<Result<IssueModel, ApiError>> getIssueDetails(String issueId) async {
    try {
      debugPrint("Fetching issue details for ID: $issueId");
      return await _handleApiCall<IssueModel>(
        apiCall: () async {
          final response = await _apiService.getIssueById(issueId);
          return response;
        },
      );
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
  Future<Result<List<IssueMarker>, ApiError>> getNearbyIssues({
    required LatLngBounds bounds,
    required int maxResults,
  }) async {
    try {
      return await _handleApiCall<List<IssueMarker>>(
        apiCall: () async {
          final result = _apiService.getNearbyIssues(
            GetNearbyIssuesQuery(
              northEastLat: bounds.northeast.latitude,
              northEastLng: bounds.northeast.longitude,
              southWestLat: bounds.southwest.latitude,
              southWestLng: bounds.southwest.longitude,
              maxResults: maxResults,
            ),
          );
          return result;
        },
      );
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
  Future<Result<List<IssueModel>, ApiError>> getUserIssues(
    String userId,
  ) async {
    try {
      return Result.success([]);
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
}
