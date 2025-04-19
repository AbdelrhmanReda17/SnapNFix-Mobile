import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/core/base_components/base_alert.dart';
import 'package:snapnfix/core/base_components/base_button.dart';
import 'package:snapnfix/features/reports/logic/cubit/add_report_cubit.dart';
import 'package:snapnfix/features/reports/presentation/widgets/add_report_bloc_listener.dart';
import 'package:snapnfix/features/reports/presentation/widgets/additional_details.dart';
import 'package:snapnfix/features/reports/presentation/widgets/info_tip.dart';
import 'package:snapnfix/features/reports/presentation/widgets/note.dart';
import 'package:snapnfix/features/reports/presentation/widgets/severity_selector.dart';
import 'package:snapnfix/features/reports/presentation/widgets/take_photo.dart';

class AddReportScreen extends StatelessWidget {
  const AddReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final localization = AppLocalizations.of(context);
    final textStyles = Theme.of(context).textTheme;
    final cubit = context.read<AddReportCubit>();

    void showLocationPermissionErrorDialog(String title, String message) {
      baseDialog(
        context: context,
        title: 'Location Permission Denied',
        message:
            AppLocalizations.of(context)?.locationPermissionPermanentlyDenied ??
            'Location permissions are permanently denied. Please enable them in settings.',
        alertType: AlertType.error,
        confirmText: 'Got it',
        onConfirm: () => openAppSettings(),
        showCancelButton: false,
      );
    }

    Future<bool> showLocationServiceDisabledDialog() async {
      final completer = Completer<bool>();

      baseDialog(
        context: context,
        title: localization?.locationRequired ?? 'Location Required',
        message:
            'Location services are disabled.\nTo submit a report, please enable location services.',
        alertType: AlertType.info,
        confirmText: localization?.enableLocation ?? 'Enable',
        onConfirm: () {
          Geolocator.openLocationSettings();
          completer.complete(true);
        },
        cancelText: localization?.cancel ?? 'Cancel',
        onCancel: () {
          completer.complete(false);
        },
      );

      return completer.future;
    }

    Future<bool> handleLocationPermission() async {
      bool serviceEnabled;
      LocationPermission permission;

      // Test if location services are enabled
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Show dialog asking user to enable location services
        final shouldProceed = await showLocationServiceDisabledDialog();
        if (!shouldProceed) {
          return false;
        }

        // Check again after user action
        serviceEnabled = await Geolocator.isLocationServiceEnabled();
        if (!serviceEnabled) {
          return false; // User didn't enable location services
        }
      }

      // Check location permissions
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          showLocationPermissionErrorDialog(
            localization?.locationPermissionDenied ??
                'Location Permission Denied',
            localization?.locationRequiredMessage ??
                'Location services are disabled. To submit a report, please enable location services.',
          );
          return false;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        showLocationPermissionErrorDialog(
          localization?.locationPermissionDenied ??
              'Location Permission Denied',
          localization?.locationPermissionPermanentlyDenied ??
              'Location permissions are permanently denied. Please enable them in settings.',
        );
        return false;
      }

      return true;
    }

    Future<void> getLocationAndSubmit() async {
      final hasPermission = await handleLocationPermission();
      if (!hasPermission) {
        return;
      }

      try {
        if (cubit.positionNotifier.value == null) {
          await cubit.getCurrentPosition();
        }
        // Submit the report
        await cubit.submitReport();
      } catch (e) {
        log('Error submitting report: $e');
      }
    }

    Future<void> submitReport() async {
      await getLocationAndSubmit();
    }

    return Column(
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
          actions: [InfoTip()],
          elevation: 0,
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
            children: [
              TakePhoto(),
              SizedBox(height: 10.h),
              SeveritySelector(),
              SizedBox(height: 10.h),
              AdditionalDetails(),
              SizedBox(height: 10.h),
              Note(),
              SizedBox(height: 10.h),
              BaseButton(
                onPressed: () {
                  submitReport();
                },
                text: localization?.submitReport ?? 'Submit Report',
                textStyle: textStyles.bodyLarge!.copyWith(
                  color: colorScheme.surface,
                  fontWeight: FontWeight.bold,
                ),
                backgroundColor: colorScheme.primary,
                borderColor: Colors.transparent,
              ),
            ],
          ),
        ),
        AddReportBlocListener(),
      ],
    );
  }
}
