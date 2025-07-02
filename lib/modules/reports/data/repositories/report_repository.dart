import 'package:flutter/foundation.dart';
import 'package:snapnfix/core/core.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_category.dart';
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
          "success_report_saved_offline",
        );
      }

      final result = await _remoteDataSource.submitReport(report);
      return result.when(
        success: (data) {
          return Result.success(
            "success_report_submitted_with_id",
          );
        },
        failure: (error) async {
          await _localDataSource.saveReportOffline(report);
          return Result.failure(
            ApiError(message: 'error_report_saved_offline'),
          );
        },
      );
    } catch (e) {
      return Result.failure(
        ApiError(message: 'error_report_submission_failed', code: 'report_submission_error'),
      );
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
            message: 'error_no_internet_connection',
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
        ApiError(message: 'error_fast_report_failed', code: 'fast_report_error'),
      );
    }
  }

  @override
  Future<Result<MapEntry<List<FastReportModel>, bool>, String>>
  getIssueFastReports({
    required String issueId,
    String? sort,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final isConnected = await _connectivityService.isConnected();
      if (!isConnected) {
        return Result.failure(
          'error_no_internet_connection',
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
      return Result.failure('error_get_reports_failed');
    }
  }

  @override
  Future<Result<MapEntry<List<SnapReportModel>, bool>, String>>
  getIssueSnapReports({
    required String issueId,
    String? sort,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final isConnected = await _connectivityService.isConnected();
      if (!isConnected) {
        return Result.failure(
          'error_no_internet_connection',
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
      return Result.failure('error_get_reports_failed');
    }
  }

  @override
  Future<bool> syncPendingReports() async {
    try {
      final pendingReports = await _localDataSource.getPendingReports();
      if (pendingReports.isEmpty) return true;
      bool allSynced = true;
      for (final SnapReportModel report in pendingReports) {
        SnapReportModel submittedReport = report;
        if (report.state == '' ||
            report.road == '' ||
            report.city == '' ||
            report.country == '') {
          List<String>? address = await getIt<LocationService>()
              .getAddressFromCoordinates(report.latitude, report.longitude);
          submittedReport = report.copyWithModel(
            city: address?[0] ?? '',
            road: address?[1] ?? '',
            state: address?[2] ?? '',
            country: address?[3] ?? '',
          );
        }
        final result = await _remoteDataSource.submitReport(submittedReport);
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
    IssueCategory? category,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final isConnected = await _connectivityService.isConnected();
      if (!isConnected) {
        return Result.failure(
          'error_no_internet_connection',
        );
      }
      final result = await _remoteDataSource.getUserReports(
        sort: sort,
        status: status,
        category: category,
        page: page,
        limit: limit,
      );
      return result.when(
        success: (data) => Result.success(data),
        failure: (error) => Result.failure(error.toString()),
      );
    } catch (e) {
      debugPrint('Error getting user reports: $e');
      return Result.failure('error_get_user_reports_failed');
    }
  }

  @override
  Future<Result<ReportStatisticsModel, ApiError>> getReportStatistics() async {
    try {
      final isConnected = await _connectivityService.isConnected();
      if (!isConnected) {
        return Result.failure(
          ApiError(
            message: 'error_no_internet_connection',
            code: 'no_internet',
          ),
        );
      }
      return await _remoteDataSource.getReportStatistics();
    } catch (e) {
      debugPrint('Error getting report statistics: $e');
      return Result.failure(
        ApiError(message: 'error_get_statistics_failed', code: 'statistics_error'),
      );
    }
  }
}
