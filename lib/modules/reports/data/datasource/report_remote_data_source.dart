import 'dart:io';

import 'package:snapnfix/core/infrastructure/networking/api_error_handler.dart';
import 'package:snapnfix/core/infrastructure/networking/api_error_model.dart';
import 'package:snapnfix/core/infrastructure/networking/api_result.dart';
import 'package:snapnfix/core/infrastructure/networking/api_service.dart';
import 'package:snapnfix/modules/reports/data/model/media_model.dart';
import 'package:snapnfix/modules/reports/data/model/report_model.dart';

abstract class BaseReportRemoteDataSource {
  Future<ApiResult<String>> submitReport(ReportModel report);
  Future<ApiResult<MediaModel>> autoCategorizeImage(File imageFile);
}

class ReportRemoteDataSource implements BaseReportRemoteDataSource {
  final ApiService _apiService;

  ReportRemoteDataSource(this._apiService);

  @override
  Future<ApiResult<MediaModel>> autoCategorizeImage(File imageFile) async {
    try {
      // final response = await _apiService.autoCategorizeImage(imageFile);
      // return ApiResult.success(response);
      return ApiResult.success(
        MediaModel(
          image: "http://example.com/image.jpg",
          category: "Test Category",
          threshold: 0.8,
        ),
      );
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<String>> submitReport(ReportModel report) async {
    try {
      // return ApiResult.failure(
      //   ApiErrorModel(message: "Report submission failed"),
      // );
      // final response = await _apiService.submitReport(report);
      // return ApiResult.success(response);
      return ApiResult.success("Report submitted successfully");
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
