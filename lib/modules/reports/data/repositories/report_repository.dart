import 'package:flutter/foundation.dart';
import 'package:snapnfix/core/infrastructure/connectivity/connectivity_service.dart';
import 'package:snapnfix/core/infrastructure/networking/error/api_error.dart';
import 'package:snapnfix/core/utils/result.dart';
import 'package:snapnfix/modules/reports/data/datasources/report_local_data_source.dart';
import 'package:snapnfix/modules/reports/data/datasources/report_remote_data_source.dart';
import 'package:snapnfix/modules/reports/data/models/fast_report_model.dart';
import 'package:snapnfix/modules/reports/data/models/report_statistics_model.dart';
import 'package:snapnfix/modules/reports/data/models/snap_report_model.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_severity.dart';
import 'package:snapnfix/modules/reports/domain/repositories/base_report_repository.dart';

class ReportRepository implements BaseReportRepository {
  final BaseReportLocalDataSource _localDataSource;
  final BaseReportRemoteDataSource _remoteDataSource;
  final ConnectivityService _connectivityService;

  ReportRepository(
    this._localDataSource,
    this._remoteDataSource,
    this._connectivityService,
  );

  @override
  Future<List<SnapReportModel>> getPendingReports() {
    try {
      return _localDataSource.getPendingReports();
    } catch (e) {
      return Future.error('Failed to fetch pending reports: $e');
    }
  }

  @override
  int getPendingReportsCount() {
    return _localDataSource.getPendingReportsCount();
  }

  @override
  Future<Result<String, ApiError>> submitReport(SnapReportModel report) async {
    try {
      final isConnected = await _connectivityService.isConnected();
      if (!isConnected) {
        await _localDataSource.saveReportOffline(report);
        return const Result.success(
          "No internet connection. Report saved offline.",
        );
      }

      final result = await _remoteDataSource.submitReport(report);
      return result.when(
        success: (data) {
          return Result.success(
            "Report submitted successfully with ID: ${data.id}",
          );
        },
        failure: (error) async {
          await _localDataSource.saveReportOffline(report);
          return Result.failure(
            ApiError(message: 'Failed to submit report. Saved offline.'),
          );
        },
      );
    } catch (e) {
      debugPrint('Error submitting report: $e');
      try {
        await _localDataSource.saveReportOffline(report);
        return const Result.success(
          "No internet connection. Report saved offline.",
        );
      } catch (saveError) {
        return Result.failure(
          ApiError(
            message: 'Failed to save report offline , Please try again later.',
          ),
        );
      }
    }
  }

  @override
  Future<Result<bool, ApiError>> submitFastReport(
    String issueId,
    String comment,
    ReportSeverity severity,
  ) async {
    try {
      final isConnected = await _connectivityService.isConnected();
      if (!isConnected) {
        return Result.failure(
          ApiError(
            message: 'No internet connection. Please try again later.',
            code: 'no_internet',
          ),
        );
      }

      return await _remoteDataSource.submitFastReport(
        issueId: issueId,
        comment: comment,
        severity: severity,
      );
    } catch (e) {
      debugPrint('Error submitting fast report: $e');
      return Result.failure(
        ApiError(message: e.toString(), code: 'fast_report_error'),
      );
    }
  } 

  @override
  Future<Result<MapEntry<List<FastReportModel>, bool>, String>> getIssueFastReports({
    required String issueId,
    String? sort,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final isConnected = await _connectivityService.isConnected();
      if (!isConnected) {
        return Result.failure(
          'No internet connection. Please try again later.',
        );
      }

      final result = await _remoteDataSource.getIssueFastReports(
        issueId: issueId,
        sort: sort,
        page: page,
        limit: limit,
      );

      return result.when(
        success: (data) => Result.success(data),
        failure: (error) => Result.failure(error.toString()),
      );
    } catch (e) {
      debugPrint('Error getting issue fast reports: $e');
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<MapEntry<List<SnapReportModel>, bool>, String>> getIssueSnapReports({
    required String issueId,
    String? sort,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final isConnected = await _connectivityService.isConnected();
      if (!isConnected) {
        return Result.failure(
          'No internet connection. Please try again later.',
        );
      }

      final result = await _remoteDataSource.getIssueSnapReports(
        issueId: issueId,
        sort: sort,
        page: page,
        limit: limit,
      );

      return result.when(
        success: (data) => Result.success(data),
        failure: (error) => Result.failure(error.toString()),
      );
    } catch (e) {
      debugPrint('Error getting issue snap reports: $e');
      return Result.failure(e.toString());
    }
  }

  @override
  Future<bool> syncPendingReports() async {
    try {
      final pendingReports = await _localDataSource.getPendingReports();
      if (pendingReports.isEmpty) return true;

      bool allSynced = true;

      for (final report in pendingReports) {
        final result = await _remoteDataSource.submitReport(report);

        await result.when(
          success: (_) async {
            await _localDataSource.markReportAsSynced(report.id!);
          },
          failure: (_) {
            allSynced = false;
          },
        );
      }

      return allSynced;
    } catch (e) {
      return false;
    }
  }

  @override
  ValueListenable<int> watchPendingReportsCount() {
    return _localDataSource.watchPendingReportsCount();
  }

  @override
  ValueListenable<List<SnapReportModel>> watchPendingReports() {
    return _localDataSource.watchPendingReports();
  }

  @override
  Future<Result<MapEntry<List<SnapReportModel>, bool>, String>> getUserReports({
    String? sort,
    String? status,
    String? category,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final isConnected = await _connectivityService.isConnected();
      if (!isConnected) {
        return Result.failure(
          'No internet connection. Please try again later.',
        );
      }
      final result = await _remoteDataSource.getUserReports(
        sort: sort,
        status: status,
        category: category,
        page: page,
        limit: limit,
      );
      // Map ApiErrorModel to String if failure
      return result.when(
        success: (data) => Result.success(data),
        failure: (error) => Result.failure(error.toString()),
      );
    } catch (e) {
      debugPrint('Error getting user reports: $e');
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<ReportStatisticsModel, ApiError>> getReportStatistics() async {
    try {
      final isConnected = await _connectivityService.isConnected();
      if (!isConnected) {
        return Result.failure(
          ApiError(
            message: 'No internet connection. Please try again later.',
            code: 'no_internet',
          ),
        );
      }
      return await _remoteDataSource.getReportStatistics();
    } catch (e) {
      debugPrint('Error getting report statistics: $e');
      return Result.failure(
        ApiError(message: e.toString(), code: 'statistics_error'),
      );
    }
  }
}
