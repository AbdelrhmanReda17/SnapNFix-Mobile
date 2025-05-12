import 'dart:async';

import 'package:flutter/material.dart';
import 'package:snapnfix/core/base_components/base_alert.dart';
import 'package:snapnfix/core/dependency_injection/dependency_injection.dart';
import 'package:snapnfix/core/infrastructure/location/location_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<bool> applicationOpenLocationSettingsDialog({
  required final String title,
  required final String message,
  required final BuildContext context,
  Function()? onCancel,
  final AppLocalizations? localization,
}) {
  final completer = Completer<bool>();
  baseDialog(
    context: context,
    title: localization?.locationRequired ?? 'Location Required',
    message:
        localization?.locationRequiredMessageWithNewLine ??
        'Location services are disabled.\nTo submit a report, please enable location services.',
    alertType: AlertType.info,
    confirmText: localization?.enableLocation ?? 'Enable',
    onConfirm: () {
      getIt<LocationService>().openLocationSettings();
      completer.complete(true);
    },
    cancelText: localization?.cancel ?? 'Cancel',
    onCancel: () {
      if (onCancel != null) onCancel();
      completer.complete(false);
    },
  );
  return completer.future;
}
