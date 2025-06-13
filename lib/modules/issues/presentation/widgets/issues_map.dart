import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class IssuesMap extends StatefulWidget {
  final CameraPosition initialCameraPosition;
  final bool myLocationEnabled;
  final Set<Marker> markers;
  final Function(GoogleMapController) onMapCreated;
  final Function(CameraPosition) onCameraMove;
  final Function(LatLngBounds) onBoundsChange;
  final MinMaxZoomPreference? minMaxZoomPreference;
  final CameraTargetBounds? cameraTargetBounds;

  const IssuesMap({
    super.key,
    required this.initialCameraPosition,
    required this.myLocationEnabled,
    required this.markers,
    required this.onMapCreated,
    required this.onCameraMove,
    required this.onBoundsChange,
    this.minMaxZoomPreference,
    this.cameraTargetBounds,
  });

  @override
  State<IssuesMap> createState() => _IssuesMapState();
}

class _IssuesMapState extends State<IssuesMap> {
  GoogleMapController? _controller;
  bool _boundsUpdateScheduled = false;
  LatLngBounds? _previousBounds;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: GoogleMap(
        initialCameraPosition: widget.initialCameraPosition,
        myLocationEnabled: widget.myLocationEnabled,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: false,
        mapType: MapType.hybrid,
        markers: widget.markers,
        onMapCreated: _onMapCreated,
        onCameraMove: widget.onCameraMove,
        onCameraIdle: _onCameraIdle,
        compassEnabled: false,
        minMaxZoomPreference:
            widget.minMaxZoomPreference ?? const MinMaxZoomPreference(5, 18),
        cameraTargetBounds:
            widget.cameraTargetBounds ?? CameraTargetBounds.unbounded,
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
    widget.onMapCreated(controller);

    _scheduleBoundsUpdate();
  }

  void _onCameraIdle() {
    _scheduleBoundsUpdate();
  }

  void _scheduleBoundsUpdate() {
    if (_boundsUpdateScheduled || _controller == null) return;

    _boundsUpdateScheduled = true;

    Future.delayed(const Duration(milliseconds: 500), () {
      _boundsUpdateScheduled = false;
      _updateBounds();
    });
  }

  Future<void> _updateBounds() async {
    if (_controller == null) return;

    final LatLngBounds bounds = await _controller!.getVisibleRegion();

    // Only trigger bounds change if it's the first update or bounds have changed significantly
    if (_previousBounds == null ||
        _boundsChangedSignificantly(_previousBounds!, bounds)) {
      _previousBounds = bounds;
      widget.onBoundsChange(bounds);
    }
  }

  bool _boundsChangedSignificantly(
    LatLngBounds previous,
    LatLngBounds current,
  ) {
    const threshold = 0.0001;
    return (previous.northeast.latitude - current.northeast.latitude).abs() >
            threshold ||
        (previous.northeast.longitude - current.northeast.longitude).abs() >
            threshold ||
        (previous.southwest.latitude - current.southwest.latitude).abs() >
            threshold ||
        (previous.southwest.longitude - current.southwest.longitude).abs() >
            threshold;
  }
}
