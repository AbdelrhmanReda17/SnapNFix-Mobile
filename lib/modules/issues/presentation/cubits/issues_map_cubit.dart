import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:snapnfix/core/infrastructure/networking/api_result.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_category.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_severity.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_status.dart';
import 'package:snapnfix/modules/issues/domain/usecases/watch_nearby_issues_use_case.dart';
import 'package:snapnfix/modules/issues/presentation/cubits/issues_map_state.dart';

class IssuesMapCubit extends Cubit<IssuesMapState> {
  final WatchNearbyIssuesUseCase _watchNearbyIssuesUseCase;
  GoogleMapController? _mapController;
  StreamSubscription? _issuesSubscription;
  bool _isClosed = false;

  IssuesMapCubit(this._watchNearbyIssuesUseCase)
    : super(const IssuesMapState());

  @override
  Future<void> close() async {
    _isClosed = true;
    await _issuesSubscription?.cancel();
    _mapController?.dispose();
    return super.close();
  }

  Future<void> onIssueTapped(double latitude, double longitude) async {
    if (_mapController == null) return;

    await _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: state.cameraPosition?.zoom ?? 17,
        ),
      ),
    );
  }

  Future<void> initialize(Position position) async {
    emit(state.copyWith(status: MapStatus.loading));

    try {
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
          zoom: state.cameraPosition?.zoom ?? 17,
        ),
      ),
    );
  }

  // Map callbacks
  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void onCameraMove(CameraPosition position) {
    if (_mapController == null) return;
    emit(state.copyWith(cameraPosition: position));
  }

  // Issues handling
  Future<void> _startWatchingNearbyIssues(
    double latitude,
    double longitude,
  ) async {
    await _issuesSubscription?.cancel();

    _issuesSubscription = _watchNearbyIssuesUseCase
        .call(latitude, longitude)
        .listen(
          (result) {
            if (!_isClosed) _handleIssuesUpdate(result);
          },
          onError: (error) {
            if (!_isClosed) {
              emit(
                state.copyWith(
                  status: MapStatus.error,
                  error: error.toString(),
                ),
              );
            }
          },
          cancelOnError: false,
        );
  }

  void _handleIssuesUpdate(ApiResult<List<Issue>> result) {
    if (_isClosed) return;

    result.when(
      success: (issues) {
        final filteredIssues = _applyFilters(issues);
        emit(
          state.copyWith(
            status: MapStatus.loaded,
            issues: issues,
            filteredIssues: filteredIssues,
            markers: _createMarkers(filteredIssues),
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
      final hue =
          issue.severity == IssueSeverity.high
              ? BitmapDescriptor.hueRed
              : issue.severity == IssueSeverity.medium
              ? BitmapDescriptor.hueOrange
              : BitmapDescriptor.hueGreen;

      return Marker(
        markerId: MarkerId(issue.id),
        position: LatLng(issue.latitude, issue.longitude),
        onTap:
            () => emit(
              state.copyWith(selectedIssue: issue, showIssueDetail: true),
            ),
        icon: BitmapDescriptor.defaultMarkerWithHue(hue),
      );
    }).toSet();
  }

  // Issue filters
  List<Issue> _applyFilters(List<Issue> issues) {
    if (state.selectedCategories.isEmpty &&
        state.selectedSeverities.isEmpty &&
        state.selectedStatuses.isEmpty) {
      return issues;
    }

    return issues.where((issue) {
      final matchesCategory =
          state.selectedCategories.isEmpty ||
          state.selectedCategories.contains(issue.category);
      final matchesSeverity =
          state.selectedSeverities.isEmpty ||
          state.selectedSeverities.contains(issue.severity);
      final matchesStatus =
          state.selectedStatuses.isEmpty ||
          state.selectedStatuses.contains(issue.status);
      return matchesCategory && matchesSeverity && matchesStatus;
    }).toList();
  }

  void applyFilters({
    required List<IssueCategory> selectedCategories,
    required List<IssueSeverity> selectedSeverities,
    required List<IssueStatus> selectedStatuses,
  }) {
    emit(
      state.copyWith(
        selectedCategories: selectedCategories,
        selectedSeverities: selectedSeverities,
        selectedStatuses: selectedStatuses,
      ),
    );

    final filteredIssues = _applyFilters(state.issues);
    emit(
      state.copyWith(
        filteredIssues: filteredIssues,
        markers: _createMarkers(filteredIssues),
      ),
    );
  }

  void clearFilters() {
    emit(
      state.copyWith(
        selectedCategories: const [],
        selectedSeverities: const [],
        selectedStatuses: const [],
        filteredIssues: state.issues,
        markers: _createMarkers(state.issues),
      ),
    );
  }

  // Issue detail handling
  void onIssueDetailClosed() {
    emit(state.copyWith(showIssueDetail: false, selectedIssue: null));
  }
}
