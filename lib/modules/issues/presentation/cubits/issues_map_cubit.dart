// ignore_for_file: library_prefixes

import 'dart:async';
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

    debugPrint('Starting to watch nearby issues at $latitude, $longitude');

    _issuesSubscription = _watchNearbyIssuesUseCase
        .call(latitude, longitude)
        .listen(
          (result) {
            debugPrint('Received issues update: $result');
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

  void _handleIssuesUpdate(Result<List<IssueMarker>, ApiError> result) {
    if (_isClosed) return;
    debugPrint('Handling issues update: $result');

    result.when(
      success: (issueMarkers) {
        debugPrint('Issues updated: ${issueMarkers.length}');
        emit(
          state.copyWith(
            status: MapStatus.loaded,
            issues: issueMarkers,
            markers:
                issueMarkers.isNotEmpty
                    ? _createMarkers(issueMarkers)
                    : <Marker>{},
            error: null,
          ),
        );
      },
      failure: (error) {
        emit(
          state.copyWith(status: MapStatus.error, error: error.message),
        );
      },
    );
  }

  Set<Marker> _createMarkers(List<IssueMarker> issueMarkers) {
    debugPrint('Creating markers for ${issueMarkers.length} issues');
    return issueMarkers.map((issueMarker) {
      return Marker(
        markerId: MarkerId(issueMarker.issueId),
        position: LatLng(issueMarker.latitude, issueMarker.longitude),
        onTap:
            () => emit(
              state.copyWith(
                selectedIssueId: issueMarker.issueId,
                showIssueDetail: true,
              ),
            ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      );
    }).toSet();
  }

  // Issue detail handling
  void onIssueDetailClosed() {
    emit(state.copyWith(showIssueDetail: false, selectedIssueId: null));
  }
}
