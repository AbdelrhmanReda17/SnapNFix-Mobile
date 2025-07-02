import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/core/dependency_injection/dependency_injection.dart';
import 'package:snapnfix/core/infrastructure/location/location_service.dart';

class NoLocationPermissionScreen extends StatelessWidget {
  final VoidCallback? onRetry;

  const NoLocationPermissionScreen({super.key, this.onRetry});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final localization = AppLocalizations.of(context)!;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.location_off, size: 80, color: colorScheme.primary),
              const SizedBox(height: 24),
              Text(
                localization.locationPermissionRequiredTitle,
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                localization.locationPermissionRequiredMessage,
                style: textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () async {
                  await getIt<LocationService>().openAppSettings();
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: colorScheme.onPrimary,
                  backgroundColor: colorScheme.primary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                ),
                child: Text(localization.openSettings),
              ),
              if (onRetry != null) ...[
                const SizedBox(height: 16),
                TextButton(onPressed: onRetry, child: Text(localization.retry)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
