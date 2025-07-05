import 'dart:async';

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
  Timer? _boundsUpdateTimer;
  LatLngBounds? _previousBounds;
  DateTime? _lastBoundsUpdate;

  static const Duration _boundsUpdateDelay = Duration(milliseconds: 500);
  static const Duration _minTimeBetweenBoundsUpdates = Duration(
    milliseconds: 800,
  );

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: GoogleMap(
        initialCameraPosition: widget.initialCameraPosition,
        myLocationEnabled: widget.myLocationEnabled,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: true,
        mapType: MapType.hybrid,
        markers: widget.markers,
        onMapCreated: _onMapCreated,
        onCameraMove: widget.onCameraMove,
        onCameraIdle: _onCameraIdle,
        compassEnabled: true,
        minMaxZoomPreference:
            widget.minMaxZoomPreference ??
            const MinMaxZoomPreference(5.0, 12.0),
        cameraTargetBounds:
            widget.cameraTargetBounds ?? CameraTargetBounds.unbounded,
        mapToolbarEnabled: false,
        rotateGesturesEnabled: true,
        scrollGesturesEnabled: true,
        tiltGesturesEnabled: false,
        zoomGesturesEnabled: true,
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
    widget.onMapCreated(controller);

    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        _scheduleBoundsUpdate();
      }
    });
  }

  void _onCameraIdle() {
    _scheduleBoundsUpdate();
  }

  void _scheduleBoundsUpdate() {
    if (_controller == null || !mounted) return;

    _boundsUpdateTimer?.cancel();

    final now = DateTime.now();
    if (_lastBoundsUpdate != null &&
        now.difference(_lastBoundsUpdate!) < _minTimeBetweenBoundsUpdates) {
      _boundsUpdateTimer = Timer(_minTimeBetweenBoundsUpdates, () {
        if (mounted) {
          _updateBounds();
        }
      });
      return;
    }

    _boundsUpdateTimer = Timer(_boundsUpdateDelay, () {
      if (mounted) {
        _updateBounds();
      }
    });
  }

  Future<void> _updateBounds() async {
    if (_controller == null || !mounted) return;

    try {
      final LatLngBounds bounds = await _controller!.getVisibleRegion();

      if (_previousBounds == null ||
          _boundsChangedSignificantly(_previousBounds!, bounds)) {
        _previousBounds = bounds;
        _lastBoundsUpdate = DateTime.now();

        debugPrint('Bounds changed significantly, triggering update');
        widget.onBoundsChange(bounds);
      } else {
        debugPrint('Bounds change not significant enough, skipping update');
      }
    } catch (e) {
      debugPrint('Error getting visible region: $e');
    }
  }

  bool _boundsChangedSignificantly(
    LatLngBounds previous,
    LatLngBounds current,
  ) {
    final prevCenterLat =
        (previous.northeast.latitude + previous.southwest.latitude) / 2;
    final prevCenterLng =
        (previous.northeast.longitude + previous.southwest.longitude) / 2;
    final currCenterLat =
        (current.northeast.latitude + current.southwest.latitude) / 2;
    final currCenterLng =
        (current.northeast.longitude + current.southwest.longitude) / 2;

    final centerLatDiff = (prevCenterLat - currCenterLat).abs();
    final centerLngDiff = (prevCenterLng - currCenterLng).abs();

    final boundsWidth =
        current.northeast.longitude - current.southwest.longitude;
    final boundsHeight =
        current.northeast.latitude - current.southwest.latitude;

    final dynamicThreshold = 0.1;
    final latThreshold = boundsHeight * dynamicThreshold;
    final lngThreshold = boundsWidth * dynamicThreshold;

    final prevBoundsArea =
        (previous.northeast.latitude - previous.southwest.latitude) *
        (previous.northeast.longitude - previous.southwest.longitude);
    final currBoundsArea =
        (current.northeast.latitude - current.southwest.latitude) *
        (current.northeast.longitude - current.southwest.longitude);

    final areaChangePercent =
        (prevBoundsArea - currBoundsArea).abs() / prevBoundsArea;

    final centerMoved =
        centerLatDiff > latThreshold || centerLngDiff > lngThreshold;
    final zoomChanged = areaChangePercent > 0.15;

    debugPrint(
      'Bounds check - Center moved: $centerMoved, Zoom changed: $zoomChanged',
    );
    debugPrint(
      '  - Center diff: lat=${centerLatDiff.toStringAsFixed(6)}, lng=${centerLngDiff.toStringAsFixed(6)}',
    );
    debugPrint(
      '  - Threshold: lat=${latThreshold.toStringAsFixed(6)}, lng=${lngThreshold.toStringAsFixed(6)}',
    );
    debugPrint(
      '  - Area change: ${(areaChangePercent * 100).toStringAsFixed(1)}%',
    );

    return centerMoved || zoomChanged;
  }

  @override
  void dispose() {
    _boundsUpdateTimer?.cancel();
    _controller?.dispose();
    super.dispose();
  }
}
