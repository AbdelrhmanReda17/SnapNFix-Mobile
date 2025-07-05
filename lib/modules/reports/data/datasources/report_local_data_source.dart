import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:snapnfix/modules/reports/data/models/offline_report_entity.dart';
import 'package:snapnfix/modules/reports/data/models/snap_report_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_severity.dart';
import 'package:uuid/uuid.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class BaseReportLocalDataSource {
  Future<void> initialize();

  Future<String> saveReportOffline(SnapReportModel report);

  Future<List<SnapReportModel>> getPendingReports();

  Future<void> markReportAsSynced(String reportId);

  Future<void> deleteOfflineReport(String reportId);

  Future<File> saveImagePermanently(File imageFile);

  // Reactive ValueListenables
  ValueListenable<List<SnapReportModel>> watchPendingReports();
  ValueListenable<int> watchPendingReportsCount();

  // Utility methods
  int getPendingReportsCount();

  Future<void> clearAllReports();

  void dispose();
}

class ReportLocalDataSource implements BaseReportLocalDataSource {
  static const String _boxName = 'offline_reports';
  static const String _imagesDir = 'offline_images';

  Directory? _imagesDirectory;
  final _pendingCountNotifier = ValueNotifier<int>(0);
  // Stream management
  final _pendingReportsNotifier = ValueNotifier<List<SnapReportModel>>([]);

  Box<OfflineReportEntity>? _reportsBox;

  @override
  Future<void> clearAllReports() async {
    try {
      _ensureInitialized();

      // Delete all images
      final reports = _reportsBox!.values.toList();
      for (final report in reports) {
        final imageFile = File(report.imagePath);
        if (await imageFile.exists()) {
          await imageFile.delete();
        }
      }

      // Clear box
      await _reportsBox!.clear();
      await _updateStreams();
    } catch (e) {
      throw Exception('error_clear_reports_failed');
    }
  }

  @override
  Future<void> deleteOfflineReport(String reportId) async {
    try {
      _ensureInitialized();

      final report = _reportsBox!.get(reportId);
      if (report != null) {
        // Delete associated image
        final imageFile = File(report.imagePath);
        if (await imageFile.exists()) {
          await imageFile.delete();
          debugPrint('Deleted image: ${report.imagePath}');
        }

        // Delete from Hive
        await _reportsBox!.delete(reportId);
        await _updateStreams();

        debugPrint('Deleted offline report: $reportId');
      }
    } catch (e) {
      debugPrint('Failed to delete offline report: $e');
      throw Exception('error_delete_report_failed');
    }
  }

  @override
  void dispose() {
    _pendingReportsNotifier.dispose();
    _pendingCountNotifier.dispose();
    _reportsBox?.close();
  }

  @override
  Future<List<SnapReportModel>> getPendingReports() async {
    try {
      _ensureInitialized();

      final pendingReports =
          _reportsBox!.values
              .where((report) => !report.isSynced)
              .map(_entityToModel)
              .toList();

      // Sort by creation date (newest first)
      pendingReports.sort(
        (a, b) => b.createdAt?.compareTo(a.createdAt ?? DateTime.now()) ?? 0,
      );

      return pendingReports;
    } catch (e) {
      debugPrint('Failed to get pending reports: $e');
      return [];
    }
  }

  @override
  int getPendingReportsCount() {
    return _pendingCountNotifier.value;
  }

  @override
  Future<void> initialize() async {
    try {
      debugPrint('🔧 Initializing HiveReportLocalDataSource...');

      // Initialize Hive
      await Hive.initFlutter();

      // Register adapter (in case it's not registered)
      if (!Hive.isAdapterRegistered(0)) {
        Hive.registerAdapter(OfflineReportEntityAdapter());
      }

      // Open existing box or create new one
      _reportsBox = await Hive.openBox<OfflineReportEntity>(_boxName);

      // Setup images directory
      final appDir = await getApplicationDocumentsDirectory();
      _imagesDirectory = Directory('${appDir.path}/$_imagesDir');

      // Create images directory if it doesn't exist
      if (!await _imagesDirectory!.exists()) {
        await _imagesDirectory!.create(recursive: true);
        debugPrint('📁 Created images directory');
      } else {
        debugPrint('📁 Images directory already exists');
      }

      // Initialize streams with existing data
      await _updateStreams();

      debugPrint(
        '✅ HiveReportLocalDataSource initialized successfully. Found ${_reportsBox!.length} existing reports',
      );
    } catch (e) {
      debugPrint('❌ Failed to initialize HiveReportLocalDataSource: $e');
      throw Exception('error_initialize_storage_failed');
    }
  }

      // Try to delete existing box completely
     

  @override
  Future<void> markReportAsSynced(String reportId) async {
    try {
      _ensureInitialized();

      final report = _reportsBox!.get(reportId);
      if (report != null) {
        report.isSynced = true;
        await report.save();
        await _updateStreams();
        debugPrint('Report marked as synced: $reportId');
      }
    } catch (e) {
      debugPrint('Failed to mark report as synced: $e');
      throw Exception('error_mark_report_synced_failed');
    }
  }

  @override
  Future<File> saveImagePermanently(File originalImage) async {
    try {
      _ensureInitialized();

      final imageId = const Uuid().v4();
      final extension = originalImage.path.split('.').last;
      final fileName = '$imageId.$extension';
      final savedPath = '${_imagesDirectory!.path}/$fileName';

      final savedImage = await originalImage.copy(savedPath);
      debugPrint('Image saved permanently: $savedPath');

      return savedImage;
    } catch (e) {
      debugPrint('Failed to save image permanently: $e');
      return originalImage; // Return original as fallback
    }
  }

  @override
  Future<String> saveReportOffline(SnapReportModel report) async {
    try {
      _ensureInitialized();

      // Save image permanently
      final savedImage = await saveImagePermanently(report.image);

      // Create offline entity
      final reportId = const Uuid().v4();
      final offlineReport = OfflineReportEntity(
        id: reportId,
        imagePath: savedImage.path,
        comment: report.comment,
        latitude: report.latitude,
        longitude: report.longitude,
        severity: report.severity?.displayName,
        road: report.road,
        city: report.city,
        state: report.state,
        country: report.country,
        createdAt: DateTime.now(),
        isSynced: false,
      );

      // Save to Hive
      await _reportsBox!.put(reportId, offlineReport);

      // Update streams
      await _updateStreams();

      debugPrint('Report saved offline with ID: $reportId');
      return reportId;
    } catch (e) {
      debugPrint('Failed to save report offline: $e');
      throw Exception('error_save_report_offline_failed');
    }
  }

  @override
  ValueListenable<List<SnapReportModel>> watchPendingReports() {
    return _pendingReportsNotifier;
  }

  @override
  ValueListenable<int> watchPendingReportsCount() {
    return _pendingCountNotifier;
  }

  Future<void> _updateStreams() async {
    try {
      final pendingReports = await getPendingReports();
      _pendingReportsNotifier.value = pendingReports;
      _pendingCountNotifier.value = pendingReports.length;
    } catch (e) {
      debugPrint('Failed to update streams: $e');
    }
  }

  SnapReportModel _entityToModel(OfflineReportEntity entity) {
    return SnapReportModel(
      id: entity.id,
      imagePath: entity.imagePath,
      comment: entity.comment,
      latitude: entity.latitude,
      longitude: entity.longitude,
      road: entity.road,
      city: entity.city,
      state: entity.state,
      country: entity.country,
      severity:
          entity.severity != null
              ? ReportSeverity.values.firstWhere(
                (s) => s.displayName == entity.severity,
                orElse: () => ReportSeverity.medium,
              )
              : null,
      createdAt: entity.createdAt,
    );
  }

  void _ensureInitialized() {
    if (_reportsBox == null || _imagesDirectory == null) {
      throw Exception('error_storage_not_initialized');
    }
  }
}
