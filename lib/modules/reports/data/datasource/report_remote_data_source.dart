import 'package:flutter/material.dart';
import 'package:snapnfix/core/infrastructure/networking/api_error_handler.dart';
import 'package:snapnfix/core/infrastructure/networking/api_result.dart';
import 'package:snapnfix/core/infrastructure/networking/api_service.dart';
import 'package:snapnfix/modules/reports/data/model/report_model.dart';

abstract class BaseReportRemoteDataSource {
  Future<ApiResult<String>> submitReport(ReportModel report);
  Future<ApiResult<MapEntry<List<ReportModel>, bool>>> getUserReports({
    String? status,
    String? category,
    int page = 1,
    int limit = 10,
  });
}

class ReportRemoteDataSource implements BaseReportRemoteDataSource {
  final ApiService _apiService;
  ReportRemoteDataSource(this._apiService);

  @override
  Future<ApiResult<String>> submitReport(ReportModel report) async {
    try {
      final response = await _apiService.createReport(
        image: report.image,
        comment: report.details ?? '',
        latitude: report.latitude,
        longitude: report.longitude,
        severity: report.severity!.displayName,
      );
      return ApiResult.success(
        "Report submitted successfully with ID: ${response.data.id}",
      );
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<MapEntry<List<ReportModel>, bool>>> getUserReports({
    String? status,
    String? category,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await _apiService.getUserReports(
        status: status,
        category: category,
        page: page,
        limit: limit,
      );
      return ApiResult.success(
        MapEntry(response.data.items, response.data.hasNextPage),
      );
    } catch (error) {
      debugPrint('❌ Error fetching reports: $error');
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
