import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:snapnfix/core/infrastructure/networking/error/api_error.dart';
import 'package:snapnfix/core/utils/result.dart';
import 'package:snapnfix/modules/reports/data/models/report_model.dart';

@factoryMethod
abstract class BaseReportRepository {
  // Online Reporting
  Future<Result<String, ApiError>> submitReport(ReportModel report);
  // Offline Reporting
  Future<List<ReportModel>> getPendingReports();
  Future<bool> syncPendingReports();
  int getPendingReportsCount();
  ValueListenable<int> watchPendingReportsCount();
  ValueListenable<List<ReportModel>> watchPendingReports();

  // Pagination
  Future<Result<MapEntry<List<ReportModel>, bool>, String>> getUserReports({
    String? status,
    String? category,
    int page = 1,
    int limit = 10,
  });
}
