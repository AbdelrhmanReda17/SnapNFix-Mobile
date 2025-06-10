import 'package:injectable/injectable.dart';
import 'package:snapnfix/core/infrastructure/networking/api_result.dart';
import 'package:snapnfix/modules/reports/data/model/report_model.dart';

@factoryMethod
abstract class BaseReportRepository {
  // Online Reporting
  Future<ApiResult<String>> submitReport(ReportModel report);
  // Offline Reporting
  Future<List<ReportModel>> getPendingReports();
  Future<bool> syncPendingReports();
  int getPendingReportsCount();
  Stream<int> watchPendingReportsCount();
  Stream<List<ReportModel>> watchPendingReports();

  // Pagination
  Future<ApiResult<MapEntry<List<ReportModel>, bool>>> getUserReports({
    String? status,
    String? category,
    int page = 1,
    int limit = 10,
  });
}
