// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'issues_map_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$IssuesMapState {
  MapStatus get status => throw _privateConstructorUsedError;
  Set<Marker> get markers => throw _privateConstructorUsedError;
  List<IssueMarker> get issues => throw _privateConstructorUsedError;
  CameraPosition? get cameraPosition => throw _privateConstructorUsedError;
  bool get hasLocationPermission => throw _privateConstructorUsedError;
  bool get isFollowingUser => throw _privateConstructorUsedError;
  String? get selectedIssueId => throw _privateConstructorUsedError;
  bool get showIssueDetail => throw _privateConstructorUsedError;
  String? get error =>
      throw _privateConstructorUsedError; // Add zoom and bounds preferences
  MinMaxZoomPreference? get minMaxZoomPreference =>
      throw _privateConstructorUsedError;
  CameraTargetBounds? get cameraTargetBounds =>
      throw _privateConstructorUsedError;

  /// Create a copy of IssuesMapState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IssuesMapStateCopyWith<IssuesMapState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IssuesMapStateCopyWith<$Res> {
  factory $IssuesMapStateCopyWith(
          IssuesMapState value, $Res Function(IssuesMapState) then) =
      _$IssuesMapStateCopyWithImpl<$Res, IssuesMapState>;
  @useResult
  $Res call(
      {MapStatus status,
      Set<Marker> markers,
      List<IssueMarker> issues,
      CameraPosition? cameraPosition,
      bool hasLocationPermission,
      bool isFollowingUser,
      String? selectedIssueId,
      bool showIssueDetail,
      String? error,
      MinMaxZoomPreference? minMaxZoomPreference,
      CameraTargetBounds? cameraTargetBounds});
}

/// @nodoc
class _$IssuesMapStateCopyWithImpl<$Res, $Val extends IssuesMapState>
    implements $IssuesMapStateCopyWith<$Res> {
  _$IssuesMapStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IssuesMapState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? markers = null,
    Object? issues = null,
    Object? cameraPosition = freezed,
    Object? hasLocationPermission = null,
    Object? isFollowingUser = null,
    Object? selectedIssueId = freezed,
    Object? showIssueDetail = null,
    Object? error = freezed,
    Object? minMaxZoomPreference = freezed,
    Object? cameraTargetBounds = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as MapStatus,
      markers: null == markers
          ? _value.markers
          : markers // ignore: cast_nullable_to_non_nullable
              as Set<Marker>,
      issues: null == issues
          ? _value.issues
          : issues // ignore: cast_nullable_to_non_nullable
              as List<IssueMarker>,
      cameraPosition: freezed == cameraPosition
          ? _value.cameraPosition
          : cameraPosition // ignore: cast_nullable_to_non_nullable
              as CameraPosition?,
      hasLocationPermission: null == hasLocationPermission
          ? _value.hasLocationPermission
          : hasLocationPermission // ignore: cast_nullable_to_non_nullable
              as bool,
      isFollowingUser: null == isFollowingUser
          ? _value.isFollowingUser
          : isFollowingUser // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedIssueId: freezed == selectedIssueId
          ? _value.selectedIssueId
          : selectedIssueId // ignore: cast_nullable_to_non_nullable
              as String?,
      showIssueDetail: null == showIssueDetail
          ? _value.showIssueDetail
          : showIssueDetail // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      minMaxZoomPreference: freezed == minMaxZoomPreference
          ? _value.minMaxZoomPreference
          : minMaxZoomPreference // ignore: cast_nullable_to_non_nullable
              as MinMaxZoomPreference?,
      cameraTargetBounds: freezed == cameraTargetBounds
          ? _value.cameraTargetBounds
          : cameraTargetBounds // ignore: cast_nullable_to_non_nullable
              as CameraTargetBounds?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IssuesMapStateImplCopyWith<$Res>
    implements $IssuesMapStateCopyWith<$Res> {
  factory _$$IssuesMapStateImplCopyWith(_$IssuesMapStateImpl value,
          $Res Function(_$IssuesMapStateImpl) then) =
      __$$IssuesMapStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {MapStatus status,
      Set<Marker> markers,
      List<IssueMarker> issues,
      CameraPosition? cameraPosition,
      bool hasLocationPermission,
      bool isFollowingUser,
      String? selectedIssueId,
      bool showIssueDetail,
      String? error,
      MinMaxZoomPreference? minMaxZoomPreference,
      CameraTargetBounds? cameraTargetBounds});
}

/// @nodoc
class __$$IssuesMapStateImplCopyWithImpl<$Res>
    extends _$IssuesMapStateCopyWithImpl<$Res, _$IssuesMapStateImpl>
    implements _$$IssuesMapStateImplCopyWith<$Res> {
  __$$IssuesMapStateImplCopyWithImpl(
      _$IssuesMapStateImpl _value, $Res Function(_$IssuesMapStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of IssuesMapState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? markers = null,
    Object? issues = null,
    Object? cameraPosition = freezed,
    Object? hasLocationPermission = null,
    Object? isFollowingUser = null,
    Object? selectedIssueId = freezed,
    Object? showIssueDetail = null,
    Object? error = freezed,
    Object? minMaxZoomPreference = freezed,
    Object? cameraTargetBounds = freezed,
  }) {
    return _then(_$IssuesMapStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as MapStatus,
      markers: null == markers
          ? _value._markers
          : markers // ignore: cast_nullable_to_non_nullable
              as Set<Marker>,
      issues: null == issues
          ? _value._issues
          : issues // ignore: cast_nullable_to_non_nullable
              as List<IssueMarker>,
      cameraPosition: freezed == cameraPosition
          ? _value.cameraPosition
          : cameraPosition // ignore: cast_nullable_to_non_nullable
              as CameraPosition?,
      hasLocationPermission: null == hasLocationPermission
          ? _value.hasLocationPermission
          : hasLocationPermission // ignore: cast_nullable_to_non_nullable
              as bool,
      isFollowingUser: null == isFollowingUser
          ? _value.isFollowingUser
          : isFollowingUser // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedIssueId: freezed == selectedIssueId
          ? _value.selectedIssueId
          : selectedIssueId // ignore: cast_nullable_to_non_nullable
              as String?,
      showIssueDetail: null == showIssueDetail
          ? _value.showIssueDetail
          : showIssueDetail // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      minMaxZoomPreference: freezed == minMaxZoomPreference
          ? _value.minMaxZoomPreference
          : minMaxZoomPreference // ignore: cast_nullable_to_non_nullable
              as MinMaxZoomPreference?,
      cameraTargetBounds: freezed == cameraTargetBounds
          ? _value.cameraTargetBounds
          : cameraTargetBounds // ignore: cast_nullable_to_non_nullable
              as CameraTargetBounds?,
    ));
  }
}

/// @nodoc

class _$IssuesMapStateImpl
    with DiagnosticableTreeMixin
    implements _IssuesMapState {
  const _$IssuesMapStateImpl(
      {this.status = MapStatus.initial,
      final Set<Marker> markers = const {},
      final List<IssueMarker> issues = const [],
      this.cameraPosition,
      this.hasLocationPermission = false,
      this.isFollowingUser = false,
      this.selectedIssueId,
      this.showIssueDetail = false,
      this.error,
      this.minMaxZoomPreference,
      this.cameraTargetBounds})
      : _markers = markers,
        _issues = issues;

  @override
  @JsonKey()
  final MapStatus status;
  final Set<Marker> _markers;
  @override
  @JsonKey()
  Set<Marker> get markers {
    if (_markers is EqualUnmodifiableSetView) return _markers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_markers);
  }

  final List<IssueMarker> _issues;
  @override
  @JsonKey()
  List<IssueMarker> get issues {
    if (_issues is EqualUnmodifiableListView) return _issues;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_issues);
  }

  @override
  final CameraPosition? cameraPosition;
  @override
  @JsonKey()
  final bool hasLocationPermission;
  @override
  @JsonKey()
  final bool isFollowingUser;
  @override
  final String? selectedIssueId;
  @override
  @JsonKey()
  final bool showIssueDetail;
  @override
  final String? error;
// Add zoom and bounds preferences
  @override
  final MinMaxZoomPreference? minMaxZoomPreference;
  @override
  final CameraTargetBounds? cameraTargetBounds;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'IssuesMapState(status: $status, markers: $markers, issues: $issues, cameraPosition: $cameraPosition, hasLocationPermission: $hasLocationPermission, isFollowingUser: $isFollowingUser, selectedIssueId: $selectedIssueId, showIssueDetail: $showIssueDetail, error: $error, minMaxZoomPreference: $minMaxZoomPreference, cameraTargetBounds: $cameraTargetBounds)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'IssuesMapState'))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('markers', markers))
      ..add(DiagnosticsProperty('issues', issues))
      ..add(DiagnosticsProperty('cameraPosition', cameraPosition))
      ..add(DiagnosticsProperty('hasLocationPermission', hasLocationPermission))
      ..add(DiagnosticsProperty('isFollowingUser', isFollowingUser))
      ..add(DiagnosticsProperty('selectedIssueId', selectedIssueId))
      ..add(DiagnosticsProperty('showIssueDetail', showIssueDetail))
      ..add(DiagnosticsProperty('error', error))
      ..add(DiagnosticsProperty('minMaxZoomPreference', minMaxZoomPreference))
      ..add(DiagnosticsProperty('cameraTargetBounds', cameraTargetBounds));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IssuesMapStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._markers, _markers) &&
            const DeepCollectionEquality().equals(other._issues, _issues) &&
            (identical(other.cameraPosition, cameraPosition) ||
                other.cameraPosition == cameraPosition) &&
            (identical(other.hasLocationPermission, hasLocationPermission) ||
                other.hasLocationPermission == hasLocationPermission) &&
            (identical(other.isFollowingUser, isFollowingUser) ||
                other.isFollowingUser == isFollowingUser) &&
            (identical(other.selectedIssueId, selectedIssueId) ||
                other.selectedIssueId == selectedIssueId) &&
            (identical(other.showIssueDetail, showIssueDetail) ||
                other.showIssueDetail == showIssueDetail) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.minMaxZoomPreference, minMaxZoomPreference) ||
                other.minMaxZoomPreference == minMaxZoomPreference) &&
            (identical(other.cameraTargetBounds, cameraTargetBounds) ||
                other.cameraTargetBounds == cameraTargetBounds));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      const DeepCollectionEquality().hash(_markers),
      const DeepCollectionEquality().hash(_issues),
      cameraPosition,
      hasLocationPermission,
      isFollowingUser,
      selectedIssueId,
      showIssueDetail,
      error,
      minMaxZoomPreference,
      cameraTargetBounds);

  /// Create a copy of IssuesMapState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IssuesMapStateImplCopyWith<_$IssuesMapStateImpl> get copyWith =>
      __$$IssuesMapStateImplCopyWithImpl<_$IssuesMapStateImpl>(
          this, _$identity);
}

abstract class _IssuesMapState implements IssuesMapState {
  const factory _IssuesMapState(
      {final MapStatus status,
      final Set<Marker> markers,
      final List<IssueMarker> issues,
      final CameraPosition? cameraPosition,
      final bool hasLocationPermission,
      final bool isFollowingUser,
      final String? selectedIssueId,
      final bool showIssueDetail,
      final String? error,
      final MinMaxZoomPreference? minMaxZoomPreference,
      final CameraTargetBounds? cameraTargetBounds}) = _$IssuesMapStateImpl;

  @override
  MapStatus get status;
  @override
  Set<Marker> get markers;
  @override
  List<IssueMarker> get issues;
  @override
  CameraPosition? get cameraPosition;
  @override
  bool get hasLocationPermission;
  @override
  bool get isFollowingUser;
  @override
  String? get selectedIssueId;
  @override
  bool get showIssueDetail;
  @override
  String? get error; // Add zoom and bounds preferences
  @override
  MinMaxZoomPreference? get minMaxZoomPreference;
  @override
  CameraTargetBounds? get cameraTargetBounds;

  /// Create a copy of IssuesMapState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IssuesMapStateImplCopyWith<_$IssuesMapStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
