// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'issue_fast_reports_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

IssueFastReportsState _$IssueFastReportsStateFromJson(
    Map<String, dynamic> json) {
  return _IssueFastReportsState.fromJson(json);
}

/// @nodoc
mixin _$IssueFastReportsState {
  List<FastReportModel> get reports => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isLoadingMore => throw _privateConstructorUsedError;
  bool get hasReachedEnd => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Serializes this IssueFastReportsState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IssueFastReportsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IssueFastReportsStateCopyWith<IssueFastReportsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IssueFastReportsStateCopyWith<$Res> {
  factory $IssueFastReportsStateCopyWith(IssueFastReportsState value,
          $Res Function(IssueFastReportsState) then) =
      _$IssueFastReportsStateCopyWithImpl<$Res, IssueFastReportsState>;
  @useResult
  $Res call(
      {List<FastReportModel> reports,
      bool isLoading,
      bool isLoadingMore,
      bool hasReachedEnd,
      String? error});
}

/// @nodoc
class _$IssueFastReportsStateCopyWithImpl<$Res,
        $Val extends IssueFastReportsState>
    implements $IssueFastReportsStateCopyWith<$Res> {
  _$IssueFastReportsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IssueFastReportsState
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
              as List<FastReportModel>,
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
abstract class _$$IssueFastReportsStateImplCopyWith<$Res>
    implements $IssueFastReportsStateCopyWith<$Res> {
  factory _$$IssueFastReportsStateImplCopyWith(
          _$IssueFastReportsStateImpl value,
          $Res Function(_$IssueFastReportsStateImpl) then) =
      __$$IssueFastReportsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<FastReportModel> reports,
      bool isLoading,
      bool isLoadingMore,
      bool hasReachedEnd,
      String? error});
}

/// @nodoc
class __$$IssueFastReportsStateImplCopyWithImpl<$Res>
    extends _$IssueFastReportsStateCopyWithImpl<$Res,
        _$IssueFastReportsStateImpl>
    implements _$$IssueFastReportsStateImplCopyWith<$Res> {
  __$$IssueFastReportsStateImplCopyWithImpl(_$IssueFastReportsStateImpl _value,
      $Res Function(_$IssueFastReportsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of IssueFastReportsState
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
    return _then(_$IssueFastReportsStateImpl(
      reports: null == reports
          ? _value._reports
          : reports // ignore: cast_nullable_to_non_nullable
              as List<FastReportModel>,
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
class _$IssueFastReportsStateImpl implements _IssueFastReportsState {
  const _$IssueFastReportsStateImpl(
      {final List<FastReportModel> reports = const [],
      this.isLoading = false,
      this.isLoadingMore = false,
      this.hasReachedEnd = false,
      this.error})
      : _reports = reports;

  factory _$IssueFastReportsStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$IssueFastReportsStateImplFromJson(json);

  final List<FastReportModel> _reports;
  @override
  @JsonKey()
  List<FastReportModel> get reports {
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
    return 'IssueFastReportsState(reports: $reports, isLoading: $isLoading, isLoadingMore: $isLoadingMore, hasReachedEnd: $hasReachedEnd, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IssueFastReportsStateImpl &&
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

  /// Create a copy of IssueFastReportsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IssueFastReportsStateImplCopyWith<_$IssueFastReportsStateImpl>
      get copyWith => __$$IssueFastReportsStateImplCopyWithImpl<
          _$IssueFastReportsStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IssueFastReportsStateImplToJson(
      this,
    );
  }
}

abstract class _IssueFastReportsState implements IssueFastReportsState {
  const factory _IssueFastReportsState(
      {final List<FastReportModel> reports,
      final bool isLoading,
      final bool isLoadingMore,
      final bool hasReachedEnd,
      final String? error}) = _$IssueFastReportsStateImpl;

  factory _IssueFastReportsState.fromJson(Map<String, dynamic> json) =
      _$IssueFastReportsStateImpl.fromJson;

  @override
  List<FastReportModel> get reports;
  @override
  bool get isLoading;
  @override
  bool get isLoadingMore;
  @override
  bool get hasReachedEnd;
  @override
  String? get error;

  /// Create a copy of IssueFastReportsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IssueFastReportsStateImplCopyWith<_$IssueFastReportsStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
