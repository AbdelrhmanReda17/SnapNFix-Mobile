import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/base_components/base_button.dart';
import 'package:snapnfix/core/dependency_injection/dependency_injection.dart';
import 'package:snapnfix/core/infrastructure/location/location_service.dart';
import 'package:snapnfix/modules/reports/presentation/cubits/submit_report_cubit.dart';
import 'package:snapnfix/modules/reports/presentation/widgets/submit_additional_info.dart';
import 'package:snapnfix/modules/reports/presentation/widgets/submit_photo_picker.dart';
import 'package:snapnfix/modules/reports/presentation/widgets/submit_report_bloc_listener.dart';
import 'package:snapnfix/modules/reports/presentation/widgets/submit_report_note.dart';
import 'package:snapnfix/modules/reports/presentation/widgets/submit_report_tips.dart';
import 'package:snapnfix/modules/reports/presentation/widgets/submit_severity_selector.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/presentation/dialogs/location/handle_location_permission_and_execute.dart';
import 'package:snapnfix/presentation/dialogs/location/location_required_dialog.dart';
import 'package:snapnfix/presentation/dialogs/location/open_location_settings_dialog.dart';
import 'package:visibility_detector/visibility_detector.dart';

class SubmitReportScreen extends StatelessWidget {
  const SubmitReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;
    final localization = AppLocalizations.of(context);
    return VisibilityDetector(
      key: const Key('submit_report_screen_visibility'),
      onVisibilityChanged: (visibilityInfo) {
        if (visibilityInfo.visibleFraction < 0.1) {
          final cubit = context.read<SubmitReportCubit>();
          cubit.resetState();
          debugPrint(
            'Submit report state reset due to screen becoming invisible',
          );
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBar(
            backgroundColor: colorScheme.surface,
            automaticallyImplyLeading: false,
            titleSpacing: 0,
            centerTitle: true,
            title: Text(
              "Report an Incident",
              style: textStyles.headlineLarge?.copyWith(
                fontSize: 20.sp,
                color: colorScheme.primary,
              ),
            ),
            actions: [SubmitReportTips()],
            elevation: 0,
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
              children: [
                SubmitPhotoPicker(),
                SizedBox(height: 10.h),
                SubmitSeveritySelector(),
                SizedBox(height: 10.h),
                SubmitAdditionalDetails(),
                SizedBox(height: 10.h),
                SubmitReportNote(),
                SizedBox(height: 10.h),
                BlocBuilder<SubmitReportCubit, SubmitReportState>(
                  builder: (context, state) {
                    return BaseButton(
                      isEnabled: state.image != null,
                      onPressed: () {
                        handleLocationPermissionAndExecute(
                          context: context,
                          onLocationGranted: (locationService) async {
                            await context
                                .read<SubmitReportCubit>()
                                .submitReport(locationService);
                          },
                        );
                      },
                      text: localization?.submitReport ?? 'Submit Report',
                      textStyle: textStyles.bodyLarge!.copyWith(
                        color: colorScheme.surface,
                        fontWeight: FontWeight.bold,
                      ),
                      backgroundColor: colorScheme.primary,
                      borderColor: Colors.transparent,
                    );
                  },
                ),
              ],
            ),
          ),
          SubmitReportBlocListener(),
        ],
      ),
    );
  }

  Future<void> getLocationAndSubmit(
    SubmitReportCubit cubit,
    BuildContext context,
  ) async {
    final localization = AppLocalizations.of(context);
    final locationService = getIt<LocationService>();
    final hasPermission = await locationService.checkLocationPermissions(
      onPermissionDenied: (title, message) {
        return applicationLocationRequiredDialog(
          title: title,
          message: message,
          context: context,
          localization: localization,
        );
      },
      onServiceDisabled: () {
        return applicationOpenLocationSettingsDialog(
          title: localization?.locationRequired ?? 'Location Required',
          message:
              'Location services are disabled.\nTo submit a report, please enable location services.',
          context: context,
          localization: localization,
        );
      },
    );
    if (!hasPermission) return;
    try {
      await cubit.submitReport(locationService);
    } catch (e) {
      log('Error submitting report: $e');
    }
  }
}
