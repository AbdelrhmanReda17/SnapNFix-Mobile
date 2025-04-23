import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../domain/entities/issue.dart';

part 'issues_map_state.freezed.dart';

@freezed
class IssuesMapState with _$IssuesMapState {
  const factory IssuesMapState({
    @Default(MapStatus.initial) MapStatus status,
    @Default({}) Set<Marker> markers,
    @Default([]) List<Issue> issues,
    CameraPosition? cameraPosition,
    @Default(false) bool hasLocationPermission,
    @Default(false) bool isFollowingUser,
    Issue? selectedIssue,
    @Default(false) bool showIssueDetail,
    String? error,
  }) = _IssuesMapState;

  factory IssuesMapState.initial() => const IssuesMapState();
}

enum MapStatus { initial, loading, loaded, error }
