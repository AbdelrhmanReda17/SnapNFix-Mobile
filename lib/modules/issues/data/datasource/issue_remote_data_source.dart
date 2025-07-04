import 'package:dio/dio.dart';
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
      final isConnected = await getIt<ConnectivityService>().isConnected();
      if (!isConnected) {
        return Result.failure(
          ApiError(message: 'error_no_internet_connection'),
        );
      }
      final response = await apiCall();
      return Result.success(response.data as T);
    } catch (error) {
      return Result.failure(
        error is DioException && error.error is ApiError
            ? error.error as ApiError
            : ApiError(message: 'error_unexpected_occurred'),
      );
    }
  }

  @override
  Future<Result<IssueModel, ApiError>> getIssueDetails(String issueId) async {
    debugPrint("Fetching issue details for ID: $issueId");
    return await _handleApiCall<IssueModel>(
      apiCall: () => _apiService.getIssueById(issueId),
    );
  }

  @override
  Future<Result<List<IssueMarker>, ApiError>> getNearbyIssues({
    required LatLngBounds bounds,
    required int maxResults,
  }) async {
    return await _handleApiCall<List<IssueMarker>>(
      apiCall:
          () => _apiService.getNearbyIssues(
            GetNearbyIssuesQuery(
              northEastLat: bounds.northeast.latitude,
              northEastLng: bounds.northeast.longitude,
              southWestLat: bounds.southwest.latitude,
              southWestLng: bounds.southwest.longitude,
              maxResults: maxResults,
            ),
          ),
    );
  }

  @override
  Future<Result<List<IssueModel>, ApiError>> getUserIssues(
    String userId,
  ) async {
    return await _handleApiCall<List<IssueModel>>(
      apiCall: () async {
        return ApiResponse<List<IssueModel>>(
          data: [],
          message: 'Success',
          success: true,
        );
      },
    );
  }
}
