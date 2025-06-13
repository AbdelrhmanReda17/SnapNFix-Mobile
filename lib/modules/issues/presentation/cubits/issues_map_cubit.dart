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
import 'package:snapnfix/core/index.dart';

part 'issues_map_state.dart';
part 'issues_map_cubit.freezed.dart';

class IssuesMapCubit extends Cubit<IssuesMapState> {
  final GetNearbyIssuesUseCase _getNearbyIssuesUseCase;
  final WatchNearbyIssuesUseCase _watchNearbyIssuesUseCase;
  GoogleMapController? _mapController;
  StreamSubscription? _issuesSubscription;
  Timer? _debounceTimer;
  bool _isClosed = false;

  // Store user's current position for viewport fetches
  Position? _currentUserPosition;

  // Configuration
  static const double _defaultRadius = 0.3;
  static const Duration _debounceDelay = Duration(milliseconds: 800);

  LatLngBounds? _lastQueriedBounds;

  IssuesMapCubit(this._getNearbyIssuesUseCase, this._watchNearbyIssuesUseCase)
    : super(const IssuesMapState());

  @override
  Future<void> close() async {
    _isClosed = true;
    _debounceTimer?.cancel();
    await _issuesSubscription?.cancel();
    _mapController?.dispose();
    return super.close();
  }

  Future<void> initialize(Position position) async {
    emit(state.copyWith(status: MapStatus.loading));

    try {
      // Store user position for viewport fetches
      _currentUserPosition = position;

      emit(
        state.copyWith(
          status: MapStatus.loaded,
          cameraPosition: CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 14.0,
          ),
          hasLocationPermission: true,
          isFollowingUser: true,
          minMaxZoomPreference: const MinMaxZoomPreference(8.0, 18.0),
          error: null,
        ),
      );

      // Start watching nearby issues around user location
      await _startWatchingNearbyIssues(position.latitude, position.longitude);
    } catch (e) {
      emit(state.copyWith(status: MapStatus.error, error: e.toString()));
    }
  }

  Future<void> centerOnUserLocation(Position position) async {
    if (_mapController == null) return;

    // Update stored user position
    _currentUserPosition = position;

    await _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 15.0,
        ),
      ),
    );

    emit(state.copyWith(isFollowingUser: true));

    // Restart watching with new position
    await _startWatchingNearbyIssues(position.latitude, position.longitude);
  }

  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void onCameraMove(CameraPosition position) {
    if (_mapController == null || _isClosed) return;

    emit(state.copyWith(cameraPosition: position, isFollowingUser: false));
  }

  Future<void> onBoundsChanged(LatLngBounds bounds) async {
    if (_isClosed || _currentUserPosition == null) return;

    // Store the bounds to prevent duplicate API calls
    _debounceTimer?.cancel();
    _debounceTimer = Timer(_debounceDelay, () {
      // Only load if we haven't queried with these bounds recently
      if (_lastQueriedBounds == null ||
          !_areLatLngBoundsSimilar(_lastQueriedBounds!, bounds)) {
        _lastQueriedBounds = bounds;
        _loadIssuesNearUser(bounds);
      }
    });
  }

  Future<void> onIssueTapped(
    String issueId,
    double latitude,
    double longitude,
  ) async {
    if (_mapController == null) return;

    await _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(latitude, longitude), zoom: 16),
      ),
    );

    emit(state.copyWith(selectedIssueId: issueId, showIssueDetail: true));
  }

  void onIssueDetailClosed() {
    emit(state.copyWith(showIssueDetail: false, selectedIssueId: null));
  }

  // Private methods
  Future<void> _startWatchingNearbyIssues(
    double latitude,
    double longitude,
  ) async {
    await _issuesSubscription?.cancel();

    debugPrint('Starting to watch nearby issues at $latitude, $longitude');

    _issuesSubscription = _watchNearbyIssuesUseCase
        .call(latitude, longitude, radius: _defaultRadius, maxResults: 100)
        .listen(_handleIssuesUpdate);
  }

  // Changed method name and logic to fetch near user, not viewport center
  Future<void> _loadIssuesNearUser(LatLngBounds bounds) async {
    if (_isClosed || _mapController == null || _currentUserPosition == null)
      // ignore: curly_braces_in_flow_control_structures
      return;

    try {
      final zoom = state.cameraPosition?.zoom ?? 14.0;
      final maxResults = _calculateMaxResultsForZoom(zoom);

      debugPrint(
        'Loading issues near user - zoom: $zoom, maxResults: $maxResults',
      );
      debugPrint(
        'User position: ${_currentUserPosition!.latitude}, ${_currentUserPosition!.longitude}',
      );

      // Fetch issues around USER location with fixed radius, not viewport center
      final result = await _getNearbyIssuesUseCase.getNearbyIssues(
        latitude: _currentUserPosition!.latitude,
        longitude: _currentUserPosition!.longitude,
        radiusInKm: _defaultRadius, // Keep fixed radius
        viewport: bounds,
        maxResults: maxResults,
      );

      if (_isClosed) return;

      result.when(
        success: (issueMarkers) {
          debugPrint('Loaded ${issueMarkers.length} issues near user');
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
          debugPrint('User nearby issues loading error: ${error.message}');
          // Don't emit error state for viewport updates, just log
        },
      );
    } catch (e) {
      debugPrint('Exception in nearby issues loading: $e');
    }
  }

  void _handleIssuesUpdate(Result<List<IssueMarker>, ApiError> result) {
    if (_isClosed) return;

    result.when(
      success: (issueMarkers) {
        debugPrint('Issues update: ${issueMarkers.length} issues');
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
        emit(state.copyWith(status: MapStatus.error, error: error.message));
      },
    );
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
    if (zoom < 10) return 30;
    if (zoom < 13) return 60;
    if (zoom < 15) return 100;
    return 150;
  }

  bool _areLatLngBoundsSimilar(LatLngBounds bounds1, LatLngBounds bounds2) {
    // Define a threshold for considering bounds similar (adjust as needed)
    const threshold = 0.0002;

    return (bounds1.northeast.latitude - bounds2.northeast.latitude).abs() <
            threshold &&
        (bounds1.northeast.longitude - bounds2.northeast.longitude).abs() <
            threshold &&
        (bounds1.southwest.latitude - bounds2.southwest.latitude).abs() <
            threshold &&
        (bounds1.southwest.longitude - bounds2.southwest.longitude).abs() <
            threshold;
  }
}
