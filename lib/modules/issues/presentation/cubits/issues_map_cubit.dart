// ignore_for_file: library_prefixes

import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:snapnfix/modules/issues/data/models/markers.dart';
import 'package:snapnfix/modules/issues/index.dart';

part 'issues_map_state.dart';
part 'issues_map_cubit.freezed.dart';

class IssuesMapCubit extends Cubit<IssuesMapState> {
  final GetNearbyIssuesUseCase _getNearbyIssuesUseCase;
  GoogleMapController? _mapController;
  Timer? _debounceTimer;
  bool _isClosed = false;

  // Configuration
  static const Duration _debounceDelay = Duration(
    milliseconds: 1200,
  ); // Increased delay
  static const double _minZoom = 16.0;
  static const double _maxZoom = 20.0;
  static const double _defaultZoom = 17.5;

  // Enhanced bounds tracking
  LatLngBounds? _lastQueriedBounds;
  DateTime? _lastQueryTime;
  static const Duration _minTimeBetweenQueries = Duration(seconds: 2);

  // Zoom-based thresholds for bounds comparison
  static final Map<double, double> _zoomThresholds = {
    16.0: 0.003,
    17.0: 0.0015,
    18.0: 0.0008,
    19.0: 0.0004,
    20.0: 0.0002,
  };

  IssuesMapCubit(this._getNearbyIssuesUseCase) : super(const IssuesMapState());

  @override
  Future<void> close() async {
    _isClosed = true;
    _debounceTimer?.cancel();
    _mapController?.dispose();
    return super.close();
  }

  Future<void> initialize(Position position) async {
    emit(state.copyWith(status: MapStatus.loading));

    try {
      emit(
        state.copyWith(
          status: MapStatus.loaded,
          cameraPosition: CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: _defaultZoom,
          ),
          hasLocationPermission: true,
          isFollowingUser: true,
          minMaxZoomPreference: const MinMaxZoomPreference(_minZoom, _maxZoom),
          error: null,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: MapStatus.error, error: e.toString()));
    }
  }

  Future<void> centerOnUserLocation(Position position) async {
    if (_mapController == null) return;

    await _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: _defaultZoom,
        ),
      ),
    );

    emit(state.copyWith(isFollowingUser: true));
  }

  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void onCameraMove(CameraPosition position) {
    if (_mapController == null || _isClosed) return;

    emit(state.copyWith(cameraPosition: position, isFollowingUser: false));
  }

  Future<void> onBoundsChanged(LatLngBounds bounds) async {
    if (_isClosed) return;

    // Enhanced filtering before debouncing
    if (!_shouldQueryForBounds(bounds)) {
      debugPrint('Skipping bounds query - not significant enough change');
      return;
    }

    // Cancel any existing timer
    _debounceTimer?.cancel();

    // Debounce the API calls to avoid too many requests
    _debounceTimer = Timer(_debounceDelay, () {
      _loadIssuesForViewport(bounds);
    });
  }

  Future<void> onIssueTapped(
    String issueId,
    double latitude,
    double longitude,
  ) async {
    if (_mapController == null) return;

    // Animate to issue location with appropriate zoom
    await _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: math.min(11.0, _maxZoom), // Ensure we don't exceed max zoom
        ),
      ),
    );

    emit(state.copyWith(selectedIssueId: issueId, showIssueDetail: true));
  }

  void onIssueDetailClosed() {
    emit(state.copyWith(showIssueDetail: false, selectedIssueId: null));
  }

  // Enhanced bounds change detection
  bool _shouldQueryForBounds(LatLngBounds bounds) {
    // Time-based throttling
    final now = DateTime.now();
    if (_lastQueryTime != null &&
        now.difference(_lastQueryTime!) < _minTimeBetweenQueries) {
      return false;
    }

    // First query always allowed
    if (_lastQueriedBounds == null) {
      return true;
    }

    // Get current zoom level for dynamic threshold
    final currentZoom = state.cameraPosition?.zoom ?? _defaultZoom;
    final threshold = _getThresholdForZoom(currentZoom);

    return !_areLatLngBoundsSimilar(_lastQueriedBounds!, bounds, threshold);
  }

  double _getThresholdForZoom(double zoom) {
    // Find the closest zoom level threshold
    double closestZoom = _zoomThresholds.keys.first;
    double minDifference = (zoom - closestZoom).abs();

    for (final zoomLevel in _zoomThresholds.keys) {
      final difference = (zoom - zoomLevel).abs();
      if (difference < minDifference) {
        minDifference = difference;
        closestZoom = zoomLevel;
      }
    }

    return _zoomThresholds[closestZoom] ?? 0.001;
  }

  bool _areLatLngBoundsSimilar(
    LatLngBounds bounds1,
    LatLngBounds bounds2,
    double threshold,
  ) {
    // Calculate the center points
    final center1Lat =
        (bounds1.northeast.latitude + bounds1.southwest.latitude) / 2;
    final center1Lng =
        (bounds1.northeast.longitude + bounds1.southwest.longitude) / 2;
    final center2Lat =
        (bounds2.northeast.latitude + bounds2.southwest.latitude) / 2;
    final center2Lng =
        (bounds2.northeast.longitude + bounds2.southwest.longitude) / 2;

    // Check if centers are within threshold
    final centerDistance = math.sqrt(
      math.pow(center1Lat - center2Lat, 2) +
          math.pow(center1Lng - center2Lng, 2),
    );

    if (centerDistance > threshold) {
      return false;
    }

    // Also check if the bounds size changed significantly
    final bounds1Width =
        bounds1.northeast.longitude - bounds1.southwest.longitude;
    final bounds1Height =
        bounds1.northeast.latitude - bounds1.southwest.latitude;
    final bounds2Width =
        bounds2.northeast.longitude - bounds2.southwest.longitude;
    final bounds2Height =
        bounds2.northeast.latitude - bounds2.southwest.latitude;

    final widthDiff = (bounds1Width - bounds2Width).abs();
    final heightDiff = (bounds1Height - bounds2Height).abs();

    // Allow for 20% change in bounds size before triggering new query
    final sizeThreshold = threshold * 0.2;

    return widthDiff < sizeThreshold && heightDiff < sizeThreshold;
  }

  // Private methods
  Future<void> _loadIssuesForViewport(LatLngBounds bounds) async {
    if (_isClosed || _mapController == null) return;

    // Double-check before making API call
    if (!_shouldQueryForBounds(bounds)) {
      debugPrint('Skipping viewport query - filtered out at execution time');
      return;
    }

    _lastQueriedBounds = bounds;
    _lastQueryTime = DateTime.now();

    try {
      final zoom = state.cameraPosition?.zoom ?? _defaultZoom;
      final maxResults = _calculateMaxResultsForZoom(zoom);

      debugPrint(
        'Loading issues for viewport - zoom: $zoom, maxResults: $maxResults',
      );

      final result = await _getNearbyIssuesUseCase.call(
        bounds: bounds,
        maxResults: maxResults,
      );

      if (_isClosed) return;

      result.when(
        success: (issueMarkers) {
          debugPrint('Loaded ${issueMarkers.length} issues for viewport');
          emit(
            state.copyWith(
              status: MapStatus.loaded,
              issues: issueMarkers,
              markers: _createMarkers(issueMarkers),
              error: null,
            ),
          );
        },
        failure: (error) {
          debugPrint('Viewport issues loading error: ${error.message}');
          // Don't emit error state for viewport updates, just log
          // This prevents the UI from showing error states during normal map navigation
        },
      );
    } catch (e) {
      debugPrint('Exception in viewport issues loading: $e');
    }
  }

  Set<Marker> _createMarkers(List<IssueMarker> issueMarkers) {
    return issueMarkers.map((issueMarker) {
      return Marker(
        markerId: MarkerId(issueMarker.issueId),
        position: LatLng(issueMarker.latitude, issueMarker.longitude),
        onTap:
            () => onIssueTapped(
              issueMarker.issueId,
              issueMarker.latitude,
              issueMarker.longitude,
            ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      );
    }).toSet();
  }

  int _calculateMaxResultsForZoom(double zoom) {
    // Adjust max results based on zoom level
    // Higher zoom = more detailed view = more markers allowed
    if (zoom <= 6) return 20; // Very zoomed out - fewer markers
    if (zoom <= 8) return 40; // Zoomed out - moderate markers
    if (zoom <= 10) return 80; // Medium zoom - more markers
    return 120; // Zoomed in - most markers
  }
}
