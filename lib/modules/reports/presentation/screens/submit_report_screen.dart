import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  }

  void _setupTimeoutListener() {
    _timeoutSubscription = _timeoutManager.timeoutStream.listen((event) {
      if (event == TimeoutEvent.formReset) {
        setState(() {
          context.read<SubmitReportCubit>().resetState();
          _timeoutManager.initialize();
        });
      }
    });
  }

  @override
  void dispose() {
    _timeoutSubscription.cancel();
    _timeoutManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: _timeoutManager.resetTimer,
      onPanDown: (_) => _timeoutManager.resetTimer(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SubmitReportAppBar(
            timeoutManager: _timeoutManager,
            onTipsPressed: _timeoutManager.resetTimer,
          ),
          Expanded(
            child: SubmitReportForm(
              timeoutManager: _timeoutManager,
              onSubmit: () {
                _timeoutManager.resetTimer();
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
          SubmitReportBlocListener(),
        ],
      ),
    );
  }
}
