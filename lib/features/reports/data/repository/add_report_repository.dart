import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:snapnfix/core/helpers/shared_pref_keys.dart';
import 'package:snapnfix/core/networking/api_error_handler.dart';
import 'package:snapnfix/core/networking/api_result.dart';
import 'package:snapnfix/core/networking/api_service.dart';
import 'package:snapnfix/core/services/connectivity_service.dart';
import 'package:snapnfix/features/reports/data/models/media_dto.dart';
import 'package:snapnfix/features/reports/data/models/report_dto.dart';
import 'package:snapnfix/features/reports/data/repository/offline_reports_repository.dart';
import 'package:uuid/uuid.dart';

class AddReportRepository {
  final ApiService _apiService;
  final ConnectivityService _connectivityService;
  final OfflineReportsRepository _offlineReportsRepository;

  AddReportRepository(
    this._apiService,
    this._connectivityService,
    this._offlineReportsRepository,
  );

  Future<String> _saveImagePermanently(File originalImage) async {
    try {
      final reportId = const Uuid().v4();
      final directory = await getApplicationDocumentsDirectory();
      final reportsDir = Directory('${directory.path}/offline_reports');
      if (!await reportsDir.exists()) {
        await reportsDir.create(recursive: true);
      }
      final extension = originalImage.path.split('.').last;
      final fileName = '$reportId.$extension';
      final savedPath = '${reportsDir.path}/$fileName';
      debugPrint('📸 Saving image to permanent storage: $savedPath');
      final savedImage = await originalImage.copy(savedPath);
      debugPrint('📸 Image saved successfully');
      return savedImage.path;
    } catch (e) {
      debugPrint('❌ Error saving image: $e');
      return originalImage.path;
    }
  }

  Future<ApiResult<MediaDTO>> autoCategorizeImage(String imagePath) async {
    try {
      // final response = await _apiService.autoCategorizeImage(imagePath);
      return ApiResult.success(
        data: MediaDTO(
          imagePath: File('a'),
          category: 'Potholes',
          threshold: 0.8,
        ),
      );
    } catch (error) {
      return ApiResult.failure(
        error: ApiErrorHandler(error).apiErrorModel.message,
      );
    }
  }

  Future<void> _saveReportForOfflineSubmit(ReportDTO report) async {
    try {
      report.imagePath = await _saveImagePermanently(File(report.imagePath));
      final reportsDir =
          await _offlineReportsRepository.getOfflineReportsDirectory();
      if (!await reportsDir.exists()) {
        await reportsDir.create(recursive: true);
      }
      await reportsDir.create(recursive: true);
      final reportFile = File('${reportsDir.path}/${report.id}.json');
      debugPrint('📁 Saving report to offline storage: ${reportFile.path}');
      await reportFile.writeAsString(jsonEncode(report.toJson()));
      debugPrint('✅ Saved report offline: ${report.id}');
    } catch (e) {
      debugPrint('❌ Error saving report offline: $e');
      throw Exception('Failed to save report offline: $e');
    }
  }

  Future<List<ReportDTO>> _getPendingReports() async {
    try {
      final reportsDir =
          await _offlineReportsRepository.getOfflineReportsDirectory();
      if (!await reportsDir.exists()) {
        return [];
      }

      final reportFiles =
          await reportsDir
              .list()
              .where(
                (entity) => entity is File && entity.path.endsWith('.json'),
              )
              .toList();

      List<ReportDTO> reports = [];
      for (var entity in reportFiles) {
        if (entity is File) {
          try {
            final jsonString = await entity.readAsString();
            final jsonMap = jsonDecode(jsonString);
            reports.add(ReportDTO.fromJson(jsonMap));
          } catch (e) {
            debugPrint('❌ Error parsing report file: $e and deleting it');
            await entity.delete();
          }
        }
      }
      return reports;
    } catch (e) {
      debugPrint('❌ Error getting pending reports: $e');
      return [];
    }
  }

  Future<void> syncPendingReports() async {
    debugPrint('🔄 Syncing pending reports...');

    final pendingReportsCount =
        _offlineReportsRepository.getPendingReportsCount();

    if (pendingReportsCount == 0) {
      debugPrint('✅ No pending reports to sync.');
      return;
    }

    final reports = await _getPendingReports();
    for (var report in reports) {
      final result = await submitReport(report);
      result.when(
        success: (data) async {
          final reportsDir =
              await _offlineReportsRepository.getOfflineReportsDirectory();
          final reportFile = File('${reportsDir.path}/${report.id}.json');
          final imageFile = File(report.imagePath);
          if (await imageFile.exists()) {
            await imageFile.delete();
            debugPrint('✅ Deleted offline report image: ${report.imagePath}');
          }
          if (await reportFile.exists()) {
            await reportFile.delete();
            debugPrint('✅ Deleted offline report file: ${report.id}');
          }

          _offlineReportsRepository.decrementPendingReportsCount();
        },
        failure: (error) {
          debugPrint('❌ Failed to submit report: $error');
        },
      );
    }
  }

  Future<ApiResult<String>> submitReport(ReportDTO reportDTO) async {
    debugPrint('📤 Submitting report: ${reportDTO.id}');
    final isConnected = await _connectivityService.isConnected();

    if (!isConnected) {
      debugPrint('🌐 No internet connection. Saving report offline.');
      await _saveReportForOfflineSubmit(reportDTO);
      _offlineReportsRepository.incrementPendingReportsCount();

      debugPrint('📡 Saved report offline for later sync: ${reportDTO.id}');
      return ApiResult.success(
        data: 'Report saved offline and will be submitted when reconnected',
      );
    } else {
      //TODO: Implement the actual API call to submit the report
      // Simulating successful submission
      return ApiResult.success(data: 'Report Submitted successfully');
    }
  }
}
