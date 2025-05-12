import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocationRequiredDialog extends StatelessWidget {
  final VoidCallback? onOpenSettings;
  final String? message;

  const LocationRequiredDialog({this.onOpenSettings, super.key, this.message});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);

    return AlertDialog(
      title: Text(localization?.locationRequired ?? 'Location Required'),
      content: Text(
        message ??
            'Location services are disabled.\nTo submit a report, please enable location services.',
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (onOpenSettings != null) {
              onOpenSettings!();
            }
            Navigator.of(context).pop(true);
          },
          child: Text('Open Settings'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(localization?.cancel ?? 'Cancel'),
        ),
      ],
    );
  }
}
