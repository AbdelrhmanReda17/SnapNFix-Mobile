import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/core/infrastructure/location/location_permission_handler.dart';
import 'package:snapnfix/core/infrastructure/location/location_service.dart';
import 'package:snapnfix/core/dependency_injection/dependency_injection.dart';
import 'package:snapnfix/modules/reports/presentation/cubits/submit_report_cubit.dart';
import 'package:snapnfix/modules/reports/presentation/utils/report_timeout_manager.dart';
import 'package:snapnfix/modules/reports/presentation/widgets/submit_report/submit_report_app_bar.dart';
import 'package:snapnfix/modules/reports/presentation/widgets/submit_report/submit_report_form.dart';
import 'package:snapnfix/modules/reports/presentation/widgets/submit_report/submit_report_bloc_listener.dart';

class SubmitReportScreen extends StatefulWidget {
  const SubmitReportScreen({super.key});

  @override
  State<SubmitReportScreen> createState() => _SubmitReportScreenState();
}

class _SubmitReportScreenState extends State<SubmitReportScreen> {
  final ReportTimeoutManager _timeoutManager = ReportTimeoutManager();
  late StreamSubscription<TimeoutEvent> _timeoutSubscription;

  @override
  void initState() {
    super.initState();
    _timeoutManager.initialize();
    _setupTimeoutListener();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SubmitReportCubit>().setTimeoutManager(_timeoutManager);
    });
  }

  void _setupTimeoutListener() {
    _timeoutSubscription = _timeoutManager.timeoutStream.listen((event) {
      if (!mounted) return;

      if (event == TimeoutEvent.formReset) {
        _handleTimeoutReset();
      } else if (event == TimeoutEvent.warningShown) {
        _showTimeoutWarning();
      }
    });
  }

  void _handleTimeoutReset() {
    final localization = AppLocalizations.of(context)!;
    context.read<SubmitReportCubit>().resetState();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(localization.sessionTimeoutMessage),
        backgroundColor: Theme.of(context).colorScheme.error,
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: localization.understood,
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  void _showTimeoutWarning() {
    final localization = AppLocalizations.of(context)!;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(localization.createReportTimeWarning),
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          label: localization.dismiss,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timeoutSubscription.cancel();
    _timeoutManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Move AppBar outside of GestureDetector
        SubmitReportAppBar(
          timeoutManager: _timeoutManager,
          onTipsPressed: () {
            // Remove timer reset - just handle tips functionality
            // Timer will be controlled by state changes only
          },
        ),
        Expanded(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onPanDown: (_) {
              // Remove timer reset - timer should not reset on touch
              // Timer is now controlled by state changes only
            },
            child: SubmitReportForm(
              timeoutManager: _timeoutManager,
              onSubmit: () {
                getIt<LocationPermissionHandler>().requestLocationAndExecute(
                  context,
                  onGranted: () async {
                    await context.read<SubmitReportCubit>().submitReport(
                      getIt<LocationService>(),
                    );
                  },
                );
              },
            ),
          ),
        ),
        SubmitReportBlocListener(),
      ],
    );
  }
}
