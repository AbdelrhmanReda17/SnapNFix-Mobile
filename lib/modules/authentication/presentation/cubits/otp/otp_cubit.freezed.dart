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
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$OtpState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Session session) success,
    required TResult Function() resendSuccess,
    required TResult Function() requiresProfile,
    required TResult Function() requiresPasswordReset,
    required TResult Function(ApiErrorModel error) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(Session session)? success,
    TResult? Function()? resendSuccess,
    TResult? Function()? requiresProfile,
    TResult? Function()? requiresPasswordReset,
    TResult? Function(ApiErrorModel error)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Session session)? success,
    TResult Function()? resendSuccess,
    TResult Function()? requiresProfile,
    TResult Function()? requiresPasswordReset,
    TResult Function(ApiErrorModel error)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_ResendSuccess value) resendSuccess,
    required TResult Function(_RequiresProfile value) requiresProfile,
    required TResult Function(_RequiresPasswordReset value)
    requiresPasswordReset,
    required TResult Function(_Error value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_ResendSuccess value)? resendSuccess,
    TResult? Function(_RequiresProfile value)? requiresProfile,
    TResult? Function(_RequiresPasswordReset value)? requiresPasswordReset,
    TResult? Function(_Error value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_ResendSuccess value)? resendSuccess,
    TResult Function(_RequiresProfile value)? requiresProfile,
    TResult Function(_RequiresPasswordReset value)? requiresPasswordReset,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
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
    _$InitialImpl value,
    $Res Function(_$InitialImpl) then,
  ) = __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$OtpStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
    _$InitialImpl _value,
    $Res Function(_$InitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OtpState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'OtpState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Session session) success,
    required TResult Function() resendSuccess,
    required TResult Function() requiresProfile,
    required TResult Function() requiresPasswordReset,
    required TResult Function(ApiErrorModel error) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(Session session)? success,
    TResult? Function()? resendSuccess,
    TResult? Function()? requiresProfile,
    TResult? Function()? requiresPasswordReset,
    TResult? Function(ApiErrorModel error)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Session session)? success,
    TResult Function()? resendSuccess,
    TResult Function()? requiresProfile,
    TResult Function()? requiresPasswordReset,
    TResult Function(ApiErrorModel error)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_ResendSuccess value) resendSuccess,
    required TResult Function(_RequiresProfile value) requiresProfile,
    required TResult Function(_RequiresPasswordReset value)
    requiresPasswordReset,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_ResendSuccess value)? resendSuccess,
    TResult? Function(_RequiresProfile value)? requiresProfile,
    TResult? Function(_RequiresPasswordReset value)? requiresPasswordReset,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_ResendSuccess value)? resendSuccess,
    TResult Function(_RequiresProfile value)? requiresProfile,
    TResult Function(_RequiresPasswordReset value)? requiresPasswordReset,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements OtpState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
    _$LoadingImpl value,
    $Res Function(_$LoadingImpl) then,
  ) = __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$OtpStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
    _$LoadingImpl _value,
    $Res Function(_$LoadingImpl) _then,
  ) : super(_value, _then);

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
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Session session) success,
    required TResult Function() resendSuccess,
    required TResult Function() requiresProfile,
    required TResult Function() requiresPasswordReset,
    required TResult Function(ApiErrorModel error) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(Session session)? success,
    TResult? Function()? resendSuccess,
    TResult? Function()? requiresProfile,
    TResult? Function()? requiresPasswordReset,
    TResult? Function(ApiErrorModel error)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Session session)? success,
    TResult Function()? resendSuccess,
    TResult Function()? requiresProfile,
    TResult Function()? requiresPasswordReset,
    TResult Function(ApiErrorModel error)? error,
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
    required TResult Function(_Success value) success,
    required TResult Function(_ResendSuccess value) resendSuccess,
    required TResult Function(_RequiresProfile value) requiresProfile,
    required TResult Function(_RequiresPasswordReset value)
    requiresPasswordReset,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_ResendSuccess value)? resendSuccess,
    TResult? Function(_RequiresProfile value)? requiresProfile,
    TResult? Function(_RequiresPasswordReset value)? requiresPasswordReset,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_ResendSuccess value)? resendSuccess,
    TResult Function(_RequiresProfile value)? requiresProfile,
    TResult Function(_RequiresPasswordReset value)? requiresPasswordReset,
    TResult Function(_Error value)? error,
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
abstract class _$$SuccessImplCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
    _$SuccessImpl value,
    $Res Function(_$SuccessImpl) then,
  ) = __$$SuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Session session});
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$OtpStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
    _$SuccessImpl _value,
    $Res Function(_$SuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OtpState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? session = null}) {
    return _then(
      _$SuccessImpl(
        null == session
            ? _value.session
            : session // ignore: cast_nullable_to_non_nullable
                as Session,
      ),
    );
  }
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl(this.session);

  @override
  final Session session;

  @override
  String toString() {
    return 'OtpState.success(session: $session)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            (identical(other.session, session) || other.session == session));
  }

  @override
  int get hashCode => Object.hash(runtimeType, session);

  /// Create a copy of OtpState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Session session) success,
    required TResult Function() resendSuccess,
    required TResult Function() requiresProfile,
    required TResult Function() requiresPasswordReset,
    required TResult Function(ApiErrorModel error) error,
  }) {
    return success(session);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(Session session)? success,
    TResult? Function()? resendSuccess,
    TResult? Function()? requiresProfile,
    TResult? Function()? requiresPasswordReset,
    TResult? Function(ApiErrorModel error)? error,
  }) {
    return success?.call(session);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Session session)? success,
    TResult Function()? resendSuccess,
    TResult Function()? requiresProfile,
    TResult Function()? requiresPasswordReset,
    TResult Function(ApiErrorModel error)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(session);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_ResendSuccess value) resendSuccess,
    required TResult Function(_RequiresProfile value) requiresProfile,
    required TResult Function(_RequiresPasswordReset value)
    requiresPasswordReset,
    required TResult Function(_Error value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_ResendSuccess value)? resendSuccess,
    TResult? Function(_RequiresProfile value)? requiresProfile,
    TResult? Function(_RequiresPasswordReset value)? requiresPasswordReset,
    TResult? Function(_Error value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_ResendSuccess value)? resendSuccess,
    TResult Function(_RequiresProfile value)? requiresProfile,
    TResult Function(_RequiresPasswordReset value)? requiresPasswordReset,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success implements OtpState {
  const factory _Success(final Session session) = _$SuccessImpl;

  Session get session;

  /// Create a copy of OtpState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ResendSuccessImplCopyWith<$Res> {
  factory _$$ResendSuccessImplCopyWith(
    _$ResendSuccessImpl value,
    $Res Function(_$ResendSuccessImpl) then,
  ) = __$$ResendSuccessImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ResendSuccessImplCopyWithImpl<$Res>
    extends _$OtpStateCopyWithImpl<$Res, _$ResendSuccessImpl>
    implements _$$ResendSuccessImplCopyWith<$Res> {
  __$$ResendSuccessImplCopyWithImpl(
    _$ResendSuccessImpl _value,
    $Res Function(_$ResendSuccessImpl) _then,
  ) : super(_value, _then);

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
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Session session) success,
    required TResult Function() resendSuccess,
    required TResult Function() requiresProfile,
    required TResult Function() requiresPasswordReset,
    required TResult Function(ApiErrorModel error) error,
  }) {
    return resendSuccess();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(Session session)? success,
    TResult? Function()? resendSuccess,
    TResult? Function()? requiresProfile,
    TResult? Function()? requiresPasswordReset,
    TResult? Function(ApiErrorModel error)? error,
  }) {
    return resendSuccess?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Session session)? success,
    TResult Function()? resendSuccess,
    TResult Function()? requiresProfile,
    TResult Function()? requiresPasswordReset,
    TResult Function(ApiErrorModel error)? error,
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
    required TResult Function(_Success value) success,
    required TResult Function(_ResendSuccess value) resendSuccess,
    required TResult Function(_RequiresProfile value) requiresProfile,
    required TResult Function(_RequiresPasswordReset value)
    requiresPasswordReset,
    required TResult Function(_Error value) error,
  }) {
    return resendSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_ResendSuccess value)? resendSuccess,
    TResult? Function(_RequiresProfile value)? requiresProfile,
    TResult? Function(_RequiresPasswordReset value)? requiresPasswordReset,
    TResult? Function(_Error value)? error,
  }) {
    return resendSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_ResendSuccess value)? resendSuccess,
    TResult Function(_RequiresProfile value)? requiresProfile,
    TResult Function(_RequiresPasswordReset value)? requiresPasswordReset,
    TResult Function(_Error value)? error,
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
abstract class _$$RequiresProfileImplCopyWith<$Res> {
  factory _$$RequiresProfileImplCopyWith(
    _$RequiresProfileImpl value,
    $Res Function(_$RequiresProfileImpl) then,
  ) = __$$RequiresProfileImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RequiresProfileImplCopyWithImpl<$Res>
    extends _$OtpStateCopyWithImpl<$Res, _$RequiresProfileImpl>
    implements _$$RequiresProfileImplCopyWith<$Res> {
  __$$RequiresProfileImplCopyWithImpl(
    _$RequiresProfileImpl _value,
    $Res Function(_$RequiresProfileImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OtpState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RequiresProfileImpl implements _RequiresProfile {
  const _$RequiresProfileImpl();

  @override
  String toString() {
    return 'OtpState.requiresProfile()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RequiresProfileImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Session session) success,
    required TResult Function() resendSuccess,
    required TResult Function() requiresProfile,
    required TResult Function() requiresPasswordReset,
    required TResult Function(ApiErrorModel error) error,
  }) {
    return requiresProfile();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(Session session)? success,
    TResult? Function()? resendSuccess,
    TResult? Function()? requiresProfile,
    TResult? Function()? requiresPasswordReset,
    TResult? Function(ApiErrorModel error)? error,
  }) {
    return requiresProfile?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Session session)? success,
    TResult Function()? resendSuccess,
    TResult Function()? requiresProfile,
    TResult Function()? requiresPasswordReset,
    TResult Function(ApiErrorModel error)? error,
    required TResult orElse(),
  }) {
    if (requiresProfile != null) {
      return requiresProfile();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_ResendSuccess value) resendSuccess,
    required TResult Function(_RequiresProfile value) requiresProfile,
    required TResult Function(_RequiresPasswordReset value)
    requiresPasswordReset,
    required TResult Function(_Error value) error,
  }) {
    return requiresProfile(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_ResendSuccess value)? resendSuccess,
    TResult? Function(_RequiresProfile value)? requiresProfile,
    TResult? Function(_RequiresPasswordReset value)? requiresPasswordReset,
    TResult? Function(_Error value)? error,
  }) {
    return requiresProfile?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_ResendSuccess value)? resendSuccess,
    TResult Function(_RequiresProfile value)? requiresProfile,
    TResult Function(_RequiresPasswordReset value)? requiresPasswordReset,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (requiresProfile != null) {
      return requiresProfile(this);
    }
    return orElse();
  }
}

abstract class _RequiresProfile implements OtpState {
  const factory _RequiresProfile() = _$RequiresProfileImpl;
}

/// @nodoc
abstract class _$$RequiresPasswordResetImplCopyWith<$Res> {
  factory _$$RequiresPasswordResetImplCopyWith(
    _$RequiresPasswordResetImpl value,
    $Res Function(_$RequiresPasswordResetImpl) then,
  ) = __$$RequiresPasswordResetImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RequiresPasswordResetImplCopyWithImpl<$Res>
    extends _$OtpStateCopyWithImpl<$Res, _$RequiresPasswordResetImpl>
    implements _$$RequiresPasswordResetImplCopyWith<$Res> {
  __$$RequiresPasswordResetImplCopyWithImpl(
    _$RequiresPasswordResetImpl _value,
    $Res Function(_$RequiresPasswordResetImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OtpState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RequiresPasswordResetImpl implements _RequiresPasswordReset {
  const _$RequiresPasswordResetImpl();

  @override
  String toString() {
    return 'OtpState.requiresPasswordReset()';
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
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Session session) success,
    required TResult Function() resendSuccess,
    required TResult Function() requiresProfile,
    required TResult Function() requiresPasswordReset,
    required TResult Function(ApiErrorModel error) error,
  }) {
    return requiresPasswordReset();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(Session session)? success,
    TResult? Function()? resendSuccess,
    TResult? Function()? requiresProfile,
    TResult? Function()? requiresPasswordReset,
    TResult? Function(ApiErrorModel error)? error,
  }) {
    return requiresPasswordReset?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Session session)? success,
    TResult Function()? resendSuccess,
    TResult Function()? requiresProfile,
    TResult Function()? requiresPasswordReset,
    TResult Function(ApiErrorModel error)? error,
    required TResult orElse(),
  }) {
    if (requiresPasswordReset != null) {
      return requiresPasswordReset();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_ResendSuccess value) resendSuccess,
    required TResult Function(_RequiresProfile value) requiresProfile,
    required TResult Function(_RequiresPasswordReset value)
    requiresPasswordReset,
    required TResult Function(_Error value) error,
  }) {
    return requiresPasswordReset(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_ResendSuccess value)? resendSuccess,
    TResult? Function(_RequiresProfile value)? requiresProfile,
    TResult? Function(_RequiresPasswordReset value)? requiresPasswordReset,
    TResult? Function(_Error value)? error,
  }) {
    return requiresPasswordReset?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_ResendSuccess value)? resendSuccess,
    TResult Function(_RequiresProfile value)? requiresProfile,
    TResult Function(_RequiresPasswordReset value)? requiresPasswordReset,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (requiresPasswordReset != null) {
      return requiresPasswordReset(this);
    }
    return orElse();
  }
}

abstract class _RequiresPasswordReset implements OtpState {
  const factory _RequiresPasswordReset() = _$RequiresPasswordResetImpl;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
    _$ErrorImpl value,
    $Res Function(_$ErrorImpl) then,
  ) = __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ApiErrorModel error});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$OtpStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
    _$ErrorImpl _value,
    $Res Function(_$ErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OtpState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? error = null}) {
    return _then(
      _$ErrorImpl(
        null == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                as ApiErrorModel,
      ),
    );
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl(this.error);

  @override
  final ApiErrorModel error;

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
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Session session) success,
    required TResult Function() resendSuccess,
    required TResult Function() requiresProfile,
    required TResult Function() requiresPasswordReset,
    required TResult Function(ApiErrorModel error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(Session session)? success,
    TResult? Function()? resendSuccess,
    TResult? Function()? requiresProfile,
    TResult? Function()? requiresPasswordReset,
    TResult? Function(ApiErrorModel error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Session session)? success,
    TResult Function()? resendSuccess,
    TResult Function()? requiresProfile,
    TResult Function()? requiresPasswordReset,
    TResult Function(ApiErrorModel error)? error,
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
    required TResult Function(_Success value) success,
    required TResult Function(_ResendSuccess value) resendSuccess,
    required TResult Function(_RequiresProfile value) requiresProfile,
    required TResult Function(_RequiresPasswordReset value)
    requiresPasswordReset,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_ResendSuccess value)? resendSuccess,
    TResult? Function(_RequiresProfile value)? requiresProfile,
    TResult? Function(_RequiresPasswordReset value)? requiresPasswordReset,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_ResendSuccess value)? resendSuccess,
    TResult Function(_RequiresProfile value)? requiresProfile,
    TResult Function(_RequiresPasswordReset value)? requiresPasswordReset,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements OtpState {
  const factory _Error(final ApiErrorModel error) = _$ErrorImpl;

  ApiErrorModel get error;

  /// Create a copy of OtpState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
