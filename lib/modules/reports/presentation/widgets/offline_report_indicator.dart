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
  int? _initialPendingCount;

  @override
  void initState() {
    super.initState();
    _setupConnectivityMonitoring();
    _checkInitialPendingCount();
  }

  void _checkInitialPendingCount() {
    final count = getIt<GetPendingReportsCountUseCase>().call();
    if (mounted) {
      setState(() {
        _initialPendingCount = count;
      });
    }
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

  Future<void> _syncReports() async {
    if (_isSyncing) return;
    setState(() {
      _isSyncing = true;
    });
    final syncPendingReports = getIt<SyncPendingReportsUseCase>();

    try {
      final result = await syncPendingReports.call();

      if (mounted) {
        BaseToast.show(
          context: context,
          message: result ? 'Reports synced!' : 'Some reports failed',
          type: result ? ToastType.success : ToastType.warning,
        );
      }
    } catch (e) {
      if (mounted) {
        BaseToast.show(
          context: context,
          message: 'Syncing failed',
          type: ToastType.error,
        );
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
          child: Container(
            decoration: BoxDecoration(
              color: colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            margin: EdgeInsets.only(bottom: 16.h),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _isSyncing
                    ? SizedBox(
                      width: 20.sp,
                      height: 20.sp,
                      child: CircularProgressIndicator(
                        color: colorScheme.primary,
                        strokeWidth: 2.w,
                      ),
                    )
                    : Icon(
                      Icons.cloud_upload_outlined,
                      size: 20.sp,
                      color: colorScheme.primary,
                    ),
                SizedBox(width: 8.w),
                Text(
                  _isSyncing ? 'Syncing reports' : '$count Offline Reports',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w500,
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),
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
