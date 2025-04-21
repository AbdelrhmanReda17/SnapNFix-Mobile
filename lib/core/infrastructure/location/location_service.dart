import 'package:geolocator/geolocator.dart';

class LocationService {
  static final LocationService _instance = LocationService._internal();

  factory LocationService() => _instance;

  LocationService._internal();

  Future<Position> getCurrentPosition() async {
    return await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    );
  }

  Future<Position?> getLastKnownPosition() async {
    return await Geolocator.getLastKnownPosition();
  }

  Future<bool> checkLocationPermissions({
    required Function(String title, String message) onPermissionDenied,
    required Future<bool> Function() onServiceDisabled,
  }) async {
    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Show dialog asking user to enable location services
      final shouldProceed = await onServiceDisabled();
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
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        onPermissionDenied(
          'Location Permission Denied',
          'Location permission is required to submit a report.',
        );
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      onPermissionDenied(
        'Location Permission Denied',
        'Location permissions are permanently denied. Please enable them in settings.',
      );
      return false;
    }

    return true;
  }

  Future<void> openLocationSettings() async {
    await Geolocator.openLocationSettings();
  }

  double calculateDistance(
    double startLat,
    double startLng,
    double endLat,
    double endLng,
  ) {
    return Geolocator.distanceBetween(startLat, startLng, endLat, endLng);
  }

  Future<void> openAppSettings() async {
    await Geolocator.openAppSettings();
  }

  String getFormattedLocation(Position position) {
    return '${position.latitude.toStringAsFixed(6)}, ${position.longitude.toStringAsFixed(6)}';
  }
}
