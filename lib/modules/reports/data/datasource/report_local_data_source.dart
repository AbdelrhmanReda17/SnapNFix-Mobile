import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:snapnfix/core/infrastructure/storage/shared_preferences_service.dart';
import 'package:snapnfix/core/utils/helpers/shared_pref_keys.dart';
import 'package:snapnfix/modules/reports/data/model/report_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

abstract class BaseReportLocalDataSource {
  // Report persistence
  Future<void> saveReportOffline(ReportModel report);
  Future<List<ReportModel>> getPendingReports();
  Future<void> deleteOfflineReport(String reportId);

  // Image handling
  Future<File> saveImagePermanently(File imageFile);

  // Pending reports count management
  int getPendingReportsCount();
  void incrementPendingReportsCount();
  void decrementPendingReportsCount();
  Stream<int> watchPendingReportsCount();

  // Watch pending reports
  Stream<List<ReportModel>> watchPendingReports();
}

class ReportLocalDataSource implements BaseReportLocalDataSource {
  final SharedPreferencesService _sharedPreferencesService;
  final _pendingReportsCountController = StreamController<int>.broadcast();
  final _pendingReportsController =
      StreamController<List<ReportModel>>.broadcast();

  Future<Directory> _getOfflineReportsDirectory() async {
    final directory = await getApplicationDocumentsDirectory();
    return Directory('${directory.path}/offline_reports');
  }

  ReportLocalDataSource(this._sharedPreferencesService) {
    _pendingReportsCountController.add(getPendingReportsCount());
  }

  @override
  void decrementPendingReportsCount() {
    final currentCount = getPendingReportsCount();
    if (currentCount > 0) {
      final newCount = currentCount - 1;
      _sharedPreferencesService.setInt(SharedPrefKeys.pendingReports, newCount);
      _pendingReportsCountController.add(newCount);
    }
  }

  @override
  int getPendingReportsCount() {
    return _sharedPreferencesService.getInt(
      SharedPrefKeys.pendingReports,
      defaultValue: 0,
    );
  }

  @override
  void incrementPendingReportsCount() {
    final currentCount = getPendingReportsCount();
    final newCount = currentCount + 1;
    _sharedPreferencesService.setInt(SharedPrefKeys.pendingReports, newCount);
    _pendingReportsCountController.add(newCount);
  }

  @override
  Future<void> saveReportOffline(ReportModel report) async {
    try {
      final image = await saveImagePermanently(report.image);
      final reportsDir = await _getOfflineReportsDirectory();
      final updatedReport = report.copyWithModel(image: image);

      if (!await reportsDir.exists()) {
        await reportsDir.create(recursive: true);
      }

      final reportFile = File('${reportsDir.path}/${report.id}.json');
      await reportFile.writeAsString(json.encode(updatedReport.toJson()));
      incrementPendingReportsCount();
      debugPrint('Report saved offline: ${report.id}');
      final reports = await getPendingReports();
      _pendingReportsController.add(reports);
    } catch (e) {
      throw Exception("Failed to save report offline: $e");
    }
  }

  @override
  Future<void> deleteOfflineReport(String reportId) async {
    try {
      final reportsDir = await _getOfflineReportsDirectory();
      final reportFile = File('${reportsDir.path}/$reportId.json');
      if (await reportFile.exists()) {
        final jsonString = await reportFile.readAsString();
        final jsonMap = json.decode(jsonString);
        final report = ReportModel.fromJson(jsonMap);
        final image = report.image;
        if (image.path.contains('/offline_reports/')) {
          if (await image.exists()) {
            await image.delete();
            debugPrint('Deleted offline image: ${image.path}');
          }
        }
        await reportFile.delete();
        debugPrint('Deleted offline report file: $reportId');

        // Emit updated reports list
        final reports = await getPendingReports();
        _pendingReportsController.add(reports);
      }
    } catch (e) {
      throw Exception("Failed to delete offline report: $e");
    }
  }

  @override
  Future<List<ReportModel>> getPendingReports() async {
    try {
      final reportsDir = await _getOfflineReportsDirectory();
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
      debugPrint('Found ${reportFiles.length} report files.');
      final reports = <ReportModel>[];

      for (var file in reportFiles) {
        try {
          final jsonMap = json.decode(await (file as File).readAsString());
          final report = ReportModel.fromJson(jsonMap);
          reports.add(report);
        } catch (e) {
          debugPrint('Failed to parse report file: ${file.path}');
          await file.delete();
        }
      }
      debugPrint('Parsed ${reports.length} reports successfully.');
      return reports;
    } catch (e) {
      throw Exception("Failed to get pending reports: $e");
    }
  }

  @override
  Future<File> saveImagePermanently(File originalImage) async {
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

      final savedImage = await originalImage.copy(savedPath);
      debugPrint('Image saved to permanent storage: $savedPath');

      return savedImage;
    } catch (e) {
      debugPrint('Error saving image: $e');
      // Return original path as fallback
      return originalImage;
    }
  }

  @override
  Stream<int> watchPendingReportsCount() {
    return _pendingReportsCountController.stream;
  }

  @override
  Stream<List<ReportModel>> watchPendingReports() {
    getPendingReports().then((reports) {
      _pendingReportsController.add(reports);
    });
    return _pendingReportsController.stream;
  }

  void dispose() {
    _pendingReportsCountController.close();
    _pendingReportsController.close();
  }
}
