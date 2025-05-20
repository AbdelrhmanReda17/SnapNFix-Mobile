// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report_review_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ReportReviewState {
  List<ReportModel> get reports => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isLoadingMore => throw _privateConstructorUsedError;
  bool get hasReachedEnd => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  ReportStatus? get currentStatus => throw _privateConstructorUsedError;
  IssueCategory? get currentCategory => throw _privateConstructorUsedError;
  SortOption get currentSortOption => throw _privateConstructorUsedError;

  /// Create a copy of ReportReviewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReportReviewStateCopyWith<ReportReviewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReportReviewStateCopyWith<$Res> {
  factory $ReportReviewStateCopyWith(
    ReportReviewState value,
    $Res Function(ReportReviewState) then,
  ) = _$ReportReviewStateCopyWithImpl<$Res, ReportReviewState>;
  @useResult
  $Res call({
    List<ReportModel> reports,
    bool isLoading,
    bool isLoadingMore,
    bool hasReachedEnd,
    String? error,
    ReportStatus? currentStatus,
    IssueCategory? currentCategory,
    SortOption currentSortOption,
  });
}

/// @nodoc
class _$ReportReviewStateCopyWithImpl<$Res, $Val extends ReportReviewState>
    implements $ReportReviewStateCopyWith<$Res> {
  _$ReportReviewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReportReviewState
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
  }) {
    return _then(
      _value.copyWith(
            reports:
                null == reports
                    ? _value.reports
                    : reports // ignore: cast_nullable_to_non_nullable
                        as List<ReportModel>,
            isLoading:
                null == isLoading
                    ? _value.isLoading
                    : isLoading // ignore: cast_nullable_to_non_nullable
                        as bool,
            isLoadingMore:
                null == isLoadingMore
                    ? _value.isLoadingMore
                    : isLoadingMore // ignore: cast_nullable_to_non_nullable
                        as bool,
            hasReachedEnd:
                null == hasReachedEnd
                    ? _value.hasReachedEnd
                    : hasReachedEnd // ignore: cast_nullable_to_non_nullable
                        as bool,
            error:
                freezed == error
                    ? _value.error
                    : error // ignore: cast_nullable_to_non_nullable
                        as String?,
            currentStatus:
                freezed == currentStatus
                    ? _value.currentStatus
                    : currentStatus // ignore: cast_nullable_to_non_nullable
                        as ReportStatus?,
            currentCategory:
                freezed == currentCategory
                    ? _value.currentCategory
                    : currentCategory // ignore: cast_nullable_to_non_nullable
                        as IssueCategory?,
            currentSortOption:
                null == currentSortOption
                    ? _value.currentSortOption
                    : currentSortOption // ignore: cast_nullable_to_non_nullable
                        as SortOption,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ReportReviewStateImplCopyWith<$Res>
    implements $ReportReviewStateCopyWith<$Res> {
  factory _$$ReportReviewStateImplCopyWith(
    _$ReportReviewStateImpl value,
    $Res Function(_$ReportReviewStateImpl) then,
  ) = __$$ReportReviewStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<ReportModel> reports,
    bool isLoading,
    bool isLoadingMore,
    bool hasReachedEnd,
    String? error,
    ReportStatus? currentStatus,
    IssueCategory? currentCategory,
    SortOption currentSortOption,
  });
}

/// @nodoc
class __$$ReportReviewStateImplCopyWithImpl<$Res>
    extends _$ReportReviewStateCopyWithImpl<$Res, _$ReportReviewStateImpl>
    implements _$$ReportReviewStateImplCopyWith<$Res> {
  __$$ReportReviewStateImplCopyWithImpl(
    _$ReportReviewStateImpl _value,
    $Res Function(_$ReportReviewStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReportReviewState
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
  }) {
    return _then(
      _$ReportReviewStateImpl(
        reports:
            null == reports
                ? _value._reports
                : reports // ignore: cast_nullable_to_non_nullable
                    as List<ReportModel>,
        isLoading:
            null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                    as bool,
        isLoadingMore:
            null == isLoadingMore
                ? _value.isLoadingMore
                : isLoadingMore // ignore: cast_nullable_to_non_nullable
                    as bool,
        hasReachedEnd:
            null == hasReachedEnd
                ? _value.hasReachedEnd
                : hasReachedEnd // ignore: cast_nullable_to_non_nullable
                    as bool,
        error:
            freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                    as String?,
        currentStatus:
            freezed == currentStatus
                ? _value.currentStatus
                : currentStatus // ignore: cast_nullable_to_non_nullable
                    as ReportStatus?,
        currentCategory:
            freezed == currentCategory
                ? _value.currentCategory
                : currentCategory // ignore: cast_nullable_to_non_nullable
                    as IssueCategory?,
        currentSortOption:
            null == currentSortOption
                ? _value.currentSortOption
                : currentSortOption // ignore: cast_nullable_to_non_nullable
                    as SortOption,
      ),
    );
  }
}

/// @nodoc

class _$ReportReviewStateImpl implements _ReportReviewState {
  const _$ReportReviewStateImpl({
    final List<ReportModel> reports = const [],
    this.isLoading = true,
    this.isLoadingMore = false,
    this.hasReachedEnd = false,
    this.error,
    this.currentStatus,
    this.currentCategory,
    this.currentSortOption = SortOption.dateNewest,
  }) : _reports = reports;

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
  String toString() {
    return 'ReportReviewState(reports: $reports, isLoading: $isLoading, isLoadingMore: $isLoadingMore, hasReachedEnd: $hasReachedEnd, error: $error, currentStatus: $currentStatus, currentCategory: $currentCategory, currentSortOption: $currentSortOption)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReportReviewStateImpl &&
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
                other.currentSortOption == currentSortOption));
  }

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
  );

  /// Create a copy of ReportReviewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReportReviewStateImplCopyWith<_$ReportReviewStateImpl> get copyWith =>
      __$$ReportReviewStateImplCopyWithImpl<_$ReportReviewStateImpl>(
        this,
        _$identity,
      );
}

abstract class _ReportReviewState implements ReportReviewState {
  const factory _ReportReviewState({
    final List<ReportModel> reports,
    final bool isLoading,
    final bool isLoadingMore,
    final bool hasReachedEnd,
    final String? error,
    final ReportStatus? currentStatus,
    final IssueCategory? currentCategory,
    final SortOption currentSortOption,
  }) = _$ReportReviewStateImpl;

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

  /// Create a copy of ReportReviewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReportReviewStateImplCopyWith<_$ReportReviewStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
