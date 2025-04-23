// import 'dart:async';
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:snapnfix/core/infrastructure/networking/api_result.dart';
// import 'package:snapnfix/modules/issues/domain/entities/issue_status.dart';
// import 'package:snapnfix/modules/issues/presentation/cubits/issues_map_state.dart';
// import '../../../../core/infrastructure/location/location_service.dart';
// import '../../domain/entities/issue.dart';
// import '../../domain/repositories/base_issue_repository.dart';

// class IssuesMapCubit extends Cubit<IssuesMapState> {
//   final LocationService _locationService;
//   final BaseIssueRepository _issueRepository;
//   GoogleMapController? _mapController;
//   StreamSubscription<ApiResult<List<Issue>>>? _issuesSubscription;

//   IssuesMapCubit(this._locationService, this._issueRepository)
//     : super(const IssuesMapState());

//   Future<void> requestLocationPermission() async {
//     final hasPermission = await _locationService.checkLocationPermissions(
//       onPermissionDenied: _handlePermissionDenied,
//       onServiceDisabled: _handleServiceDisabled,
//     );

//     if (hasPermission) {
//       emit(state.copyWith(hasLocationPermission: true));
//       await initialize();
//     }
//   }

//   Future<void> initialize() async {
//     emit(state.copyWith(status: MapStatus.loading));

//     try {
//       final hasPermission = await _locationService.checkLocationPermissions(
//         onPermissionDenied: _handlePermissionDenied,
//         onServiceDisabled: _handleServiceDisabled,
//       );

//       if (!hasPermission) {
//         emit(state.copyWith(hasLocationPermission: false));
//         return;
//       }

//       final position = await _locationService.getCurrentPosition();
//       debugPrint('User location: ${position.latitude}, ${position.longitude}');
//       final initialPosition = CameraPosition(
//         target: LatLng(position.latitude, position.longitude),
//         zoom: 14,
//       );

//       // Start watching nearby issues
//       _startWatchingIssues(position.latitude, position.longitude);

//       emit(
//         state.copyWith(
//           status: MapStatus.loaded,
//           hasLocationPermission: true,
//           cameraPosition: initialPosition,
//         ),
//       );
//     } catch (error) {
//       emit(state.copyWith(status: MapStatus.error, error: error.toString()));
//     }
//   }

//   void onMapCreated(GoogleMapController controller) {
//     _mapController = controller;
//   }

//   Future<void> centerOnUserLocation() async {
//     if (!state.hasLocationPermission) {
//       emit(
//         state.copyWith(
//           error: 'Location permission is required to center on your location',
//         ),
//       );
//       return;
//     }
//     try {
//       final position = await _locationService.getCurrentPosition();
//       debugPrint('User location: ${position.latitude}, ${position.longitude}');
//       final cameraPosition = CameraPosition(
//         target: LatLng(position.latitude, position.longitude),
//         zoom: 5,
//       );

//       await _mapController?.animateCamera(
//         CameraUpdate.newCameraPosition(cameraPosition),
//       );

//       emit(
//         state.copyWith(isFollowingUser: true, cameraPosition: cameraPosition),
//       );
//     } catch (error) {
//       emit(state.copyWith(error: error.toString()));
//     }
//   }

//   void onCameraMove(CameraPosition position) {
//     if (state.isFollowingUser) {
//       emit(state.copyWith(isFollowingUser: false));
//     }
//   }

//   void onCameraIdle() {
//     if (_mapController != null) {
//       _updateVisibleIssues();
//     }
//   }

//   void toggleMapType() {
//     final newMapType =
//         state.mapType == MapType.normal ? MapType.satellite : MapType.normal;

//     emit(state.copyWith(mapType: newMapType));
//   }

//   Future<void> _updateVisibleIssues() async {
//     if (_mapController == null) return;

//     final bounds = await _mapController!.getVisibleRegion();
//     final center = LatLng(
//       (bounds.northeast.latitude + bounds.southwest.latitude) / 2,
//       (bounds.northeast.longitude + bounds.southwest.longitude) / 2,
//     );

//     final radius =
//         _locationService.calculateDistance(
//           bounds.northeast.latitude,
//           bounds.northeast.longitude,
//           center.latitude,
//           center.longitude,
//         ) /
//         1000;

//     _startWatchingIssues(center.latitude, center.longitude, radius);
//   }

//   void _startWatchingIssues(
//     double latitude,
//     double longitude, [
//     double radiusInKm = 0.1,
//   ]) {
//     _issuesSubscription?.cancel();
//     _issuesSubscription = _issueRepository
//         .watchNearbyIssues(latitude, longitude, radiusInKm)
//         .listen(
//           (result) => _handleIssuesUpdate(result),
//           onError: (error) => _handleError(error),
//         );
//   }

//   void _handleIssuesUpdate(ApiResult<List<Issue>> result) {
//     result.when(
//       success: (issues) {
//         debugPrint('Issues updated: ${issues.length} issues found');
//         emit(
//           state.copyWith(
//             status: MapStatus.loaded,
//             issues: issues,
//             markers: _createMarkers(issues),
//             error: null,
//           ),
//         );
//       },
//       failure: (error) {
//         emit(state.copyWith(status: MapStatus.error, error: error.message));
//       },
//     );
//   }

//   Set<Marker> _createMarkers(List<Issue> issues) {
//     debugPrint('Creating markers for ${issues.length} issues');
//     return issues
//         .map(
//           (issue) => Marker(
//             markerId: MarkerId(issue.id),
//             position: LatLng(issue.latitude, issue.longitude),
//             icon: _getMarkerIcon(issue.status),
//             infoWindow: InfoWindow(
//               title: issue.title,
//               snippet: issue.description,
//             ),
//             onTap: () => _onMarkerTapped(issue),
//           ),
//         )
//         .toSet();
//   }

//   BitmapDescriptor _getMarkerIcon(IssueStatus status) {
//     switch (status) {
//       case IssueStatus.pending:
//         return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
//       case IssueStatus.inProgress:
//         return BitmapDescriptor.defaultMarkerWithHue(
//           BitmapDescriptor.hueOrange,
//         );
//       case IssueStatus.fixed:
//         return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
//       }
//   }

//   void _onMarkerTapped(Issue issue) {
//     // Handle marker tap - can emit event or use callback
//   }

//   void _handlePermissionDenied(String title, String message) {
//     emit(
//       state.copyWith(error: '$title: $message', hasLocationPermission: false),
//     );
//   }

//   Future<bool> _handleServiceDisabled() async {
//     emit(
//       state.copyWith(
//         error: 'Location services are disabled',
//         hasLocationPermission: false,
//       ),
//     );
//     return false;
//   }

//   void _handleError(dynamic error) {
//     emit(state.copyWith(status: MapStatus.error, error: error.toString()));
//   }

//   @override
//   Future<void> close() {
//     _issuesSubscription?.cancel();
//     _mapController?.dispose();
//     return super.close();
//   }
// }
