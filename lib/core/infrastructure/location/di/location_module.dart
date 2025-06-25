import 'package:injectable/injectable.dart';
import 'package:snapnfix/core/infrastructure/location/location_permission_handler.dart';
import 'package:snapnfix/core/infrastructure/location/location_service.dart';

@module
abstract class LocationModule {
  @lazySingleton
  LocationPermissionHandler provideLocationPermissionHandler(
    LocationService locationService,
  ) => LocationPermissionHandler(locationService);
}