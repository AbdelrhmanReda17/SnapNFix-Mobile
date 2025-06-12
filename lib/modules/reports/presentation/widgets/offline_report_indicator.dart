import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/base_components/base_toast.dart';
import 'package:snapnfix/core/dependency_injection/dependency_injection.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _setupConnectivityMonitoring();
      }
    });
  }

  void _setupConnectivityMonitoring() {
    _connectivityService.monitorConnectivity(
      onStatusChanged: (isConnected) {
        if (isConnected && mounted) {
          _checkAndSyncPendingReports();
        }
      },
    );
  }

  Future<void> _checkAndSyncPendingReports() async {
    if (!mounted) return;

    final pendingCount = getIt<GetPendingReportsCountUseCase>().call();
    if (pendingCount > 0 && !_isSyncing && mounted) {
      _syncReports();
    }
  }

  void _showReportSyncingToast(bool result) {
    if (!mounted) return;

    BaseToast.show(
      context: context,
      message:
          result
              ? AppLocalizations.of(context)!.reportsSynced
              : AppLocalizations.of(context)!.someReportsFailed,
      type: result ? ToastType.success : ToastType.warning,
    );
  }

  Future<void> _syncReports() async {
    if (_isSyncing || !mounted) return;
    setState(() {
      _isSyncing = true;
    });
    final syncPendingReports = getIt<SyncPendingReportsUseCase>();

    try {
      final result = await syncPendingReports.call();
      if (!mounted) return;
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
    final localization = AppLocalizations.of(context)!;

    void showToast(String message, ToastType type) {
      if (mounted) {
        BaseToast.show(context: context, message: message, type: type);
      }
    }

    return ValueListenableBuilder<int>(
      valueListenable: watchPendingReportsCount.call(),
      builder: (context, count, child) {
        if (count == 0) {
          return const SizedBox.shrink();
        }
        return GestureDetector(
          onTap: () async {
            if (!mounted) return;

            final isConnected = await _connectivityService.isConnected();

            if (!mounted) return;

            if (!isConnected) {
              showToast(localization.noInternetConnection, ToastType.error);
              return;
            }
            if (_isSyncing) {
              showToast(localization.syncingInProgress, ToastType.info);
              return;
            }
            _syncReports();
          },
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 8.w),
                child:
                    _isSyncing
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
