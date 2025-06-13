// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'issue_snap_reports_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

IssueSnapReportsState _$IssueSnapReportsStateFromJson(
    Map<String, dynamic> json) {
  return _IssueSnapReportsState.fromJson(json);
}

/// @nodoc
mixin _$IssueSnapReportsState {
  List<SnapReportModel> get reports => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isLoadingMore => throw _privateConstructorUsedError;
  bool get hasReachedEnd => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Serializes this IssueSnapReportsState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IssueSnapReportsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IssueSnapReportsStateCopyWith<IssueSnapReportsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IssueSnapReportsStateCopyWith<$Res> {
  factory $IssueSnapReportsStateCopyWith(IssueSnapReportsState value,
          $Res Function(IssueSnapReportsState) then) =
      _$IssueSnapReportsStateCopyWithImpl<$Res, IssueSnapReportsState>;
  @useResult
  $Res call(
      {List<SnapReportModel> reports,
      bool isLoading,
      bool isLoadingMore,
      bool hasReachedEnd,
      String? error});
}

/// @nodoc
class _$IssueSnapReportsStateCopyWithImpl<$Res,
        $Val extends IssueSnapReportsState>
    implements $IssueSnapReportsStateCopyWith<$Res> {
  _$IssueSnapReportsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IssueSnapReportsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reports = null,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? hasReachedEnd = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      reports: null == reports
          ? _value.reports
          : reports // ignore: cast_nullable_to_non_nullable
              as List<SnapReportModel>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingMore: null == isLoadingMore
          ? _value.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
              as bool,
      hasReachedEnd: null == hasReachedEnd
          ? _value.hasReachedEnd
          : hasReachedEnd // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IssueSnapReportsStateImplCopyWith<$Res>
    implements $IssueSnapReportsStateCopyWith<$Res> {
  factory _$$IssueSnapReportsStateImplCopyWith(
          _$IssueSnapReportsStateImpl value,
          $Res Function(_$IssueSnapReportsStateImpl) then) =
      __$$IssueSnapReportsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<SnapReportModel> reports,
      bool isLoading,
      bool isLoadingMore,
      bool hasReachedEnd,
      String? error});
}

/// @nodoc
class __$$IssueSnapReportsStateImplCopyWithImpl<$Res>
    extends _$IssueSnapReportsStateCopyWithImpl<$Res,
        _$IssueSnapReportsStateImpl>
    implements _$$IssueSnapReportsStateImplCopyWith<$Res> {
  __$$IssueSnapReportsStateImplCopyWithImpl(_$IssueSnapReportsStateImpl _value,
      $Res Function(_$IssueSnapReportsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of IssueSnapReportsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reports = null,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? hasReachedEnd = null,
    Object? error = freezed,
  }) {
    return _then(_$IssueSnapReportsStateImpl(
      reports: null == reports
          ? _value._reports
          : reports // ignore: cast_nullable_to_non_nullable
              as List<SnapReportModel>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingMore: null == isLoadingMore
          ? _value.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
              as bool,
      hasReachedEnd: null == hasReachedEnd
          ? _value.hasReachedEnd
          : hasReachedEnd // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IssueSnapReportsStateImpl implements _IssueSnapReportsState {
  const _$IssueSnapReportsStateImpl(
      {final List<SnapReportModel> reports = const [],
      this.isLoading = false,
      this.isLoadingMore = false,
      this.hasReachedEnd = false,
      this.error})
      : _reports = reports;

  factory _$IssueSnapReportsStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$IssueSnapReportsStateImplFromJson(json);

  final List<SnapReportModel> _reports;
  @override
  @JsonKey()
  List<SnapReportModel> get reports {
    if (_reports is EqualUnmodifiableListView) return _reports;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reports);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isLoadingMore;
  @override
  @JsonKey()
  final bool hasReachedEnd;
  @override
  final String? error;

  @override
  String toString() {
    return 'IssueSnapReportsState(reports: $reports, isLoading: $isLoading, isLoadingMore: $isLoadingMore, hasReachedEnd: $hasReachedEnd, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IssueSnapReportsStateImpl &&
            const DeepCollectionEquality().equals(other._reports, _reports) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.hasReachedEnd, hasReachedEnd) ||
                other.hasReachedEnd == hasReachedEnd) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_reports),
      isLoading,
      isLoadingMore,
      hasReachedEnd,
      error);

  /// Create a copy of IssueSnapReportsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IssueSnapReportsStateImplCopyWith<_$IssueSnapReportsStateImpl>
      get copyWith => __$$IssueSnapReportsStateImplCopyWithImpl<
          _$IssueSnapReportsStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IssueSnapReportsStateImplToJson(
      this,
    );
  }
}

abstract class _IssueSnapReportsState implements IssueSnapReportsState {
  const factory _IssueSnapReportsState(
      {final List<SnapReportModel> reports,
      final bool isLoading,
      final bool isLoadingMore,
      final bool hasReachedEnd,
      final String? error}) = _$IssueSnapReportsStateImpl;

  factory _IssueSnapReportsState.fromJson(Map<String, dynamic> json) =
      _$IssueSnapReportsStateImpl.fromJson;

  @override
  List<SnapReportModel> get reports;
  @override
  bool get isLoading;
  @override
  bool get isLoadingMore;
  @override
  bool get hasReachedEnd;
  @override
  String? get error;

  /// Create a copy of IssueSnapReportsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IssueSnapReportsStateImplCopyWith<_$IssueSnapReportsStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
