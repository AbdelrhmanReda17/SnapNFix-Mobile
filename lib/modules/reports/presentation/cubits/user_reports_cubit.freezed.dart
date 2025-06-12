// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_reports_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserReportsState _$UserReportsStateFromJson(Map<String, dynamic> json) {
  return _UserReportsState.fromJson(json);
}

/// @nodoc
mixin _$UserReportsState {
  List<ReportModel> get reports => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isLoadingMore => throw _privateConstructorUsedError;
  bool get hasReachedEnd => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  ReportStatus? get currentStatus => throw _privateConstructorUsedError;
  IssueCategory? get currentCategory => throw _privateConstructorUsedError;
  SortOption get currentSortOption => throw _privateConstructorUsedError;
  DateTime? get lastUpdated => throw _privateConstructorUsedError;

  /// Serializes this UserReportsState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserReportsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserReportsStateCopyWith<UserReportsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserReportsStateCopyWith<$Res> {
  factory $UserReportsStateCopyWith(
          UserReportsState value, $Res Function(UserReportsState) then) =
      _$UserReportsStateCopyWithImpl<$Res, UserReportsState>;
  @useResult
  $Res call(
      {List<ReportModel> reports,
      bool isLoading,
      bool isLoadingMore,
      bool hasReachedEnd,
      String? error,
      ReportStatus? currentStatus,
      IssueCategory? currentCategory,
      SortOption currentSortOption,
      DateTime? lastUpdated});
}

/// @nodoc
class _$UserReportsStateCopyWithImpl<$Res, $Val extends UserReportsState>
    implements $UserReportsStateCopyWith<$Res> {
  _$UserReportsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserReportsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reports = null,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? hasReachedEnd = null,
    Object? error = freezed,
    Object? currentStatus = freezed,
    Object? currentCategory = freezed,
    Object? currentSortOption = null,
    Object? lastUpdated = freezed,
  }) {
    return _then(_value.copyWith(
      reports: null == reports
          ? _value.reports
          : reports // ignore: cast_nullable_to_non_nullable
              as List<ReportModel>,
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
      currentStatus: freezed == currentStatus
          ? _value.currentStatus
          : currentStatus // ignore: cast_nullable_to_non_nullable
              as ReportStatus?,
      currentCategory: freezed == currentCategory
          ? _value.currentCategory
          : currentCategory // ignore: cast_nullable_to_non_nullable
              as IssueCategory?,
      currentSortOption: null == currentSortOption
          ? _value.currentSortOption
          : currentSortOption // ignore: cast_nullable_to_non_nullable
              as SortOption,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserReportsStateImplCopyWith<$Res>
    implements $UserReportsStateCopyWith<$Res> {
  factory _$$UserReportsStateImplCopyWith(_$UserReportsStateImpl value,
          $Res Function(_$UserReportsStateImpl) then) =
      __$$UserReportsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<ReportModel> reports,
      bool isLoading,
      bool isLoadingMore,
      bool hasReachedEnd,
      String? error,
      ReportStatus? currentStatus,
      IssueCategory? currentCategory,
      SortOption currentSortOption,
      DateTime? lastUpdated});
}

/// @nodoc
class __$$UserReportsStateImplCopyWithImpl<$Res>
    extends _$UserReportsStateCopyWithImpl<$Res, _$UserReportsStateImpl>
    implements _$$UserReportsStateImplCopyWith<$Res> {
  __$$UserReportsStateImplCopyWithImpl(_$UserReportsStateImpl _value,
      $Res Function(_$UserReportsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserReportsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reports = null,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? hasReachedEnd = null,
    Object? error = freezed,
    Object? currentStatus = freezed,
    Object? currentCategory = freezed,
    Object? currentSortOption = null,
    Object? lastUpdated = freezed,
  }) {
    return _then(_$UserReportsStateImpl(
      reports: null == reports
          ? _value._reports
          : reports // ignore: cast_nullable_to_non_nullable
              as List<ReportModel>,
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
      currentStatus: freezed == currentStatus
          ? _value.currentStatus
          : currentStatus // ignore: cast_nullable_to_non_nullable
              as ReportStatus?,
      currentCategory: freezed == currentCategory
          ? _value.currentCategory
          : currentCategory // ignore: cast_nullable_to_non_nullable
              as IssueCategory?,
      currentSortOption: null == currentSortOption
          ? _value.currentSortOption
          : currentSortOption // ignore: cast_nullable_to_non_nullable
              as SortOption,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserReportsStateImpl implements _UserReportsState {
  const _$UserReportsStateImpl(
      {final List<ReportModel> reports = const [],
      this.isLoading = true,
      this.isLoadingMore = false,
      this.hasReachedEnd = false,
      this.error,
      this.currentStatus,
      this.currentCategory,
      this.currentSortOption = SortOption.dateNewest,
      this.lastUpdated})
      : _reports = reports;

  factory _$UserReportsStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserReportsStateImplFromJson(json);

  final List<ReportModel> _reports;
  @override
  @JsonKey()
  List<ReportModel> get reports {
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
  final ReportStatus? currentStatus;
  @override
  final IssueCategory? currentCategory;
  @override
  @JsonKey()
  final SortOption currentSortOption;
  @override
  final DateTime? lastUpdated;

  @override
  String toString() {
    return 'UserReportsState(reports: $reports, isLoading: $isLoading, isLoadingMore: $isLoadingMore, hasReachedEnd: $hasReachedEnd, error: $error, currentStatus: $currentStatus, currentCategory: $currentCategory, currentSortOption: $currentSortOption, lastUpdated: $lastUpdated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserReportsStateImpl &&
            const DeepCollectionEquality().equals(other._reports, _reports) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.hasReachedEnd, hasReachedEnd) ||
                other.hasReachedEnd == hasReachedEnd) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.currentStatus, currentStatus) ||
                other.currentStatus == currentStatus) &&
            (identical(other.currentCategory, currentCategory) ||
                other.currentCategory == currentCategory) &&
            (identical(other.currentSortOption, currentSortOption) ||
                other.currentSortOption == currentSortOption) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_reports),
      isLoading,
      isLoadingMore,
      hasReachedEnd,
      error,
      currentStatus,
      currentCategory,
      currentSortOption,
      lastUpdated);

  /// Create a copy of UserReportsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserReportsStateImplCopyWith<_$UserReportsStateImpl> get copyWith =>
      __$$UserReportsStateImplCopyWithImpl<_$UserReportsStateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserReportsStateImplToJson(
      this,
    );
  }
}

abstract class _UserReportsState implements UserReportsState {
  const factory _UserReportsState(
      {final List<ReportModel> reports,
      final bool isLoading,
      final bool isLoadingMore,
      final bool hasReachedEnd,
      final String? error,
      final ReportStatus? currentStatus,
      final IssueCategory? currentCategory,
      final SortOption currentSortOption,
      final DateTime? lastUpdated}) = _$UserReportsStateImpl;

  factory _UserReportsState.fromJson(Map<String, dynamic> json) =
      _$UserReportsStateImpl.fromJson;

  @override
  List<ReportModel> get reports;
  @override
  bool get isLoading;
  @override
  bool get isLoadingMore;
  @override
  bool get hasReachedEnd;
  @override
  String? get error;
  @override
  ReportStatus? get currentStatus;
  @override
  IssueCategory? get currentCategory;
  @override
  SortOption get currentSortOption;
  @override
  DateTime? get lastUpdated;

  /// Create a copy of UserReportsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserReportsStateImplCopyWith<_$UserReportsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
