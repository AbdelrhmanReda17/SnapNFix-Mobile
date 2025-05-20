import 'package:flutter/material.dart';
import 'package:snapnfix/core/infrastructure/networking/api_error_handler.dart';
import 'package:snapnfix/core/infrastructure/networking/api_result.dart';
import 'package:snapnfix/core/infrastructure/networking/api_service.dart';
import 'package:snapnfix/modules/reports/data/model/report_model.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_severity.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_status.dart';

abstract class BaseReportRemoteDataSource {
  Future<ApiResult<String>> submitReport(ReportModel report);
  Future<ApiResult<List<ReportModel>>> getUserReports({
    String? status,
    String? category,
    int page = 1,
    int limit = 10,
  });
}

class ReportRemoteDataSource implements BaseReportRemoteDataSource {
  final ApiService _apiService;
  ReportRemoteDataSource(this._apiService) {
    _generateMockReports();
  }

  // To be removed when API is working
  final List<ReportModel> _mockReports = [];

  void _generateMockReports() {
    for (int i = 0; i < 50; i++) {
      _mockReports.add(_createMockReport(i));
    }
    debugPrint('✓ Generated ${_mockReports.length} mock reports');
  }

  @override
  Future<ApiResult<String>> submitReport(ReportModel report) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      return const ApiResult.success("Report submitted successfully");

      // final response = await _apiService.createReport(
      //   image: report.image,
      //   comment: report.details ?? '',
      //   latitude: report.latitude,
      //   longitude: report.longitude,
      // );
      // return ApiResult.success(response.data);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<List<ReportModel>>> getUserReports({
    String? status,
    String? category,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      // final response = await _apiService.getUserReports(page: page, limit: limit);

      // final List<ReportModel> reports = [];

      // for (var item in response.data) {
      //   try {
      //     final report = ReportModel.fromJson(item as Map<String, dynamic>);
      //     reports.add(report);
      //   } catch (e) {
      //     debugPrint('Error parsing report: $e');
      //     // Continue with next item if one fails to parse
      //   }

      debugPrint('📊 Getting user reports (mock) - page: $page, limit: $limit');

      await Future.delayed(const Duration(milliseconds: 300));
      const totalReports = 40;

      final startIndex = (page - 1) * limit;

      if (startIndex >= totalReports) {
        debugPrint(
          '📊 Requested page beyond available data, returning empty list',
        );
        return const ApiResult.success([]);
      }

      final endIndex =
          (startIndex + limit) > totalReports
              ? totalReports
              : (startIndex + limit);

      var reports = List.generate(
        endIndex - startIndex,
        (index) => _createMockReport(startIndex + index),
      );

      if (status != null && status.isNotEmpty) {
        debugPrint('🔍 Filtering by status: $status');
        reports =
            reports
                .where(
                  (report) =>
                      report.status?.value.toLowerCase() ==
                      status.toLowerCase(),
                )
                .toList();
      }

      if (category != null && category.isNotEmpty) {
        debugPrint('🔍 Filtering by category: $category');
        reports =
            reports
                .where(
                  (report) =>
                      report.category?.toLowerCase() == category.toLowerCase(),
                )
                .toList();
      }

      debugPrint(
        '📊 Generated ${reports.length} mock reports for page $page (range $startIndex-$endIndex of $totalReports)',
      );
      return ApiResult.success(reports);
    } catch (error) {
      debugPrint('❌ Error fetching reports: $error');
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
  // To be removed when API is working

  ReportModel _createMockReport(int index) {
    final statuses = [
      ReportStatus.pending,
      ReportStatus.verified,
      ReportStatus.rejected,
    ];

    final severities = [
      ReportSeverity.low,
      ReportSeverity.medium,
      ReportSeverity.high,
    ];

    final categories = [
      'garbage',
      'pothole',
      'lighting',
      'damaged sign',
      'other',
    ];
    final details = [
      'Garbage overflowing from the bin. Needs immediate cleaning.',
      'Deep pothole in the middle of the road. Very dangerous for vehicles.',
      'Street light not working for the past week. Area is very dark at night.',
      'Traffic sign is damaged and not visible properly.',
      'Water leakage from the main pipe. Water being wasted continuously.',
    ];

    final String issueId = 'issue-${100 + index}';

    return ReportModel(
      id: 'mock-id-$index',
      issueId: issueId,
      details: details[index % details.length],
      imagePath: 'assets/images/issue1.jpg',
      latitude: 30.0 + (index * 0.01),
      longitude: 31.0 + (index * 0.01),
      status: statuses[index % statuses.length],
      severity: severities[index % severities.length],
      createdAt: DateTime.now().subtract(Duration(days: index % 30)),
      category: categories[index % categories.length],
    );
  }
}
