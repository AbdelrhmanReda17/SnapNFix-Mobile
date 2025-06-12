import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

@singleton
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

  Future<List<String>?> getAddressFromCoordinates(
    double latitude,
    double longitude,
  ) async {
    try {
      final placemarks = await geocoding.placemarkFromCoordinates(
        latitude,
        longitude,
      );
      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;
        return [
          placemark.street ?? '',
          placemark.subAdministrativeArea ?? '',
          // placemark.locality ?? '',
          placemark.administrativeArea ?? '',
          placemark.country ?? '',
        ].where((element) => element.isNotEmpty).toList();
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<bool> checkIfLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  Future<Position?> getLastKnownPosition() async {
    return await Geolocator.getLastKnownPosition();
  }

  Future<bool> hasLocationPermission() async {
    final permission = await Geolocator.checkPermission();
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  Future<bool> checkLocationPermissions({
    Function(String title, bool permanent)? onPermissionDenied,
    Future<bool> Function()? onServiceDisabled,
  }) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (onServiceDisabled != null) {
        final shouldProceed = await onServiceDisabled();
        if (!shouldProceed) {
          return false;
        }
      } else {
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
        if (onPermissionDenied != null) {
          onPermissionDenied('Location Permission Denied', false);
        }
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (onPermissionDenied != null) {
        onPermissionDenied('Location Permission Denied', true);
      }
      return false;
    }

    return true;
  }

  Future<void> openLocationSettings() async {
    await Geolocator.openLocationSettings();
  }

  Future<void> appLocationSettings() async {
    await Geolocator.openAppSettings();
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
