import 'package:snapnfix/core/index.dart';
import 'package:snapnfix/modules/reports/data/models/report_model.dart';
import 'package:snapnfix/modules/reports/data/models/get_reports_query.dart';

abstract class BaseReportRemoteDataSource {
  Future<Result<ReportModel, ApiError>> submitReport(ReportModel report);
  Future<Result<MapEntry<List<ReportModel>, bool>, ApiError>> getUserReports({
    String? status,
    String? category,
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
  Future<Result<ReportModel, ApiError>> submitReport(ReportModel report) async {
    try {
      return await _handleApiCall(
        apiCall:
            () => _apiService.createSnapReport(
              report.details ?? '',
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
    } catch (error) {
      return Result.failure(
        ApiError(message: error.toString(), code: 'report_submission_error'),
      );
    }
  }

  @override
  Future<Result<MapEntry<List<ReportModel>, bool>, ApiError>> getUserReports({
    String? status,
    String? category,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final result = await _handleApiCall<PaginatedResponse<ReportModel>>(
        apiCall: () async {
          return await _apiService.getUserReports(
            GetReportsQuery(
              status: status,
              category: category,
              page: page,
              limit: limit,
            ),
          );
        },
      );

      return result.when<Result<MapEntry<List<ReportModel>, bool>, ApiError>>(
        success: (data) {
          return Result.success(MapEntry(data.items, data.hasNextPage));
        },
        failure: (error) {
          return Result.failure(error);
        },
      );
    } catch (error) {
      return Result.failure(
        ApiError(message: error.toString(), code: 'fetch_reports_error'),
      );
    }
  }
}
