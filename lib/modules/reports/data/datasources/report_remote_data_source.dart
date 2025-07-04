import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:snapnfix/core/index.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_category.dart';
import 'package:snapnfix/modules/reports/data/models/fast_report_model.dart';
import 'package:snapnfix/modules/reports/data/models/report_statistics_model.dart';
import 'package:snapnfix/modules/reports/data/models/snap_report_model.dart';
import 'package:snapnfix/modules/reports/data/models/get_reports_query.dart';
import 'package:snapnfix/modules/reports/data/models/create_fast_report_request.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_severity.dart';

abstract class BaseReportRemoteDataSource {
  Future<Result<SnapReportModel, ApiError>> submitReport(
    SnapReportModel report,
  );

  Future<Result<bool, ApiError>> submitFastReport({
    required String issueId,
    required String comment,
    required ReportSeverity severity,
  });

  Future<Result<MapEntry<List<SnapReportModel>, bool>, ApiError>>
  getUserReports({
    String? status,
    IssueCategory? category,
    String? sort,
    int page = 1,
    int limit = 10,
  });

  Future<Result<ReportStatisticsModel, ApiError>> getReportStatistics();

  Future<Result<MapEntry<List<FastReportModel>, bool>, ApiError>>
  getIssueFastReports({
    required String issueId,
    String? sort,
    int page = 1,
    int limit = 10,
  });

  Future<Result<MapEntry<List<SnapReportModel>, bool>, ApiError>>
  getIssueSnapReports({
    required String issueId,
    String? sort,
    int page = 1,
    int limit = 10,
  });
}

class ReportRemoteDataSource implements BaseReportRemoteDataSource {
  final ApiService _apiService;
  ReportRemoteDataSource(this._apiService);

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
  Future<Result<SnapReportModel, ApiError>> submitReport(
    SnapReportModel report,
  ) async {
    return await _handleApiCall(
      apiCall:
          () => _apiService.createSnapReport(
            report.comment ?? '',
            report.severity!.displayName,
            report.latitude,
            report.longitude,
            report.city,
            report.road,
            report.state,
            report.country,
            report.image,
          ),
    );
  }

  @override
  Future<Result<bool, ApiError>> submitFastReport({
    required String issueId,
    required String comment,
    required ReportSeverity severity,
  }) async {
    final request = CreateFastReportRequest(
      issueId: issueId,
      comment: comment,
      severity: severity,
    );

    return await _handleApiCall(
      apiCall: () => _apiService.createFastReport(request),
    );
  }

  @override
  Future<Result<MapEntry<List<SnapReportModel>, bool>, ApiError>>
  getUserReports({
    String? sort,
    String? status,
    IssueCategory? category,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final result = await _handleApiCall<PaginatedResponse<SnapReportModel>>(
        apiCall: () async {
          return await _apiService.getUserReports(
            GetReportsQuery(
              sort: sort,
              status: status,
              category: category,
              pageNumber: page,
              pageSize: limit,
            ),
          );
        },
      );
      return result.when<
        Result<MapEntry<List<SnapReportModel>, bool>, ApiError>
      >(
        success: (data) {
          debugPrint(
            '📜 Fetched ${data.items.length} reports with hasNextPage: ${data.hasNextPage}',
          );
          return Result.success(MapEntry(data.items, data.hasNextPage));
        },
        failure: (error) {
          return Result.failure(error);
        },
      );
    } catch (error) {
      return Result.failure(
        error is DioException && error.error is ApiError
            ? error.error as ApiError
            : ApiError(message: 'error_unexpected_occurred'),
      );
    }
  }

  @override
  Future<Result<ReportStatisticsModel, ApiError>> getReportStatistics() async {
    return await _handleApiCall<ReportStatisticsModel>(
      apiCall: () => _apiService.getReportStatistics(),
    );
  }

  @override
  Future<Result<MapEntry<List<FastReportModel>, bool>, ApiError>>
  getIssueFastReports({
    required String issueId,
    String? sort,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final result = await _handleApiCall<PaginatedResponse<FastReportModel>>(
        apiCall:
            () => _apiService.getIssueFastReports(
              issueId,
              GetReportsQuery(sort: sort, pageNumber: page, pageSize: limit),
            ),
      );

      return result.when(
        success: (data) {
          return Result.success(MapEntry(data.items, data.hasNextPage));
        },
        failure: (error) {
          return Result.failure(error);
        },
      );
    } catch (error) {
      return Result.failure(
        error is DioException && error.error is ApiError
            ? error.error as ApiError
            : ApiError(message: 'error_unexpected_occurred'),
      );
    }
  }

  @override
  Future<Result<MapEntry<List<SnapReportModel>, bool>, ApiError>>
  getIssueSnapReports({
    required String issueId,
    String? sort,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final result = await _handleApiCall<PaginatedResponse<SnapReportModel>>(
        apiCall:
            () => _apiService.getIssueSnapReports(
              issueId,
              GetReportsQuery(sort: sort, pageNumber: page, pageSize: limit),
            ),
      );
      return result.when(
        success: (data) {
          return Result.success(MapEntry(data.items, data.hasNextPage));
        },
        failure: (error) {
          return Result.failure(error);
        },
      );
    } catch (error) {
      return Result.failure(
        error is DioException && error.error is ApiError
            ? error.error as ApiError
            : ApiError(message: 'error_unexpected_occurred'),
      );
    }
  }
}
