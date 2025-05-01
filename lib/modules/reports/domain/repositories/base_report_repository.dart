import 'dart:io';
import 'package:snapnfix/core/infrastructure/networking/api_result.dart';
import 'package:snapnfix/modules/reports/data/model/media_model.dart';
import 'package:snapnfix/modules/reports/data/model/report_model.dart';

abstract class BaseReportRepository {
  // Online Reporting
  Future<ApiResult<String>> submitReport(ReportModel report);
  Future<ApiResult<MediaModel>> autoCategorizeImage(File imageFile);

  // Offline Reporting
  Future<List<ReportModel>> getPendingReports();
  Future<bool> syncPendingReports();
  int getPendingReportsCount();
  Stream<int> watchPendingReportsCount();
  Stream<List<ReportModel>> watchPendingReports();
}
