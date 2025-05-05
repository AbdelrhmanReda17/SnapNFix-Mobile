import 'dart:io';

import 'package:flutter/material.dart';
import 'package:snapnfix/core/infrastructure/connectivity/connectivity_service.dart';
import 'package:snapnfix/core/infrastructure/networking/api_error_handler.dart';
import 'package:snapnfix/core/infrastructure/networking/api_error_model.dart';
import 'package:snapnfix/core/infrastructure/networking/api_result.dart';
import 'package:snapnfix/modules/reports/data/datasource/report_local_data_source.dart';
import 'package:snapnfix/modules/reports/data/datasource/report_remote_data_source.dart';
import 'package:snapnfix/modules/reports/data/model/report_model.dart';
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
  Future<ApiResult<ReportModel>> autoCategorizeImage(File imageFile) async {
    try {
      final isConnected = await _connectivityService.isConnected();

      if (!isConnected) {
        return ApiResult.failure(
          ApiErrorModel(message: 'No internet connection'),
        );
      }
      final result = await _remoteDataSource.autoCategorizeImage(imageFile);
      return result.when(
        success: (data) {
          return ApiResult.success(data);
        },
        failure: (error) {
          return ApiResult.failure(error);
        },
      );
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  @override
  Future<List<ReportModel>> getPendingReports() {
    try {
      return _localDataSource.getPendingReports();
    } catch (e) {
      return Future.error(ApiErrorHandler.handle(e));
    }
  }

  @override
  int getPendingReportsCount() {
    return _localDataSource.getPendingReportsCount();
  }

  @override
  Future<ApiResult<String>> submitReport(ReportModel report) async {
    try {
      final isConnected = await _connectivityService.isConnected();
      if (!isConnected) {
        await _localDataSource.saveReportOffline(report);
        return const ApiResult.success(
          'Report saved offline and will be submitted when online',
        );
      }

      final result = await _remoteDataSource.submitReport(report);
      return result.when(
        success: (data) {
          _localDataSource.saveReportOffline(report);
          return ApiResult.success(data);
        },
        failure: (error) {
          _localDataSource.saveReportOffline(report);
          return ApiResult.failure(error);
        },
      );
    } catch (e) {
      debugPrint('Error submitting report: $e');
      try {
        await _localDataSource.saveReportOffline(report);
        return const ApiResult.success(
          'Report saved offline due to error',
        );
      } catch (saveError) {
        return ApiResult.failure(ApiErrorHandler.handle(saveError));
      }
    }
  }

  @override
  Future<bool> syncPendingReports() async {
    try {
      final pendingReportsCount = _localDataSource.getPendingReportsCount();
      if (pendingReportsCount == 0) {
        return true;
      }
      final pendingReports = await _localDataSource.getPendingReports();
      final isConnected = await _connectivityService.isConnected();
      if (!isConnected) return false;
      var allSuccessful = true;
      for (var report in pendingReports) {
        final result = await _remoteDataSource.submitReport(report);
        await result.when(
          success: (data) async {
            debugPrint('✅ Report submitted successfully: $data');
            await _localDataSource.deleteOfflineReport(report.id);
            _localDataSource.decrementPendingReportsCount();
          },
          failure: (error) {
            debugPrint('❌ Failed to submit report: ${error.message}');
            allSuccessful = false;
          },
        );
      }
      return allSuccessful;
    } catch (e) {
      return Future.error(ApiErrorHandler.handle(e));
    }
  }

  @override
  Stream<int> watchPendingReportsCount() {
    try {
      return _localDataSource.watchPendingReportsCount();
    } catch (e) {
      return Stream.error(ApiErrorHandler.handle(e));
    }
  }

  @override
  Stream<List<ReportModel>> watchPendingReports() {
    try {
      return _localDataSource.watchPendingReports();
    } catch (e) {
      return Stream.error(ApiErrorHandler.handle(e));
    }
  }
}
