// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report_statistics_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ReportStatisticsState _$ReportStatisticsStateFromJson(
    Map<String, dynamic> json) {
  return _ReportStatisticsState.fromJson(json);
}

/// @nodoc
mixin _$ReportStatisticsState {
  ReportStatisticsModel? get statistics => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  DateTime? get lastUpdated => throw _privateConstructorUsedError;

  /// Serializes this ReportStatisticsState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReportStatisticsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReportStatisticsStateCopyWith<ReportStatisticsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReportStatisticsStateCopyWith<$Res> {
  factory $ReportStatisticsStateCopyWith(ReportStatisticsState value,
          $Res Function(ReportStatisticsState) then) =
      _$ReportStatisticsStateCopyWithImpl<$Res, ReportStatisticsState>;
  @useResult
  $Res call(
      {ReportStatisticsModel? statistics,
      bool isLoading,
      String? error,
      DateTime? lastUpdated});
}

/// @nodoc
class _$ReportStatisticsStateCopyWithImpl<$Res,
        $Val extends ReportStatisticsState>
    implements $ReportStatisticsStateCopyWith<$Res> {
  _$ReportStatisticsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReportStatisticsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statistics = freezed,
    Object? isLoading = null,
    Object? error = freezed,
    Object? lastUpdated = freezed,
  }) {
    return _then(_value.copyWith(
      statistics: freezed == statistics
          ? _value.statistics
          : statistics // ignore: cast_nullable_to_non_nullable
              as ReportStatisticsModel?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReportStatisticsStateImplCopyWith<$Res>
    implements $ReportStatisticsStateCopyWith<$Res> {
  factory _$$ReportStatisticsStateImplCopyWith(
          _$ReportStatisticsStateImpl value,
          $Res Function(_$ReportStatisticsStateImpl) then) =
      __$$ReportStatisticsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ReportStatisticsModel? statistics,
      bool isLoading,
      String? error,
      DateTime? lastUpdated});
}

/// @nodoc
class __$$ReportStatisticsStateImplCopyWithImpl<$Res>
    extends _$ReportStatisticsStateCopyWithImpl<$Res,
        _$ReportStatisticsStateImpl>
    implements _$$ReportStatisticsStateImplCopyWith<$Res> {
  __$$ReportStatisticsStateImplCopyWithImpl(_$ReportStatisticsStateImpl _value,
      $Res Function(_$ReportStatisticsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReportStatisticsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statistics = freezed,
    Object? isLoading = null,
    Object? error = freezed,
    Object? lastUpdated = freezed,
  }) {
    return _then(_$ReportStatisticsStateImpl(
      statistics: freezed == statistics
          ? _value.statistics
          : statistics // ignore: cast_nullable_to_non_nullable
              as ReportStatisticsModel?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReportStatisticsStateImpl implements _ReportStatisticsState {
  const _$ReportStatisticsStateImpl(
      {this.statistics, this.isLoading = true, this.error, this.lastUpdated});

  factory _$ReportStatisticsStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReportStatisticsStateImplFromJson(json);

  @override
  final ReportStatisticsModel? statistics;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;
  @override
  final DateTime? lastUpdated;

  @override
  String toString() {
    return 'ReportStatisticsState(statistics: $statistics, isLoading: $isLoading, error: $error, lastUpdated: $lastUpdated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReportStatisticsStateImpl &&
            (identical(other.statistics, statistics) ||
                other.statistics == statistics) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, statistics, isLoading, error, lastUpdated);

  /// Create a copy of ReportStatisticsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReportStatisticsStateImplCopyWith<_$ReportStatisticsStateImpl>
      get copyWith => __$$ReportStatisticsStateImplCopyWithImpl<
          _$ReportStatisticsStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReportStatisticsStateImplToJson(
      this,
    );
  }
}

abstract class _ReportStatisticsState implements ReportStatisticsState {
  const factory _ReportStatisticsState(
      {final ReportStatisticsModel? statistics,
      final bool isLoading,
      final String? error,
      final DateTime? lastUpdated}) = _$ReportStatisticsStateImpl;

  factory _ReportStatisticsState.fromJson(Map<String, dynamic> json) =
      _$ReportStatisticsStateImpl.fromJson;

  @override
  ReportStatisticsModel? get statistics;
  @override
  bool get isLoading;
  @override
  String? get error;
  @override
  DateTime? get lastUpdated;

  /// Create a copy of ReportStatisticsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReportStatisticsStateImplCopyWith<_$ReportStatisticsStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
