import 'dart:io';
import 'package:snapnfix/core/infrastructure/networking/api_error_handler.dart';
import 'package:snapnfix/core/infrastructure/networking/api_result.dart';
import 'package:snapnfix/core/infrastructure/networking/api_service.dart';
import 'package:snapnfix/modules/reports/data/model/report_model.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_severity.dart';

abstract class BaseReportRemoteDataSource {
  Future<ApiResult<String>> submitReport(ReportModel report);
  Future<ApiResult<ReportModel>> autoCategorizeImage(File imageFile);
}

class ReportRemoteDataSource implements BaseReportRemoteDataSource {
  // TODO: Use _apiService when implementing actual API calls
  final ApiService _apiService;

  ReportRemoteDataSource(this._apiService);

  @override
  Future<ApiResult<ReportModel>> autoCategorizeImage(File imageFile) async {
    try {
      // final response = await _apiService.autoCategorizeImage(imageFile);
      // return ApiResult.success(response);
      return ApiResult.success(
        ReportModel(
          id: "",
          details: "",
          latitude: 0,
          longitude: 0,
          severity: ReportSeverity.low,
          timestamp: DateTime.now().toIso8601String(),
          image: "http://example.com/image.jpg",
          category: "Test Category",
          threshold: 0.8,
          issueId: "",
        ),
      );
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<String>> submitReport(ReportModel report) async {
    try {
      // final response = await _apiService.submitReport(report);
      // return ApiResult.success(response);
      return ApiResult.success("Report submitted successfully");
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
