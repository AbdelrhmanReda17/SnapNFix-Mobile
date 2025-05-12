import 'package:flutter/material.dart';
import 'package:snapnfix/core/infrastructure/location/dialogs/location_required_dialog.dart';
import 'package:snapnfix/core/infrastructure/location/dialogs/open_location_settings_dialog.dart';
import 'package:snapnfix/core/infrastructure/location/location_service.dart';

class LocationPermissionHandler {
  final LocationService _locationService;

  LocationPermissionHandler(this._locationService);

  /// Request location permission and execute callback when granted
  Future<bool> requestLocationAndExecute(
    BuildContext context, {
    required Future<void> Function() onGranted,
    VoidCallback? onDenied,
  }) async {
    final hasPermission = await _checkLocationPermission(
      context,
      onDenied: onDenied,
    );

    if (!hasPermission) {
      return false;
    }

    try {
      await onGranted();
      return true;
    } catch (e) {
      debugPrint('Error executing location-dependent operation: $e');
      return false;
    }
  }

  /// Check if location permission is granted, show dialog if not
  Future<bool> _checkLocationPermission(
    BuildContext context, {
    VoidCallback? onDenied,
  }) async {
    final hasPermission = await _locationService.checkLocationPermissions(
      onPermissionDenied: (title, permanent) {
        debugPrint('Location permission denied: $title');
        debugPrint('Permanent: $permanent');
        if (permanent) {
          _showOpenSettingsDialog(context);
        } else {
          _showLocationRequiredDialog(context);
        }

        if (onDenied != null) {
          onDenied();
        }
      },
      onServiceDisabled: () async {
        final shouldOpenSettings = await _showOpenSettingsDialog(context);
        if (shouldOpenSettings) {
          await _locationService.openLocationSettings();
        }
        return shouldOpenSettings;
      },
    );

    return hasPermission;
  }

  /// Show dialog to open location settings
  Future<bool> _showOpenSettingsDialog(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => OpenLocationSettingsDialog(
        onOpenSettings: () => _locationService.openLocationSettings(),
      ),
    );

    return result ?? false;
  }

  /// Show dialog explaining why location is needed
  Future<bool> _showLocationRequiredDialog(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => LocationRequiredDialog(
        onOpenSettings: () => _locationService.openAppSettings(),
      ),
    );

    return result ?? false;
  }
}
