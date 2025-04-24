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

  Stream<Position> onLocationChanged({int minDistance = 10}) {
    return Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: minDistance,
      ),
    );
  }

  Future<bool> checkIfLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  Future<Position?> getLastKnownPosition() async {
    return await Geolocator.getLastKnownPosition();
  }

  Future<bool> checkLocationPermissions({
    required Function(String title, String message) onPermissionDenied,
    required Future<bool> Function() onServiceDisabled,
  }) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      final shouldProceed = await onServiceDisabled();
      if (!shouldProceed) {
        return false;
      }

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return false;
      }
    }

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
