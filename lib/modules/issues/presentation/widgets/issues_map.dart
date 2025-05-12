import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class IssuesMap extends StatelessWidget {
  final CameraPosition initialCameraPosition;
  final bool myLocationEnabled;
  final Set<Marker> markers;
  final Function(GoogleMapController) onMapCreated;
  final Function(CameraPosition) onCameraMove;

  const IssuesMap({
    super.key,
    required this.initialCameraPosition,
    required this.myLocationEnabled,
    required this.markers,
    required this.onMapCreated,
    required this.onCameraMove,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: GoogleMap(
        initialCameraPosition: initialCameraPosition,
        myLocationEnabled: myLocationEnabled,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: false,
        mapType: MapType.hybrid,
        markers: markers,
        onMapCreated: onMapCreated,
        onCameraMove: onCameraMove,
        compassEnabled: false,
      ),
    );
  }
}
