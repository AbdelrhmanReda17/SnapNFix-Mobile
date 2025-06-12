import 'package:snapnfix/core/infrastructure/networking/error/api_error.dart';
import 'package:snapnfix/core/utils/result.dart';
import 'package:snapnfix/modules/reports/data/models/report_model.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_severity.dart';
import 'package:snapnfix/modules/reports/domain/repositories/base_report_repository.dart';

class SubmitReportUseCase {
  final BaseReportRepository _repository;

  SubmitReportUseCase(this._repository);

  Future<Result<String, ApiError>> call({
    required String details,
    required double latitude,
    required double longitude,
    required ReportSeverity severity,
    required String city,
    required String road,
    required String state,
    required String country,
    required String imagePath,
    String? category,
  }) async {
    try {
      if (imagePath.isEmpty) {
        return Result.failure(ApiError(message: 'Report image is required'));
      }

      final report = ReportModel(
        details: details,
        latitude: latitude,
        longitude: longitude,
        city: city,
        road: road,
        state: state,
        country: country,
        severity: severity,
        createdAt: DateTime.now(),
        imagePath: imagePath,
        category: category,
      );

      return await _repository.submitReport(report);
    } catch (e) {
      return Result.failure(
        ApiError(message: 'Failed to submit report: ${e.toString()}'),
      );
    }
  }
}
