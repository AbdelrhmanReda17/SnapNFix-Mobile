part of 'issues_map_cubit.dart';

@freezed
class IssuesMapState with _$IssuesMapState {
  const factory IssuesMapState({
    @Default(MapStatus.initial) MapStatus status,
    @Default({}) Set<Marker> markers,
    @Default([]) List<IssueMarker> issues,
    CameraPosition? cameraPosition,
    @Default(false) bool hasLocationPermission,
    @Default(false) bool isFollowingUser,
    String? selectedIssueId,
    @Default(false) bool showIssueDetail,
    String? error,
    // Add zoom and bounds preferences
    MinMaxZoomPreference? minMaxZoomPreference,
    CameraTargetBounds? cameraTargetBounds,
  }) = _IssuesMapState;

  factory IssuesMapState.initial() => const IssuesMapState();
}

enum MapStatus { initial, loading, loaded, error }
