import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/base_components/base_toast.dart';
import 'package:snapnfix/core/dependency_injection/dependency_injection.dart';
import 'package:snapnfix/core/infrastructure/connectivity/connectivity_service.dart';
import 'package:snapnfix/modules/reports/domain/usecases/get_pending_reports_count_use_case.dart';
import 'package:snapnfix/modules/reports/domain/usecases/sync_prending_reports_use_case.dart';
import 'package:snapnfix/modules/reports/domain/usecases/watch_pending_reports_count_use_case.dart';

class OfflineReportIndicator extends StatefulWidget {
  const OfflineReportIndicator({super.key});

  @override
  State<OfflineReportIndicator> createState() => _OfflineReportIndicatorState();
}

class _OfflineReportIndicatorState extends State<OfflineReportIndicator> {
  StreamSubscription? _connectivitySubscription;
  bool _isSyncing = false;
  final ConnectivityService _connectivityService = getIt<ConnectivityService>();
  final GetPendingReportsCountUseCase _getpendingReportsUseCase =
      getIt<GetPendingReportsCountUseCase>();
  int? _initialPendingCount;

  @override
  void initState() {
    super.initState();
    _setupConnectivityMonitoring();
    _checkInitialPendingCount();
  }

  void _checkInitialPendingCount() {
    setState(() {
      _initialPendingCount = _getpendingReportsUseCase.call();
    });
  }

  void _setupConnectivityMonitoring() {
    _connectivityService.monitorConnectivity(
      onStatusChanged: (isConnected) {
        if (isConnected) {
          _checkAndSyncPendingReports();
        }
      },
    );
  }

  Future<void> _checkAndSyncPendingReports() async {
    final pendingCount = getIt<GetPendingReportsCountUseCase>().call();
    if (pendingCount > 0 && !_isSyncing) {
      _syncReports();
    }
  }

  void _showReportSyncingToast(bool result) {
    BaseToast.show(
      context: context,
      message: result ? 'Reports synced successfully' : 'Report Syncing failed',
      type: result ? ToastType.success : ToastType.warning,
    );
  }

  Future<void> _syncReports() async {
    if (_isSyncing) return;
    setState(() {
      _isSyncing = true;
    });
    final syncPendingReports = getIt<SyncPendingReportsUseCase>();

    try {
      final result = await syncPendingReports.call();
      result.when(
        success: (bool result) {
          if (mounted) {
            _showReportSyncingToast(result);
          }
        },
        failure: (error) {
          if (mounted) {
            _showReportSyncingToast(false);
          }
        },
      );
    } catch (e) {
      if (mounted) {
        _showReportSyncingToast(false);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSyncing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final watchPendingReportsCount = getIt<WatchPendingReportsCountUseCase>();
    final colorScheme = Theme.of(context).colorScheme;

    void showToast(String message, ToastType type) {
      BaseToast.show(context: context, message: message, type: type);
    }

    return StreamBuilder<int>(
      stream: watchPendingReportsCount.call(),
      initialData: _initialPendingCount ?? 0,
      builder: (context, snapshot) {
        final count = snapshot.data ?? _initialPendingCount ?? 0;
        if (count == 0) {
          return const SizedBox.shrink();
        }
        return GestureDetector(
          onTap: () async {
            final isConnected = await _connectivityService.isConnected();
            if (!isConnected) {
              showToast('No internet connection', ToastType.error);
              return;
            }
            if (_isSyncing) {
              showToast('Syncing in progress', ToastType.info);
              return;
            }
            _syncReports();
          },
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: _isSyncing 
                  ? SizedBox(
                      width: 24.sp,
                      height: 24.sp,
                      child: CircularProgressIndicator(
                        color: colorScheme.primary,
                        strokeWidth: 2.w,
                      ),
                    )
                  : Icon(
                      Icons.cloud_upload_outlined,
                      size: 24.sp,
                      color: colorScheme.primary,
                    ),
              ),
              if (count > 0)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.all(4.r),
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      count > 99 ? '99+' : count.toString(),
                      style: TextStyle(
                        color: colorScheme.onPrimary,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    super.dispose();
  }
}

enum MessageType { info, success, error, warning }
