// import 'package:equatable/equatable.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import '../../domain/entities/issue.dart';

// enum MapStatus { initial, loading, loaded, error }

// class IssuesMapState extends Equatable {
//   final MapStatus status;
//   final Set<Marker> markers;
//   final List<Issue> issues;
//   final CameraPosition? cameraPosition;
//   final bool hasLocationPermission;
//   final String? error;
//   final bool isFollowingUser;
//   final MapType mapType;

//   const IssuesMapState({
//     this.status = MapStatus.initial,
//     this.markers = const {},
//     this.issues = const [],
//     this.cameraPosition,
//     this.hasLocationPermission = false,
//     this.error,
//     this.isFollowingUser = true,
//     this.mapType = MapType.normal,
//   });

//   IssuesMapState copyWith({
//     MapStatus? status,
//     Set<Marker>? markers,
//     List<Issue>? issues,
//     CameraPosition? cameraPosition,
//     bool? hasLocationPermission,
//     String? error,
//     bool? isFollowingUser,
//     MapType? mapType,
//   }) {
//     return IssuesMapState(
//       status: status ?? this.status,
//       markers: markers ?? this.markers,
//       issues: issues ?? this.issues,
//       cameraPosition: cameraPosition ?? this.cameraPosition,
//       hasLocationPermission:
//           hasLocationPermission ?? this.hasLocationPermission,
//       error: error,
//       isFollowingUser: isFollowingUser ?? this.isFollowingUser,
//       mapType: mapType ?? this.mapType,
//     );
//   }

//   @override
//   List<Object?> get props => [
//     status,
//     markers,
//     issues,
//     cameraPosition,
//     hasLocationPermission,
//     error,
//     isFollowingUser,
//     mapType,
//   ];
// }
