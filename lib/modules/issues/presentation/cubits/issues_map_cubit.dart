import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:snapnfix/core/infrastructure/location/location_service.dart';
import 'package:snapnfix/core/infrastructure/networking/api_result.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_category.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_severity.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_status.dart';
import 'package:snapnfix/modules/issues/domain/usecases/watch_nearby_issues_use_case.dart';
import 'package:snapnfix/modules/issues/presentation/cubits/issues_map_state.dart';

class IssuesMapCubit extends Cubit<IssuesMapState> {
  final LocationService _locationService;
  GoogleMapController? _mapController;
  StreamSubscription? _issuesSubscription;
  final WatchNearbyIssuesUseCase _watchNearbyIssuesUseCase;

  IssuesMapCubit(this._locationService, this._watchNearbyIssuesUseCase)
    : super(IssuesMapState.initial());

  Future<void> _startWatchingNearbyIssues(
    double latitude,
    double longitude,
  ) async {
    await _issuesSubscription?.cancel();

    _issuesSubscription = _watchNearbyIssuesUseCase
        .call(latitude, longitude)
        .listen(
          (result) => _handleIssuesUpdate(result),
          onError:
              (error) => emit(
                state.copyWith(
                  status: MapStatus.error,
                  error: error.toString(),
                ),
              ),
        );
  }

  void _handleIssuesUpdate(ApiResult<List<Issue>> result) {
    result.when(
      success: (issues) {
        emit(
          state.copyWith(
            status: MapStatus.loaded,
            issues: issues,
            markers: _createMarkers(issues),
            error: null,
          ),
        );
      },
      failure: (error) {
        emit(state.copyWith(status: MapStatus.error, error: error.message));
      },
    );
  }

  Set<Marker> _createMarkers(List<Issue> issues) {
    return issues.map((issue) {
      return Marker(
        markerId: MarkerId(issue.id),
        position: LatLng(issue.latitude, issue.longitude),
        onTap: () => _onMarkerTapped(issue),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          issue.severity == IssueSeverity.high
              ? BitmapDescriptor.hueRed
              : issue.severity == IssueSeverity.medium
              ? BitmapDescriptor.hueOrange
              : BitmapDescriptor.hueGreen,
        ),
      );
    }).toSet();
  }

  void _onMarkerTapped(Issue issue) {
    emit(state.copyWith(selectedIssue: issue, showIssueDetail: true));
  }

  void onIssueDetailClosed() {
    emit(state.copyWith(showIssueDetail: false, selectedIssue: null));
  }

  Future<void> checkLocationPermission() async {
    final hasPermission = await _locationService.checkLocationPermissions(
      onPermissionDenied: (_, __) {},
      onServiceDisabled: () async => false,
    );
    if (hasPermission) {
      await setMapToCurrentLocation();
    } else {
      emit(
        state.copyWith(status: MapStatus.loaded, hasLocationPermission: false),
      );
    }
  }

  void clearFilters() {
    emit(
      state.copyWith(
        selectedCategories: [],
        selectedSeverities: [],
        selectedStatuses: [],
        filteredIssues: state.issues,
        markers: _createMarkers(state.issues),
      ),
    );
  }

  void applyFilters({
    required List<IssueCategory> selectedCategories,
    required List<IssueSeverity> selectedSeverities,
    required List<IssueStatus> selectedStatuses,
  }) {
    final filteredIssues =
        state.issues.where((issue) {
          final matchesCategory =
              selectedCategories.isEmpty ||
              selectedCategories.contains(issue.category);
          final matchesSeverity =
              selectedSeverities.isEmpty ||
              selectedSeverities.contains(issue.severity);
          final matchesStatus =
              selectedStatuses.isEmpty ||
              selectedStatuses.contains(issue.status);
          return matchesCategory && matchesSeverity && matchesStatus;
        }).toList();

    emit(
      state.copyWith(
        selectedCategories: selectedCategories,
        selectedSeverities: selectedSeverities,
        selectedStatuses: selectedStatuses,
        filteredIssues: filteredIssues,
        markers: _createMarkers(filteredIssues),
      ),
    );
  }

  Future<void> centerOnUserLocation() async {
    if (state.cameraPosition == null) return;
    final position = await _locationService.getCurrentPosition();
    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: state.cameraPosition!.zoom,
        ),
      ),
    );
  }

  Future<void> setMapToCurrentLocation() async {
    final position = await _locationService.getCurrentPosition();
    emit(
      state.copyWith(
        status: MapStatus.loaded,
        hasLocationPermission: true,
        cameraPosition: CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 17,
        ),
      ),
    );
    await _startWatchingNearbyIssues(position.latitude, position.longitude);
  }

  Future<void> openLocationSettings() async {
    try {
      await _locationService.openLocationSettings();
    } catch (e) {
      emit(
        state.copyWith(
          status: MapStatus.error,
          error: 'Failed to open settings',
        ),
      );
    }
  }

  Future<void> initialize() async {
    emit(state.copyWith(status: MapStatus.loading));
    try {
      final hasPermission = await _locationService.checkLocationPermissions(
        onPermissionDenied: (_, __) {},
        onServiceDisabled: () async => false,
      );
      if (!hasPermission) {
        emit(
          state.copyWith(
            status: MapStatus.loaded,
            hasLocationPermission: false,
          ),
        );
        return;
      }
      await setMapToCurrentLocation();
    } catch (e) {
      emit(
        state.copyWith(
          status: MapStatus.error,
          error: 'Failed to check location permissions',
        ),
      );
    }
  }

  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void onCameraMove(CameraPosition position) {
    if (_mapController == null) return;
    _locationService.checkIfLocationServiceEnabled().then((isEnabled) {
      if (!isEnabled) {
        emit(
          state.copyWith(
            status: MapStatus.error,
            error: 'Location service disabled',
          ),
        );
      } else {
        emit(
          state.copyWith(cameraPosition: position, status: MapStatus.loaded),
        );
      }
    });
  }
}
