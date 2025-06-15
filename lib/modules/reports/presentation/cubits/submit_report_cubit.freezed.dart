// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'submit_report_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SubmitReportState {
  File? get image => throw _privateConstructorUsedError;
  ReportSeverity get severity => throw _privateConstructorUsedError;
  Position? get position => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get comment => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  String? get successMessage => throw _privateConstructorUsedError;

  /// Create a copy of SubmitReportState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubmitReportStateCopyWith<SubmitReportState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubmitReportStateCopyWith<$Res> {
  factory $SubmitReportStateCopyWith(
          SubmitReportState value, $Res Function(SubmitReportState) then) =
      _$SubmitReportStateCopyWithImpl<$Res, SubmitReportState>;
  @useResult
  $Res call(
      {File? image,
      ReportSeverity severity,
      Position? position,
      bool isLoading,
      String? comment,
      String? error,
      String? successMessage});
}

/// @nodoc
class _$SubmitReportStateCopyWithImpl<$Res, $Val extends SubmitReportState>
    implements $SubmitReportStateCopyWith<$Res> {
  _$SubmitReportStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubmitReportState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image = freezed,
    Object? severity = null,
    Object? position = freezed,
    Object? isLoading = null,
    Object? comment = freezed,
    Object? error = freezed,
    Object? successMessage = freezed,
  }) {
    return _then(_value.copyWith(
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as File?,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as ReportSeverity,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Position?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      successMessage: freezed == successMessage
          ? _value.successMessage
          : successMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SubmitReportStateImplCopyWith<$Res>
    implements $SubmitReportStateCopyWith<$Res> {
  factory _$$SubmitReportStateImplCopyWith(_$SubmitReportStateImpl value,
          $Res Function(_$SubmitReportStateImpl) then) =
      __$$SubmitReportStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {File? image,
      ReportSeverity severity,
      Position? position,
      bool isLoading,
      String? comment,
      String? error,
      String? successMessage});
}

/// @nodoc
class __$$SubmitReportStateImplCopyWithImpl<$Res>
    extends _$SubmitReportStateCopyWithImpl<$Res, _$SubmitReportStateImpl>
    implements _$$SubmitReportStateImplCopyWith<$Res> {
  __$$SubmitReportStateImplCopyWithImpl(_$SubmitReportStateImpl _value,
      $Res Function(_$SubmitReportStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of SubmitReportState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image = freezed,
    Object? severity = null,
    Object? position = freezed,
    Object? isLoading = null,
    Object? comment = freezed,
    Object? error = freezed,
    Object? successMessage = freezed,
  }) {
    return _then(_$SubmitReportStateImpl(
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as File?,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as ReportSeverity,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Position?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      successMessage: freezed == successMessage
          ? _value.successMessage
          : successMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SubmitReportStateImpl implements _SubmitReportState {
  const _$SubmitReportStateImpl(
      {required this.image,
      required this.severity,
      required this.position,
      required this.isLoading,
      required this.comment,
      this.error,
      this.successMessage});

  @override
  final File? image;
  @override
  final ReportSeverity severity;
  @override
  final Position? position;
  @override
  final bool isLoading;
  @override
  final String? comment;
  @override
  final String? error;
  @override
  final String? successMessage;

  @override
  String toString() {
    return 'SubmitReportState(image: $image, severity: $severity, position: $position, isLoading: $isLoading, comment: $comment, error: $error, successMessage: $successMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubmitReportStateImpl &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.successMessage, successMessage) ||
                other.successMessage == successMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, image, severity, position,
      isLoading, comment, error, successMessage);

  /// Create a copy of SubmitReportState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubmitReportStateImplCopyWith<_$SubmitReportStateImpl> get copyWith =>
      __$$SubmitReportStateImplCopyWithImpl<_$SubmitReportStateImpl>(
          this, _$identity);
}

abstract class _SubmitReportState implements SubmitReportState {
  const factory _SubmitReportState(
      {required final File? image,
      required final ReportSeverity severity,
      required final Position? position,
      required final bool isLoading,
      required final String? comment,
      final String? error,
      final String? successMessage}) = _$SubmitReportStateImpl;

  @override
  File? get image;
  @override
  ReportSeverity get severity;
  @override
  Position? get position;
  @override
  bool get isLoading;
  @override
  String? get comment;
  @override
  String? get error;
  @override
  String? get successMessage;

  /// Create a copy of SubmitReportState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubmitReportStateImplCopyWith<_$SubmitReportStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
