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
  Future<void> saveReportOffline(ReportModel report);
  Future<List<ReportModel>> getPendingReports();
  Future<void> deleteOfflineReport(String reportId);
  Future<File> saveImagePermanently(File imageFile);
  int getPendingReportsCount();
  void incrementPendingReportsCount();
  void decrementPendingReportsCount();
  Stream<int> watchPendingReportsCount();
  Stream<List<ReportModel>> watchPendingReports();
  Future<void> refreshCache(); // New method to manually refresh cache
  void dispose();
}

class ReportLocalDataSource implements BaseReportLocalDataSource {
  final SharedPreferencesService _sharedPreferencesService;
  final _pendingReportsCountController = StreamController<int>.broadcast();
  final _pendingReportsController =
      StreamController<List<ReportModel>>.broadcast();

  // Cache for pending reports
  List<ReportModel>? _cachedReports;
  DateTime? _lastCacheUpdate;
  final Duration _cacheValidDuration = const Duration(
    minutes: 5,
  ); // Cache validity period
  bool _isLoadingReports = false;

  Future<Directory> _getOfflineReportsDirectory() async {
    final directory = await getApplicationDocumentsDirectory();
    return Directory('${directory.path}/offline_reports');
  }

  ReportLocalDataSource(this._sharedPreferencesService) {
    _pendingReportsCountController.add(getPendingReportsCount());
    _initializeCache();
  }

  void _initializeCache() {
    // Load reports asynchronously without blocking constructor
    Future.microtask(() async {
      try {
        await _loadReportsFromDisk();
      } catch (e) {
        debugPrint('Failed to initialize cache: $e');
      }
    });
  }

  bool _isCacheValid() {
    if (_cachedReports == null || _lastCacheUpdate == null) return false;
    return DateTime.now().difference(_lastCacheUpdate!) < _cacheValidDuration;
  }

  Future<void> _loadReportsFromDisk() async {
    if (_isLoadingReports) return;

    _isLoadingReports = true;
    try {
      final reportsDir = await _getOfflineReportsDirectory();
      if (!await reportsDir.exists()) {
        _cachedReports = [];
        _lastCacheUpdate = DateTime.now();
        _pendingReportsController.add(_cachedReports!);
        return;
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
          // Clean up corrupted files
          try {
            await file.delete();
          } catch (deleteError) {
            debugPrint('Failed to delete corrupted file: $deleteError');
          }
        }
      }

      _cachedReports = reports;
      _lastCacheUpdate = DateTime.now();
      debugPrint('Loaded ${reports.length} reports to cache.');

      // Update stream with cached data
      _pendingReportsController.add(_cachedReports!);
    } catch (e) {
      debugPrint('Error loading reports from disk: $e');
      throw Exception("Failed to get pending reports: $e");
    } finally {
      _isLoadingReports = false;
    }
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
      final updatedReport = report.copyWithModel(
        image: image,
        id: const Uuid().v4(),
      );

      if (!await reportsDir.exists()) {
        await reportsDir.create(recursive: true);
      }

      final reportFile = File('${reportsDir.path}/${updatedReport.id}.json');
      await reportFile.writeAsString(json.encode(updatedReport.toJson()));

      incrementPendingReportsCount();

      // Update cache instead of reloading from disk
      if (_cachedReports != null) {
        _cachedReports!.add(updatedReport);
        _pendingReportsController.add(_cachedReports!);
      } else {
        // If cache is not initialized, load from disk
        await _loadReportsFromDisk();
      }

      debugPrint('Report saved offline: ${updatedReport.id}');
    } catch (e) {
      throw Exception("Failed to save report offline: $e");
    }
  }

  @override
  Future<void> deleteOfflineReport(String reportId) async {
    try {
      final reportsDir = await _getOfflineReportsDirectory();
      final reportFile = File('${reportsDir.path}/$reportId.json');

      debugPrint('Deleting offline report file: $reportId');

      if (await reportFile.exists()) {
        final jsonString = await reportFile.readAsString();
        final jsonMap = json.decode(jsonString);
        final report = ReportModel.fromJson(jsonMap);
        final image = report.image;

        // Delete associated image if it's in offline storage
        if (image.path.contains('/offline_reports/')) {
          debugPrint('Deleting associated image');
          if (await image.exists()) {
            await image.delete();
            debugPrint('Deleted offline image: ${image.path}');
          }
        }

        await reportFile.delete();
        debugPrint('Deleted offline report file: $reportId');

        // Update cache instead of reloading from disk
        if (_cachedReports != null) {
          _cachedReports!.removeWhere((report) => report.id == reportId);
          _pendingReportsController.add(_cachedReports!);
        } else {
          // If cache is not initialized, load from disk
          await _loadReportsFromDisk();
        }
      }
    } catch (e) {
      throw Exception("Failed to delete offline report: $e");
    }
  }

  @override
  Future<List<ReportModel>> getPendingReports() async {
    // Return cached data if valid
    if (_isCacheValid()) {
      debugPrint('Returning cached reports (${_cachedReports!.length} items)');
      return List.from(_cachedReports!);
    }

    // Load from disk if cache is invalid or empty
    await _loadReportsFromDisk();
    return List.from(_cachedReports ?? []);
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
      return originalImage;
    }
  }

  @override
  Stream<int> watchPendingReportsCount() {
    return _pendingReportsCountController.stream;
  }

  @override
  Stream<List<ReportModel>> watchPendingReports() {
    if (_cachedReports == null && !_isLoadingReports) {
      _loadReportsFromDisk();
    }
    return _pendingReportsController.stream;
  }

  @override
  Future<void> refreshCache() async {
    _cachedReports = null;
    _lastCacheUpdate = null;
    await _loadReportsFromDisk();
  }

  @override
  void dispose() {
    _pendingReportsCountController.close();
    _pendingReportsController.close();
  }
}
