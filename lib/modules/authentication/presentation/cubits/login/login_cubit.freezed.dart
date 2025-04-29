// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$LoginState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool passwordVisible) initial,
    required TResult Function() loading,
    required TResult Function(Session data) success,
    required TResult Function() requiresVerification,
    required TResult Function() requiresProfile,
    required TResult Function(ApiErrorModel error) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool passwordVisible)? initial,
    TResult? Function()? loading,
    TResult? Function(Session data)? success,
    TResult? Function()? requiresVerification,
    TResult? Function()? requiresProfile,
    TResult? Function(ApiErrorModel error)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool passwordVisible)? initial,
    TResult Function()? loading,
    TResult Function(Session data)? success,
    TResult Function()? requiresVerification,
    TResult Function()? requiresProfile,
    TResult Function(ApiErrorModel error)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_RequiresVerification value) requiresVerification,
    required TResult Function(_RequiresProfile value) requiresProfile,
    required TResult Function(_Error value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_RequiresVerification value)? requiresVerification,
    TResult? Function(_RequiresProfile value)? requiresProfile,
    TResult? Function(_Error value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_RequiresVerification value)? requiresVerification,
    TResult Function(_RequiresProfile value)? requiresProfile,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginStateCopyWith<$Res> {
  factory $LoginStateCopyWith(
    LoginState value,
    $Res Function(LoginState) then,
  ) = _$LoginStateCopyWithImpl<$Res, LoginState>;
}

/// @nodoc
class _$LoginStateCopyWithImpl<$Res, $Val extends LoginState>
    implements $LoginStateCopyWith<$Res> {
  _$LoginStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
    _$InitialImpl value,
    $Res Function(_$InitialImpl) then,
  ) = __$$InitialImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool passwordVisible});
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$LoginStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
    _$InitialImpl _value,
    $Res Function(_$InitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? passwordVisible = null}) {
    return _then(
      _$InitialImpl(
        passwordVisible:
            null == passwordVisible
                ? _value.passwordVisible
                : passwordVisible // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl({this.passwordVisible = false});

  @override
  @JsonKey()
  final bool passwordVisible;

  @override
  String toString() {
    return 'LoginState.initial(passwordVisible: $passwordVisible)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialImpl &&
            (identical(other.passwordVisible, passwordVisible) ||
                other.passwordVisible == passwordVisible));
  }

  @override
  int get hashCode => Object.hash(runtimeType, passwordVisible);

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      __$$InitialImplCopyWithImpl<_$InitialImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool passwordVisible) initial,
    required TResult Function() loading,
    required TResult Function(Session data) success,
    required TResult Function() requiresVerification,
    required TResult Function() requiresProfile,
    required TResult Function(ApiErrorModel error) error,
  }) {
    return initial(passwordVisible);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool passwordVisible)? initial,
    TResult? Function()? loading,
    TResult? Function(Session data)? success,
    TResult? Function()? requiresVerification,
    TResult? Function()? requiresProfile,
    TResult? Function(ApiErrorModel error)? error,
  }) {
    return initial?.call(passwordVisible);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool passwordVisible)? initial,
    TResult Function()? loading,
    TResult Function(Session data)? success,
    TResult Function()? requiresVerification,
    TResult Function()? requiresProfile,
    TResult Function(ApiErrorModel error)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(passwordVisible);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_RequiresVerification value) requiresVerification,
    required TResult Function(_RequiresProfile value) requiresProfile,
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
    TResult? Function(_RequiresVerification value)? requiresVerification,
    TResult? Function(_RequiresProfile value)? requiresProfile,
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
    TResult Function(_RequiresVerification value)? requiresVerification,
    TResult Function(_RequiresProfile value)? requiresProfile,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements LoginState {
  const factory _Initial({final bool passwordVisible}) = _$InitialImpl;

  bool get passwordVisible;

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
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
    extends _$LoginStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
    _$LoadingImpl _value,
    $Res Function(_$LoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'LoginState.loading()';
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
    required TResult Function(bool passwordVisible) initial,
    required TResult Function() loading,
    required TResult Function(Session data) success,
    required TResult Function() requiresVerification,
    required TResult Function() requiresProfile,
    required TResult Function(ApiErrorModel error) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool passwordVisible)? initial,
    TResult? Function()? loading,
    TResult? Function(Session data)? success,
    TResult? Function()? requiresVerification,
    TResult? Function()? requiresProfile,
    TResult? Function(ApiErrorModel error)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool passwordVisible)? initial,
    TResult Function()? loading,
    TResult Function(Session data)? success,
    TResult Function()? requiresVerification,
    TResult Function()? requiresProfile,
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
    required TResult Function(_RequiresVerification value) requiresVerification,
    required TResult Function(_RequiresProfile value) requiresProfile,
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
    TResult? Function(_RequiresVerification value)? requiresVerification,
    TResult? Function(_RequiresProfile value)? requiresProfile,
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
    TResult Function(_RequiresVerification value)? requiresVerification,
    TResult Function(_RequiresProfile value)? requiresProfile,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements LoginState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
    _$SuccessImpl value,
    $Res Function(_$SuccessImpl) then,
  ) = __$$SuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Session data});
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$LoginStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
    _$SuccessImpl _value,
    $Res Function(_$SuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? data = null}) {
    return _then(
      _$SuccessImpl(
        null == data
            ? _value.data
            : data // ignore: cast_nullable_to_non_nullable
                as Session,
      ),
    );
  }
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl(this.data);

  @override
  final Session data;

  @override
  String toString() {
    return 'LoginState.success(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data);

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool passwordVisible) initial,
    required TResult Function() loading,
    required TResult Function(Session data) success,
    required TResult Function() requiresVerification,
    required TResult Function() requiresProfile,
    required TResult Function(ApiErrorModel error) error,
  }) {
    return success(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool passwordVisible)? initial,
    TResult? Function()? loading,
    TResult? Function(Session data)? success,
    TResult? Function()? requiresVerification,
    TResult? Function()? requiresProfile,
    TResult? Function(ApiErrorModel error)? error,
  }) {
    return success?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool passwordVisible)? initial,
    TResult Function()? loading,
    TResult Function(Session data)? success,
    TResult Function()? requiresVerification,
    TResult Function()? requiresProfile,
    TResult Function(ApiErrorModel error)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_RequiresVerification value) requiresVerification,
    required TResult Function(_RequiresProfile value) requiresProfile,
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
    TResult? Function(_RequiresVerification value)? requiresVerification,
    TResult? Function(_RequiresProfile value)? requiresProfile,
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
    TResult Function(_RequiresVerification value)? requiresVerification,
    TResult Function(_RequiresProfile value)? requiresProfile,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success implements LoginState {
  const factory _Success(final Session data) = _$SuccessImpl;

  Session get data;

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RequiresVerificationImplCopyWith<$Res> {
  factory _$$RequiresVerificationImplCopyWith(
    _$RequiresVerificationImpl value,
    $Res Function(_$RequiresVerificationImpl) then,
  ) = __$$RequiresVerificationImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RequiresVerificationImplCopyWithImpl<$Res>
    extends _$LoginStateCopyWithImpl<$Res, _$RequiresVerificationImpl>
    implements _$$RequiresVerificationImplCopyWith<$Res> {
  __$$RequiresVerificationImplCopyWithImpl(
    _$RequiresVerificationImpl _value,
    $Res Function(_$RequiresVerificationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RequiresVerificationImpl implements _RequiresVerification {
  const _$RequiresVerificationImpl();

  @override
  String toString() {
    return 'LoginState.requiresVerification()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequiresVerificationImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool passwordVisible) initial,
    required TResult Function() loading,
    required TResult Function(Session data) success,
    required TResult Function() requiresVerification,
    required TResult Function() requiresProfile,
    required TResult Function(ApiErrorModel error) error,
  }) {
    return requiresVerification();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool passwordVisible)? initial,
    TResult? Function()? loading,
    TResult? Function(Session data)? success,
    TResult? Function()? requiresVerification,
    TResult? Function()? requiresProfile,
    TResult? Function(ApiErrorModel error)? error,
  }) {
    return requiresVerification?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool passwordVisible)? initial,
    TResult Function()? loading,
    TResult Function(Session data)? success,
    TResult Function()? requiresVerification,
    TResult Function()? requiresProfile,
    TResult Function(ApiErrorModel error)? error,
    required TResult orElse(),
  }) {
    if (requiresVerification != null) {
      return requiresVerification();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_RequiresVerification value) requiresVerification,
    required TResult Function(_RequiresProfile value) requiresProfile,
    required TResult Function(_Error value) error,
  }) {
    return requiresVerification(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_RequiresVerification value)? requiresVerification,
    TResult? Function(_RequiresProfile value)? requiresProfile,
    TResult? Function(_Error value)? error,
  }) {
    return requiresVerification?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_RequiresVerification value)? requiresVerification,
    TResult Function(_RequiresProfile value)? requiresProfile,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (requiresVerification != null) {
      return requiresVerification(this);
    }
    return orElse();
  }
}

abstract class _RequiresVerification implements LoginState {
  const factory _RequiresVerification() = _$RequiresVerificationImpl;
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
    extends _$LoginStateCopyWithImpl<$Res, _$RequiresProfileImpl>
    implements _$$RequiresProfileImplCopyWith<$Res> {
  __$$RequiresProfileImplCopyWithImpl(
    _$RequiresProfileImpl _value,
    $Res Function(_$RequiresProfileImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RequiresProfileImpl implements _RequiresProfile {
  const _$RequiresProfileImpl();

  @override
  String toString() {
    return 'LoginState.requiresProfile()';
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
    required TResult Function(bool passwordVisible) initial,
    required TResult Function() loading,
    required TResult Function(Session data) success,
    required TResult Function() requiresVerification,
    required TResult Function() requiresProfile,
    required TResult Function(ApiErrorModel error) error,
  }) {
    return requiresProfile();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool passwordVisible)? initial,
    TResult? Function()? loading,
    TResult? Function(Session data)? success,
    TResult? Function()? requiresVerification,
    TResult? Function()? requiresProfile,
    TResult? Function(ApiErrorModel error)? error,
  }) {
    return requiresProfile?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool passwordVisible)? initial,
    TResult Function()? loading,
    TResult Function(Session data)? success,
    TResult Function()? requiresVerification,
    TResult Function()? requiresProfile,
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
    required TResult Function(_RequiresVerification value) requiresVerification,
    required TResult Function(_RequiresProfile value) requiresProfile,
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
    TResult? Function(_RequiresVerification value)? requiresVerification,
    TResult? Function(_RequiresProfile value)? requiresProfile,
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
    TResult Function(_RequiresVerification value)? requiresVerification,
    TResult Function(_RequiresProfile value)? requiresProfile,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (requiresProfile != null) {
      return requiresProfile(this);
    }
    return orElse();
  }
}

abstract class _RequiresProfile implements LoginState {
  const factory _RequiresProfile() = _$RequiresProfileImpl;
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
    extends _$LoginStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
    _$ErrorImpl _value,
    $Res Function(_$ErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LoginState
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
    return 'LoginState.error(error: $error)';
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

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool passwordVisible) initial,
    required TResult Function() loading,
    required TResult Function(Session data) success,
    required TResult Function() requiresVerification,
    required TResult Function() requiresProfile,
    required TResult Function(ApiErrorModel error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool passwordVisible)? initial,
    TResult? Function()? loading,
    TResult? Function(Session data)? success,
    TResult? Function()? requiresVerification,
    TResult? Function()? requiresProfile,
    TResult? Function(ApiErrorModel error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool passwordVisible)? initial,
    TResult Function()? loading,
    TResult Function(Session data)? success,
    TResult Function()? requiresVerification,
    TResult Function()? requiresProfile,
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
    required TResult Function(_RequiresVerification value) requiresVerification,
    required TResult Function(_RequiresProfile value) requiresProfile,
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
    TResult? Function(_RequiresVerification value)? requiresVerification,
    TResult? Function(_RequiresProfile value)? requiresProfile,
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
    TResult Function(_RequiresVerification value)? requiresVerification,
    TResult Function(_RequiresProfile value)? requiresProfile,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements LoginState {
  const factory _Error(final ApiErrorModel error) = _$ErrorImpl;

  ApiErrorModel get error;

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
