import 'package:snapnfix/core/infrastructure/networking/api_error_handler.dart';
import 'package:snapnfix/core/infrastructure/networking/api_result.dart';
import 'package:snapnfix/core/infrastructure/networking/api_service.dart';
import 'package:snapnfix/modules/reports/data/model/report_model.dart';

abstract class BaseReportRemoteDataSource {
  Future<ApiResult<String>> submitReport(ReportModel report);
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
      );
      return ApiResult.success(response.data);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
