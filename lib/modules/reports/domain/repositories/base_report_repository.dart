import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:snapnfix/core/infrastructure/networking/error/api_error.dart';
import 'package:snapnfix/core/utils/result.dart';
import 'package:snapnfix/modules/reports/data/models/fast_report_model.dart';
import 'package:snapnfix/modules/reports/data/models/report_statistics_model.dart';
import 'package:snapnfix/modules/reports/data/models/snap_report_model.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_severity.dart';

@factoryMethod
abstract class BaseReportRepository {
  // Online Reporting
  Future<Result<String, ApiError>> submitReport(SnapReportModel report);
  Future<Result<bool, ApiError>> submitFastReport(
    String issueId,
    String comment,
    ReportSeverity severity,
  );
  // Offline Reporting
  Future<List<SnapReportModel>> getPendingReports();
  Future<bool> syncPendingReports();
  int getPendingReportsCount();
  ValueListenable<int> watchPendingReportsCount();
  ValueListenable<List<SnapReportModel>> watchPendingReports();

  // Pagination
  Future<Result<MapEntry<List<SnapReportModel>, bool>, String>> getUserReports({
    String? status,
    String? category,
    String? sort,
    int page = 1,
    int limit = 10,
  });

  // Statistics
  Future<Result<ReportStatisticsModel, ApiError>> getReportStatistics();

  Future<Result<MapEntry<List<SnapReportModel>, bool>, String>>
  getIssueSnapReports({
    required String issueId,
    String? sort,
    int page = 1,
    int limit = 10,
  });

  Future<Result<MapEntry<List<FastReportModel>, bool>, String>>
  getIssueFastReports({
    required String issueId,
    String? sort,
    int page = 1,
    int limit = 10,
  });
}
