// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'otp_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$OtpState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            bool canResend, int remainingTime, int registrationExpiryTime)
        initial,
    required TResult Function() loading,
    required TResult Function() resendSuccess,
    required TResult Function() successAndRequiresPasswordReset,
    required TResult Function(String phoneNumber, String password)
        successAndRequiresProfileCompletion,
    required TResult Function(ApiError error) error,
    required TResult Function() registrationExpired,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            bool canResend, int remainingTime, int registrationExpiryTime)?
        initial,
    TResult? Function()? loading,
    TResult? Function()? resendSuccess,
    TResult? Function()? successAndRequiresPasswordReset,
    TResult? Function(String phoneNumber, String password)?
        successAndRequiresProfileCompletion,
    TResult? Function(ApiError error)? error,
    TResult? Function()? registrationExpired,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            bool canResend, int remainingTime, int registrationExpiryTime)?
        initial,
    TResult Function()? loading,
    TResult Function()? resendSuccess,
    TResult Function()? successAndRequiresPasswordReset,
    TResult Function(String phoneNumber, String password)?
        successAndRequiresProfileCompletion,
    TResult Function(ApiError error)? error,
    TResult Function()? registrationExpired,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_ResendSuccess value) resendSuccess,
    required TResult Function(_RequiresPasswordReset value)
        successAndRequiresPasswordReset,
    required TResult Function(_RequiresProfileCompletion value)
        successAndRequiresProfileCompletion,
    required TResult Function(_Error value) error,
    required TResult Function(_RegistrationExpired value) registrationExpired,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_ResendSuccess value)? resendSuccess,
    TResult? Function(_RequiresPasswordReset value)?
        successAndRequiresPasswordReset,
    TResult? Function(_RequiresProfileCompletion value)?
        successAndRequiresProfileCompletion,
    TResult? Function(_Error value)? error,
    TResult? Function(_RegistrationExpired value)? registrationExpired,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_ResendSuccess value)? resendSuccess,
    TResult Function(_RequiresPasswordReset value)?
        successAndRequiresPasswordReset,
    TResult Function(_RequiresProfileCompletion value)?
        successAndRequiresProfileCompletion,
    TResult Function(_Error value)? error,
    TResult Function(_RegistrationExpired value)? registrationExpired,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OtpStateCopyWith<$Res> {
  factory $OtpStateCopyWith(OtpState value, $Res Function(OtpState) then) =
      _$OtpStateCopyWithImpl<$Res, OtpState>;
}

/// @nodoc
class _$OtpStateCopyWithImpl<$Res, $Val extends OtpState>
    implements $OtpStateCopyWith<$Res> {
  _$OtpStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OtpState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool canResend, int remainingTime, int registrationExpiryTime});
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$OtpStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of OtpState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? canResend = null,
    Object? remainingTime = null,
    Object? registrationExpiryTime = null,
  }) {
    return _then(_$InitialImpl(
      canResend: null == canResend
          ? _value.canResend
          : canResend // ignore: cast_nullable_to_non_nullable
              as bool,
      remainingTime: null == remainingTime
          ? _value.remainingTime
          : remainingTime // ignore: cast_nullable_to_non_nullable
              as int,
      registrationExpiryTime: null == registrationExpiryTime
          ? _value.registrationExpiryTime
          : registrationExpiryTime // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl(
      {this.canResend = false,
      this.remainingTime = 10,
      this.registrationExpiryTime = 20});

  @override
  @JsonKey()
  final bool canResend;
  @override
  @JsonKey()
  final int remainingTime;
  @override
  @JsonKey()
  final int registrationExpiryTime;

  @override
  String toString() {
    return 'OtpState.initial(canResend: $canResend, remainingTime: $remainingTime, registrationExpiryTime: $registrationExpiryTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialImpl &&
            (identical(other.canResend, canResend) ||
                other.canResend == canResend) &&
            (identical(other.remainingTime, remainingTime) ||
                other.remainingTime == remainingTime) &&
            (identical(other.registrationExpiryTime, registrationExpiryTime) ||
                other.registrationExpiryTime == registrationExpiryTime));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, canResend, remainingTime, registrationExpiryTime);

  /// Create a copy of OtpState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      __$$InitialImplCopyWithImpl<_$InitialImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            bool canResend, int remainingTime, int registrationExpiryTime)
        initial,
    required TResult Function() loading,
    required TResult Function() resendSuccess,
    required TResult Function() successAndRequiresPasswordReset,
    required TResult Function(String phoneNumber, String password)
        successAndRequiresProfileCompletion,
    required TResult Function(ApiError error) error,
    required TResult Function() registrationExpired,
  }) {
    return initial(canResend, remainingTime, registrationExpiryTime);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            bool canResend, int remainingTime, int registrationExpiryTime)?
        initial,
    TResult? Function()? loading,
    TResult? Function()? resendSuccess,
    TResult? Function()? successAndRequiresPasswordReset,
    TResult? Function(String phoneNumber, String password)?
        successAndRequiresProfileCompletion,
    TResult? Function(ApiError error)? error,
    TResult? Function()? registrationExpired,
  }) {
    return initial?.call(canResend, remainingTime, registrationExpiryTime);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            bool canResend, int remainingTime, int registrationExpiryTime)?
        initial,
    TResult Function()? loading,
    TResult Function()? resendSuccess,
    TResult Function()? successAndRequiresPasswordReset,
    TResult Function(String phoneNumber, String password)?
        successAndRequiresProfileCompletion,
    TResult Function(ApiError error)? error,
    TResult Function()? registrationExpired,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(canResend, remainingTime, registrationExpiryTime);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_ResendSuccess value) resendSuccess,
    required TResult Function(_RequiresPasswordReset value)
        successAndRequiresPasswordReset,
    required TResult Function(_RequiresProfileCompletion value)
        successAndRequiresProfileCompletion,
    required TResult Function(_Error value) error,
    required TResult Function(_RegistrationExpired value) registrationExpired,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_ResendSuccess value)? resendSuccess,
    TResult? Function(_RequiresPasswordReset value)?
        successAndRequiresPasswordReset,
    TResult? Function(_RequiresProfileCompletion value)?
        successAndRequiresProfileCompletion,
    TResult? Function(_Error value)? error,
    TResult? Function(_RegistrationExpired value)? registrationExpired,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_ResendSuccess value)? resendSuccess,
    TResult Function(_RequiresPasswordReset value)?
        successAndRequiresPasswordReset,
    TResult Function(_RequiresProfileCompletion value)?
        successAndRequiresProfileCompletion,
    TResult Function(_Error value)? error,
    TResult Function(_RegistrationExpired value)? registrationExpired,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements OtpState {
  const factory _Initial(
      {final bool canResend,
      final int remainingTime,
      final int registrationExpiryTime}) = _$InitialImpl;

  bool get canResend;
  int get remainingTime;
  int get registrationExpiryTime;

  /// Create a copy of OtpState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$OtpStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of OtpState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'OtpState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            bool canResend, int remainingTime, int registrationExpiryTime)
        initial,
    required TResult Function() loading,
    required TResult Function() resendSuccess,
    required TResult Function() successAndRequiresPasswordReset,
    required TResult Function(String phoneNumber, String password)
        successAndRequiresProfileCompletion,
    required TResult Function(ApiError error) error,
    required TResult Function() registrationExpired,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            bool canResend, int remainingTime, int registrationExpiryTime)?
        initial,
    TResult? Function()? loading,
    TResult? Function()? resendSuccess,
    TResult? Function()? successAndRequiresPasswordReset,
    TResult? Function(String phoneNumber, String password)?
        successAndRequiresProfileCompletion,
    TResult? Function(ApiError error)? error,
    TResult? Function()? registrationExpired,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            bool canResend, int remainingTime, int registrationExpiryTime)?
        initial,
    TResult Function()? loading,
    TResult Function()? resendSuccess,
    TResult Function()? successAndRequiresPasswordReset,
    TResult Function(String phoneNumber, String password)?
        successAndRequiresProfileCompletion,
    TResult Function(ApiError error)? error,
    TResult Function()? registrationExpired,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_ResendSuccess value) resendSuccess,
    required TResult Function(_RequiresPasswordReset value)
        successAndRequiresPasswordReset,
    required TResult Function(_RequiresProfileCompletion value)
        successAndRequiresProfileCompletion,
    required TResult Function(_Error value) error,
    required TResult Function(_RegistrationExpired value) registrationExpired,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_ResendSuccess value)? resendSuccess,
    TResult? Function(_RequiresPasswordReset value)?
        successAndRequiresPasswordReset,
    TResult? Function(_RequiresProfileCompletion value)?
        successAndRequiresProfileCompletion,
    TResult? Function(_Error value)? error,
    TResult? Function(_RegistrationExpired value)? registrationExpired,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_ResendSuccess value)? resendSuccess,
    TResult Function(_RequiresPasswordReset value)?
        successAndRequiresPasswordReset,
    TResult Function(_RequiresProfileCompletion value)?
        successAndRequiresProfileCompletion,
    TResult Function(_Error value)? error,
    TResult Function(_RegistrationExpired value)? registrationExpired,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements OtpState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$ResendSuccessImplCopyWith<$Res> {
  factory _$$ResendSuccessImplCopyWith(
          _$ResendSuccessImpl value, $Res Function(_$ResendSuccessImpl) then) =
      __$$ResendSuccessImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ResendSuccessImplCopyWithImpl<$Res>
    extends _$OtpStateCopyWithImpl<$Res, _$ResendSuccessImpl>
    implements _$$ResendSuccessImplCopyWith<$Res> {
  __$$ResendSuccessImplCopyWithImpl(
      _$ResendSuccessImpl _value, $Res Function(_$ResendSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of OtpState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ResendSuccessImpl implements _ResendSuccess {
  const _$ResendSuccessImpl();

  @override
  String toString() {
    return 'OtpState.resendSuccess()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ResendSuccessImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            bool canResend, int remainingTime, int registrationExpiryTime)
        initial,
    required TResult Function() loading,
    required TResult Function() resendSuccess,
    required TResult Function() successAndRequiresPasswordReset,
    required TResult Function(String phoneNumber, String password)
        successAndRequiresProfileCompletion,
    required TResult Function(ApiError error) error,
    required TResult Function() registrationExpired,
  }) {
    return resendSuccess();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            bool canResend, int remainingTime, int registrationExpiryTime)?
        initial,
    TResult? Function()? loading,
    TResult? Function()? resendSuccess,
    TResult? Function()? successAndRequiresPasswordReset,
    TResult? Function(String phoneNumber, String password)?
        successAndRequiresProfileCompletion,
    TResult? Function(ApiError error)? error,
    TResult? Function()? registrationExpired,
  }) {
    return resendSuccess?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            bool canResend, int remainingTime, int registrationExpiryTime)?
        initial,
    TResult Function()? loading,
    TResult Function()? resendSuccess,
    TResult Function()? successAndRequiresPasswordReset,
    TResult Function(String phoneNumber, String password)?
        successAndRequiresProfileCompletion,
    TResult Function(ApiError error)? error,
    TResult Function()? registrationExpired,
    required TResult orElse(),
  }) {
    if (resendSuccess != null) {
      return resendSuccess();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_ResendSuccess value) resendSuccess,
    required TResult Function(_RequiresPasswordReset value)
        successAndRequiresPasswordReset,
    required TResult Function(_RequiresProfileCompletion value)
        successAndRequiresProfileCompletion,
    required TResult Function(_Error value) error,
    required TResult Function(_RegistrationExpired value) registrationExpired,
  }) {
    return resendSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_ResendSuccess value)? resendSuccess,
    TResult? Function(_RequiresPasswordReset value)?
        successAndRequiresPasswordReset,
    TResult? Function(_RequiresProfileCompletion value)?
        successAndRequiresProfileCompletion,
    TResult? Function(_Error value)? error,
    TResult? Function(_RegistrationExpired value)? registrationExpired,
  }) {
    return resendSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_ResendSuccess value)? resendSuccess,
    TResult Function(_RequiresPasswordReset value)?
        successAndRequiresPasswordReset,
    TResult Function(_RequiresProfileCompletion value)?
        successAndRequiresProfileCompletion,
    TResult Function(_Error value)? error,
    TResult Function(_RegistrationExpired value)? registrationExpired,
    required TResult orElse(),
  }) {
    if (resendSuccess != null) {
      return resendSuccess(this);
    }
    return orElse();
  }
}

abstract class _ResendSuccess implements OtpState {
  const factory _ResendSuccess() = _$ResendSuccessImpl;
}

/// @nodoc
abstract class _$$RequiresPasswordResetImplCopyWith<$Res> {
  factory _$$RequiresPasswordResetImplCopyWith(
          _$RequiresPasswordResetImpl value,
          $Res Function(_$RequiresPasswordResetImpl) then) =
      __$$RequiresPasswordResetImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RequiresPasswordResetImplCopyWithImpl<$Res>
    extends _$OtpStateCopyWithImpl<$Res, _$RequiresPasswordResetImpl>
    implements _$$RequiresPasswordResetImplCopyWith<$Res> {
  __$$RequiresPasswordResetImplCopyWithImpl(_$RequiresPasswordResetImpl _value,
      $Res Function(_$RequiresPasswordResetImpl) _then)
      : super(_value, _then);

  /// Create a copy of OtpState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RequiresPasswordResetImpl implements _RequiresPasswordReset {
  const _$RequiresPasswordResetImpl();

  @override
  String toString() {
    return 'OtpState.successAndRequiresPasswordReset()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequiresPasswordResetImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            bool canResend, int remainingTime, int registrationExpiryTime)
        initial,
    required TResult Function() loading,
    required TResult Function() resendSuccess,
    required TResult Function() successAndRequiresPasswordReset,
    required TResult Function(String phoneNumber, String password)
        successAndRequiresProfileCompletion,
    required TResult Function(ApiError error) error,
    required TResult Function() registrationExpired,
  }) {
    return successAndRequiresPasswordReset();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            bool canResend, int remainingTime, int registrationExpiryTime)?
        initial,
    TResult? Function()? loading,
    TResult? Function()? resendSuccess,
    TResult? Function()? successAndRequiresPasswordReset,
    TResult? Function(String phoneNumber, String password)?
        successAndRequiresProfileCompletion,
    TResult? Function(ApiError error)? error,
    TResult? Function()? registrationExpired,
  }) {
    return successAndRequiresPasswordReset?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            bool canResend, int remainingTime, int registrationExpiryTime)?
        initial,
    TResult Function()? loading,
    TResult Function()? resendSuccess,
    TResult Function()? successAndRequiresPasswordReset,
    TResult Function(String phoneNumber, String password)?
        successAndRequiresProfileCompletion,
    TResult Function(ApiError error)? error,
    TResult Function()? registrationExpired,
    required TResult orElse(),
  }) {
    if (successAndRequiresPasswordReset != null) {
      return successAndRequiresPasswordReset();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_ResendSuccess value) resendSuccess,
    required TResult Function(_RequiresPasswordReset value)
        successAndRequiresPasswordReset,
    required TResult Function(_RequiresProfileCompletion value)
        successAndRequiresProfileCompletion,
    required TResult Function(_Error value) error,
    required TResult Function(_RegistrationExpired value) registrationExpired,
  }) {
    return successAndRequiresPasswordReset(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_ResendSuccess value)? resendSuccess,
    TResult? Function(_RequiresPasswordReset value)?
        successAndRequiresPasswordReset,
    TResult? Function(_RequiresProfileCompletion value)?
        successAndRequiresProfileCompletion,
    TResult? Function(_Error value)? error,
    TResult? Function(_RegistrationExpired value)? registrationExpired,
  }) {
    return successAndRequiresPasswordReset?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_ResendSuccess value)? resendSuccess,
    TResult Function(_RequiresPasswordReset value)?
        successAndRequiresPasswordReset,
    TResult Function(_RequiresProfileCompletion value)?
        successAndRequiresProfileCompletion,
    TResult Function(_Error value)? error,
    TResult Function(_RegistrationExpired value)? registrationExpired,
    required TResult orElse(),
  }) {
    if (successAndRequiresPasswordReset != null) {
      return successAndRequiresPasswordReset(this);
    }
    return orElse();
  }
}

abstract class _RequiresPasswordReset implements OtpState {
  const factory _RequiresPasswordReset() = _$RequiresPasswordResetImpl;
}

/// @nodoc
abstract class _$$RequiresProfileCompletionImplCopyWith<$Res> {
  factory _$$RequiresProfileCompletionImplCopyWith(
          _$RequiresProfileCompletionImpl value,
          $Res Function(_$RequiresProfileCompletionImpl) then) =
      __$$RequiresProfileCompletionImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String phoneNumber, String password});
}

/// @nodoc
class __$$RequiresProfileCompletionImplCopyWithImpl<$Res>
    extends _$OtpStateCopyWithImpl<$Res, _$RequiresProfileCompletionImpl>
    implements _$$RequiresProfileCompletionImplCopyWith<$Res> {
  __$$RequiresProfileCompletionImplCopyWithImpl(
      _$RequiresProfileCompletionImpl _value,
      $Res Function(_$RequiresProfileCompletionImpl) _then)
      : super(_value, _then);

  /// Create a copy of OtpState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phoneNumber = null,
    Object? password = null,
  }) {
    return _then(_$RequiresProfileCompletionImpl(
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RequiresProfileCompletionImpl implements _RequiresProfileCompletion {
  const _$RequiresProfileCompletionImpl(
      {required this.phoneNumber, required this.password});

  @override
  final String phoneNumber;
  @override
  final String password;

  @override
  String toString() {
    return 'OtpState.successAndRequiresProfileCompletion(phoneNumber: $phoneNumber, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequiresProfileCompletionImpl &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, phoneNumber, password);

  /// Create a copy of OtpState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RequiresProfileCompletionImplCopyWith<_$RequiresProfileCompletionImpl>
      get copyWith => __$$RequiresProfileCompletionImplCopyWithImpl<
          _$RequiresProfileCompletionImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            bool canResend, int remainingTime, int registrationExpiryTime)
        initial,
    required TResult Function() loading,
    required TResult Function() resendSuccess,
    required TResult Function() successAndRequiresPasswordReset,
    required TResult Function(String phoneNumber, String password)
        successAndRequiresProfileCompletion,
    required TResult Function(ApiError error) error,
    required TResult Function() registrationExpired,
  }) {
    return successAndRequiresProfileCompletion(phoneNumber, password);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            bool canResend, int remainingTime, int registrationExpiryTime)?
        initial,
    TResult? Function()? loading,
    TResult? Function()? resendSuccess,
    TResult? Function()? successAndRequiresPasswordReset,
    TResult? Function(String phoneNumber, String password)?
        successAndRequiresProfileCompletion,
    TResult? Function(ApiError error)? error,
    TResult? Function()? registrationExpired,
  }) {
    return successAndRequiresProfileCompletion?.call(phoneNumber, password);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            bool canResend, int remainingTime, int registrationExpiryTime)?
        initial,
    TResult Function()? loading,
    TResult Function()? resendSuccess,
    TResult Function()? successAndRequiresPasswordReset,
    TResult Function(String phoneNumber, String password)?
        successAndRequiresProfileCompletion,
    TResult Function(ApiError error)? error,
    TResult Function()? registrationExpired,
    required TResult orElse(),
  }) {
    if (successAndRequiresProfileCompletion != null) {
      return successAndRequiresProfileCompletion(phoneNumber, password);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_ResendSuccess value) resendSuccess,
    required TResult Function(_RequiresPasswordReset value)
        successAndRequiresPasswordReset,
    required TResult Function(_RequiresProfileCompletion value)
        successAndRequiresProfileCompletion,
    required TResult Function(_Error value) error,
    required TResult Function(_RegistrationExpired value) registrationExpired,
  }) {
    return successAndRequiresProfileCompletion(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_ResendSuccess value)? resendSuccess,
    TResult? Function(_RequiresPasswordReset value)?
        successAndRequiresPasswordReset,
    TResult? Function(_RequiresProfileCompletion value)?
        successAndRequiresProfileCompletion,
    TResult? Function(_Error value)? error,
    TResult? Function(_RegistrationExpired value)? registrationExpired,
  }) {
    return successAndRequiresProfileCompletion?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_ResendSuccess value)? resendSuccess,
    TResult Function(_RequiresPasswordReset value)?
        successAndRequiresPasswordReset,
    TResult Function(_RequiresProfileCompletion value)?
        successAndRequiresProfileCompletion,
    TResult Function(_Error value)? error,
    TResult Function(_RegistrationExpired value)? registrationExpired,
    required TResult orElse(),
  }) {
    if (successAndRequiresProfileCompletion != null) {
      return successAndRequiresProfileCompletion(this);
    }
    return orElse();
  }
}

abstract class _RequiresProfileCompletion implements OtpState {
  const factory _RequiresProfileCompletion(
      {required final String phoneNumber,
      required final String password}) = _$RequiresProfileCompletionImpl;

  String get phoneNumber;
  String get password;

  /// Create a copy of OtpState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RequiresProfileCompletionImplCopyWith<_$RequiresProfileCompletionImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ApiError error});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$OtpStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of OtpState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$ErrorImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as ApiError,
    ));
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl(this.error);

  @override
  final ApiError error;

  @override
  String toString() {
    return 'OtpState.error(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  /// Create a copy of OtpState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            bool canResend, int remainingTime, int registrationExpiryTime)
        initial,
    required TResult Function() loading,
    required TResult Function() resendSuccess,
    required TResult Function() successAndRequiresPasswordReset,
    required TResult Function(String phoneNumber, String password)
        successAndRequiresProfileCompletion,
    required TResult Function(ApiError error) error,
    required TResult Function() registrationExpired,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            bool canResend, int remainingTime, int registrationExpiryTime)?
        initial,
    TResult? Function()? loading,
    TResult? Function()? resendSuccess,
    TResult? Function()? successAndRequiresPasswordReset,
    TResult? Function(String phoneNumber, String password)?
        successAndRequiresProfileCompletion,
    TResult? Function(ApiError error)? error,
    TResult? Function()? registrationExpired,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            bool canResend, int remainingTime, int registrationExpiryTime)?
        initial,
    TResult Function()? loading,
    TResult Function()? resendSuccess,
    TResult Function()? successAndRequiresPasswordReset,
    TResult Function(String phoneNumber, String password)?
        successAndRequiresProfileCompletion,
    TResult Function(ApiError error)? error,
    TResult Function()? registrationExpired,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_ResendSuccess value) resendSuccess,
    required TResult Function(_RequiresPasswordReset value)
        successAndRequiresPasswordReset,
    required TResult Function(_RequiresProfileCompletion value)
        successAndRequiresProfileCompletion,
    required TResult Function(_Error value) error,
    required TResult Function(_RegistrationExpired value) registrationExpired,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_ResendSuccess value)? resendSuccess,
    TResult? Function(_RequiresPasswordReset value)?
        successAndRequiresPasswordReset,
    TResult? Function(_RequiresProfileCompletion value)?
        successAndRequiresProfileCompletion,
    TResult? Function(_Error value)? error,
    TResult? Function(_RegistrationExpired value)? registrationExpired,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_ResendSuccess value)? resendSuccess,
    TResult Function(_RequiresPasswordReset value)?
        successAndRequiresPasswordReset,
    TResult Function(_RequiresProfileCompletion value)?
        successAndRequiresProfileCompletion,
    TResult Function(_Error value)? error,
    TResult Function(_RegistrationExpired value)? registrationExpired,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements OtpState {
  const factory _Error(final ApiError error) = _$ErrorImpl;

  ApiError get error;

  /// Create a copy of OtpState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RegistrationExpiredImplCopyWith<$Res> {
  factory _$$RegistrationExpiredImplCopyWith(_$RegistrationExpiredImpl value,
          $Res Function(_$RegistrationExpiredImpl) then) =
      __$$RegistrationExpiredImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RegistrationExpiredImplCopyWithImpl<$Res>
    extends _$OtpStateCopyWithImpl<$Res, _$RegistrationExpiredImpl>
    implements _$$RegistrationExpiredImplCopyWith<$Res> {
  __$$RegistrationExpiredImplCopyWithImpl(_$RegistrationExpiredImpl _value,
      $Res Function(_$RegistrationExpiredImpl) _then)
      : super(_value, _then);

  /// Create a copy of OtpState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RegistrationExpiredImpl implements _RegistrationExpired {
  const _$RegistrationExpiredImpl();

  @override
  String toString() {
    return 'OtpState.registrationExpired()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegistrationExpiredImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            bool canResend, int remainingTime, int registrationExpiryTime)
        initial,
    required TResult Function() loading,
    required TResult Function() resendSuccess,
    required TResult Function() successAndRequiresPasswordReset,
    required TResult Function(String phoneNumber, String password)
        successAndRequiresProfileCompletion,
    required TResult Function(ApiError error) error,
    required TResult Function() registrationExpired,
  }) {
    return registrationExpired();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            bool canResend, int remainingTime, int registrationExpiryTime)?
        initial,
    TResult? Function()? loading,
    TResult? Function()? resendSuccess,
    TResult? Function()? successAndRequiresPasswordReset,
    TResult? Function(String phoneNumber, String password)?
        successAndRequiresProfileCompletion,
    TResult? Function(ApiError error)? error,
    TResult? Function()? registrationExpired,
  }) {
    return registrationExpired?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            bool canResend, int remainingTime, int registrationExpiryTime)?
        initial,
    TResult Function()? loading,
    TResult Function()? resendSuccess,
    TResult Function()? successAndRequiresPasswordReset,
    TResult Function(String phoneNumber, String password)?
        successAndRequiresProfileCompletion,
    TResult Function(ApiError error)? error,
    TResult Function()? registrationExpired,
    required TResult orElse(),
  }) {
    if (registrationExpired != null) {
      return registrationExpired();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_ResendSuccess value) resendSuccess,
    required TResult Function(_RequiresPasswordReset value)
        successAndRequiresPasswordReset,
    required TResult Function(_RequiresProfileCompletion value)
        successAndRequiresProfileCompletion,
    required TResult Function(_Error value) error,
    required TResult Function(_RegistrationExpired value) registrationExpired,
  }) {
    return registrationExpired(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_ResendSuccess value)? resendSuccess,
    TResult? Function(_RequiresPasswordReset value)?
        successAndRequiresPasswordReset,
    TResult? Function(_RequiresProfileCompletion value)?
        successAndRequiresProfileCompletion,
    TResult? Function(_Error value)? error,
    TResult? Function(_RegistrationExpired value)? registrationExpired,
  }) {
    return registrationExpired?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_ResendSuccess value)? resendSuccess,
    TResult Function(_RequiresPasswordReset value)?
        successAndRequiresPasswordReset,
    TResult Function(_RequiresProfileCompletion value)?
        successAndRequiresProfileCompletion,
    TResult Function(_Error value)? error,
    TResult Function(_RegistrationExpired value)? registrationExpired,
    required TResult orElse(),
  }) {
    if (registrationExpired != null) {
      return registrationExpired(this);
    }
    return orElse();
  }
}

abstract class _RegistrationExpired implements OtpState {
  const factory _RegistrationExpired() = _$RegistrationExpiredImpl;
}
