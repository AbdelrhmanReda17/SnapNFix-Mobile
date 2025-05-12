import 'package:flutter/material.dart';
import 'package:snapnfix/core/base_components/base_alert.dart';
import 'package:snapnfix/core/dependency_injection/dependency_injection.dart';
import 'package:snapnfix/core/infrastructure/location/location_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void applicationLocationRequiredDialog({
  required final String title,
  required final String message,
  required final BuildContext context,
  final AppLocalizations? localization,
}) {
  return baseDialog(
    context: context,
    title: title,
    message: message,
    alertType: AlertType.error,
    confirmText: localization?.errorPermissionActionText ?? 'Open Settings',
    onConfirm: () => getIt<LocationService>().openAppSettings(),
    showCancelButton: false,
  );
}
