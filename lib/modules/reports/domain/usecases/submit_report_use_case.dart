import 'dart:io';
import 'package:snapnfix/core/infrastructure/networking/api_error_model.dart';
import 'package:snapnfix/core/infrastructure/networking/api_result.dart';
import 'package:snapnfix/modules/reports/data/model/report_model.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_severity.dart';
import 'package:snapnfix/modules/reports/domain/repositories/base_report_repository.dart';

class SubmitReportUseCase {
  final BaseReportRepository _repository;

  SubmitReportUseCase(this._repository);

  Future<ApiResult<String>> call({
    required String details,
    required double latitude,
    required double longitude,
    required ReportSeverity severity,
    required String imagePath,
    String? category,
  }) async {
    try {
      if (details.isEmpty) {
        return ApiResult.failure(
          ApiErrorModel(message: 'Report details cannot be empty'),
        );
      }

      if (imagePath.isEmpty) {
        return ApiResult.failure(
          ApiErrorModel(message: 'Report image is required'),
        );
      }

      final report = ReportModel(
        details: details,
        latitude: latitude,
        longitude: longitude,
        severity: severity,
        createdAt: DateTime.now(),
        image: File(imagePath),
        category: category,
      );

      return await _repository.submitReport(report);
    } catch (e) {
      return ApiResult.failure(
        ApiErrorModel(message: 'Failed to submit report: ${e.toString()}'),
      );
    }
  }
}
