import 'package:flutter/material.dart';
import 'package:snapnfix/core/dependency_injection/dependency_injection.dart';
import 'package:snapnfix/core/infrastructure/location/location_service.dart';
import 'package:snapnfix/presentation/dialogs/location/location_required_dialog.dart';
import 'package:snapnfix/presentation/dialogs/location/open_location_settings_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<bool> handleLocationPermissionAndExecute({
  required BuildContext context,
  required Future<void> Function(LocationService locationService)
  onLocationGranted,
  void Function(String, String)? onLocationDenied,
  Function? onCancel,
}) async {
  final localization = AppLocalizations.of(context);
  final locationService = getIt<LocationService>();

  final hasPermission = await locationService.checkLocationPermissions(
    onPermissionDenied:
        onLocationDenied ??
        (title, message) {
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
        message: localization?.locationRequiredMessageWithNewLine ?? 'Location services are disabled.\nTo submit a report, please enable location services.',
        context: context,
        localization: localization,
        onCancel: () {
          if (onCancel != null) onCancel();
        },
      );
    },
  );
  if (!hasPermission) {
    return false;
  }
  try {
    await onLocationGranted(locationService);
    return true;
  } catch (e) {
    debugPrint('Error executing location-dependent operation: $e');
    return false;
  }
}
