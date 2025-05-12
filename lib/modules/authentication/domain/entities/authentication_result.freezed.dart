// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'authentication_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AuthenticationResult {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Session session) authenticated,
    required TResult Function(OtpPurpose purpose) requiresOtp,
    required TResult Function() requiresProfileCompletion,
    required TResult Function() requiresResetPassword,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Session session)? authenticated,
    TResult? Function(OtpPurpose purpose)? requiresOtp,
    TResult? Function()? requiresProfileCompletion,
    TResult? Function()? requiresResetPassword,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Session session)? authenticated,
    TResult Function(OtpPurpose purpose)? requiresOtp,
    TResult Function()? requiresProfileCompletion,
    TResult Function()? requiresResetPassword,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Authenticated value) authenticated,
    required TResult Function(RequiresOtp value) requiresOtp,
    required TResult Function(RequiresProfileCompletion value)
    requiresProfileCompletion,
    required TResult Function(RequiresResetPassword value)
    requiresResetPassword,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Authenticated value)? authenticated,
    TResult? Function(RequiresOtp value)? requiresOtp,
    TResult? Function(RequiresProfileCompletion value)?
    requiresProfileCompletion,
    TResult? Function(RequiresResetPassword value)? requiresResetPassword,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Authenticated value)? authenticated,
    TResult Function(RequiresOtp value)? requiresOtp,
    TResult Function(RequiresProfileCompletion value)?
    requiresProfileCompletion,
    TResult Function(RequiresResetPassword value)? requiresResetPassword,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthenticationResultCopyWith<$Res> {
  factory $AuthenticationResultCopyWith(
    AuthenticationResult value,
    $Res Function(AuthenticationResult) then,
  ) = _$AuthenticationResultCopyWithImpl<$Res, AuthenticationResult>;
}

/// @nodoc
class _$AuthenticationResultCopyWithImpl<
  $Res,
  $Val extends AuthenticationResult
>
    implements $AuthenticationResultCopyWith<$Res> {
  _$AuthenticationResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthenticationResult
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AuthenticatedImplCopyWith<$Res> {
  factory _$$AuthenticatedImplCopyWith(
    _$AuthenticatedImpl value,
    $Res Function(_$AuthenticatedImpl) then,
  ) = __$$AuthenticatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Session session});
}

/// @nodoc
class __$$AuthenticatedImplCopyWithImpl<$Res>
    extends _$AuthenticationResultCopyWithImpl<$Res, _$AuthenticatedImpl>
    implements _$$AuthenticatedImplCopyWith<$Res> {
  __$$AuthenticatedImplCopyWithImpl(
    _$AuthenticatedImpl _value,
    $Res Function(_$AuthenticatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthenticationResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? session = null}) {
    return _then(
      _$AuthenticatedImpl(
        null == session
            ? _value.session
            : session // ignore: cast_nullable_to_non_nullable
                as Session,
      ),
    );
  }
}

/// @nodoc

class _$AuthenticatedImpl implements Authenticated {
  const _$AuthenticatedImpl(this.session);

  @override
  final Session session;

  @override
  String toString() {
    return 'AuthenticationResult.authenticated(session: $session)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticatedImpl &&
            (identical(other.session, session) || other.session == session));
  }

  @override
  int get hashCode => Object.hash(runtimeType, session);

  /// Create a copy of AuthenticationResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthenticatedImplCopyWith<_$AuthenticatedImpl> get copyWith =>
      __$$AuthenticatedImplCopyWithImpl<_$AuthenticatedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Session session) authenticated,
    required TResult Function(OtpPurpose purpose) requiresOtp,
    required TResult Function() requiresProfileCompletion,
    required TResult Function() requiresResetPassword,
  }) {
    return authenticated(session);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Session session)? authenticated,
    TResult? Function(OtpPurpose purpose)? requiresOtp,
    TResult? Function()? requiresProfileCompletion,
    TResult? Function()? requiresResetPassword,
  }) {
    return authenticated?.call(session);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Session session)? authenticated,
    TResult Function(OtpPurpose purpose)? requiresOtp,
    TResult Function()? requiresProfileCompletion,
    TResult Function()? requiresResetPassword,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(session);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Authenticated value) authenticated,
    required TResult Function(RequiresOtp value) requiresOtp,
    required TResult Function(RequiresProfileCompletion value)
    requiresProfileCompletion,
    required TResult Function(RequiresResetPassword value)
    requiresResetPassword,
  }) {
    return authenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Authenticated value)? authenticated,
    TResult? Function(RequiresOtp value)? requiresOtp,
    TResult? Function(RequiresProfileCompletion value)?
    requiresProfileCompletion,
    TResult? Function(RequiresResetPassword value)? requiresResetPassword,
  }) {
    return authenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Authenticated value)? authenticated,
    TResult Function(RequiresOtp value)? requiresOtp,
    TResult Function(RequiresProfileCompletion value)?
    requiresProfileCompletion,
    TResult Function(RequiresResetPassword value)? requiresResetPassword,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(this);
    }
    return orElse();
  }
}

abstract class Authenticated implements AuthenticationResult {
  const factory Authenticated(final Session session) = _$AuthenticatedImpl;

  Session get session;

  /// Create a copy of AuthenticationResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthenticatedImplCopyWith<_$AuthenticatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RequiresOtpImplCopyWith<$Res> {
  factory _$$RequiresOtpImplCopyWith(
    _$RequiresOtpImpl value,
    $Res Function(_$RequiresOtpImpl) then,
  ) = __$$RequiresOtpImplCopyWithImpl<$Res>;
  @useResult
  $Res call({OtpPurpose purpose});
}

/// @nodoc
class __$$RequiresOtpImplCopyWithImpl<$Res>
    extends _$AuthenticationResultCopyWithImpl<$Res, _$RequiresOtpImpl>
    implements _$$RequiresOtpImplCopyWith<$Res> {
  __$$RequiresOtpImplCopyWithImpl(
    _$RequiresOtpImpl _value,
    $Res Function(_$RequiresOtpImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthenticationResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? purpose = null}) {
    return _then(
      _$RequiresOtpImpl(
        purpose:
            null == purpose
                ? _value.purpose
                : purpose // ignore: cast_nullable_to_non_nullable
                    as OtpPurpose,
      ),
    );
  }
}

/// @nodoc

class _$RequiresOtpImpl implements RequiresOtp {
  const _$RequiresOtpImpl({required this.purpose});

  @override
  final OtpPurpose purpose;

  @override
  String toString() {
    return 'AuthenticationResult.requiresOtp(purpose: $purpose)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequiresOtpImpl &&
            (identical(other.purpose, purpose) || other.purpose == purpose));
  }

  @override
  int get hashCode => Object.hash(runtimeType, purpose);

  /// Create a copy of AuthenticationResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RequiresOtpImplCopyWith<_$RequiresOtpImpl> get copyWith =>
      __$$RequiresOtpImplCopyWithImpl<_$RequiresOtpImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Session session) authenticated,
    required TResult Function(OtpPurpose purpose) requiresOtp,
    required TResult Function() requiresProfileCompletion,
    required TResult Function() requiresResetPassword,
  }) {
    return requiresOtp(purpose);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Session session)? authenticated,
    TResult? Function(OtpPurpose purpose)? requiresOtp,
    TResult? Function()? requiresProfileCompletion,
    TResult? Function()? requiresResetPassword,
  }) {
    return requiresOtp?.call(purpose);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Session session)? authenticated,
    TResult Function(OtpPurpose purpose)? requiresOtp,
    TResult Function()? requiresProfileCompletion,
    TResult Function()? requiresResetPassword,
    required TResult orElse(),
  }) {
    if (requiresOtp != null) {
      return requiresOtp(purpose);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Authenticated value) authenticated,
    required TResult Function(RequiresOtp value) requiresOtp,
    required TResult Function(RequiresProfileCompletion value)
    requiresProfileCompletion,
    required TResult Function(RequiresResetPassword value)
    requiresResetPassword,
  }) {
    return requiresOtp(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Authenticated value)? authenticated,
    TResult? Function(RequiresOtp value)? requiresOtp,
    TResult? Function(RequiresProfileCompletion value)?
    requiresProfileCompletion,
    TResult? Function(RequiresResetPassword value)? requiresResetPassword,
  }) {
    return requiresOtp?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Authenticated value)? authenticated,
    TResult Function(RequiresOtp value)? requiresOtp,
    TResult Function(RequiresProfileCompletion value)?
    requiresProfileCompletion,
    TResult Function(RequiresResetPassword value)? requiresResetPassword,
    required TResult orElse(),
  }) {
    if (requiresOtp != null) {
      return requiresOtp(this);
    }
    return orElse();
  }
}

abstract class RequiresOtp implements AuthenticationResult {
  const factory RequiresOtp({required final OtpPurpose purpose}) =
      _$RequiresOtpImpl;

  OtpPurpose get purpose;

  /// Create a copy of AuthenticationResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RequiresOtpImplCopyWith<_$RequiresOtpImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RequiresProfileCompletionImplCopyWith<$Res> {
  factory _$$RequiresProfileCompletionImplCopyWith(
    _$RequiresProfileCompletionImpl value,
    $Res Function(_$RequiresProfileCompletionImpl) then,
  ) = __$$RequiresProfileCompletionImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RequiresProfileCompletionImplCopyWithImpl<$Res>
    extends
        _$AuthenticationResultCopyWithImpl<
          $Res,
          _$RequiresProfileCompletionImpl
        >
    implements _$$RequiresProfileCompletionImplCopyWith<$Res> {
  __$$RequiresProfileCompletionImplCopyWithImpl(
    _$RequiresProfileCompletionImpl _value,
    $Res Function(_$RequiresProfileCompletionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthenticationResult
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RequiresProfileCompletionImpl implements RequiresProfileCompletion {
  const _$RequiresProfileCompletionImpl();

  @override
  String toString() {
    return 'AuthenticationResult.requiresProfileCompletion()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequiresProfileCompletionImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Session session) authenticated,
    required TResult Function(OtpPurpose purpose) requiresOtp,
    required TResult Function() requiresProfileCompletion,
    required TResult Function() requiresResetPassword,
  }) {
    return requiresProfileCompletion();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Session session)? authenticated,
    TResult? Function(OtpPurpose purpose)? requiresOtp,
    TResult? Function()? requiresProfileCompletion,
    TResult? Function()? requiresResetPassword,
  }) {
    return requiresProfileCompletion?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Session session)? authenticated,
    TResult Function(OtpPurpose purpose)? requiresOtp,
    TResult Function()? requiresProfileCompletion,
    TResult Function()? requiresResetPassword,
    required TResult orElse(),
  }) {
    if (requiresProfileCompletion != null) {
      return requiresProfileCompletion();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Authenticated value) authenticated,
    required TResult Function(RequiresOtp value) requiresOtp,
    required TResult Function(RequiresProfileCompletion value)
    requiresProfileCompletion,
    required TResult Function(RequiresResetPassword value)
    requiresResetPassword,
  }) {
    return requiresProfileCompletion(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Authenticated value)? authenticated,
    TResult? Function(RequiresOtp value)? requiresOtp,
    TResult? Function(RequiresProfileCompletion value)?
    requiresProfileCompletion,
    TResult? Function(RequiresResetPassword value)? requiresResetPassword,
  }) {
    return requiresProfileCompletion?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Authenticated value)? authenticated,
    TResult Function(RequiresOtp value)? requiresOtp,
    TResult Function(RequiresProfileCompletion value)?
    requiresProfileCompletion,
    TResult Function(RequiresResetPassword value)? requiresResetPassword,
    required TResult orElse(),
  }) {
    if (requiresProfileCompletion != null) {
      return requiresProfileCompletion(this);
    }
    return orElse();
  }
}

abstract class RequiresProfileCompletion implements AuthenticationResult {
  const factory RequiresProfileCompletion() = _$RequiresProfileCompletionImpl;
}

/// @nodoc
abstract class _$$RequiresResetPasswordImplCopyWith<$Res> {
  factory _$$RequiresResetPasswordImplCopyWith(
    _$RequiresResetPasswordImpl value,
    $Res Function(_$RequiresResetPasswordImpl) then,
  ) = __$$RequiresResetPasswordImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RequiresResetPasswordImplCopyWithImpl<$Res>
    extends
        _$AuthenticationResultCopyWithImpl<$Res, _$RequiresResetPasswordImpl>
    implements _$$RequiresResetPasswordImplCopyWith<$Res> {
  __$$RequiresResetPasswordImplCopyWithImpl(
    _$RequiresResetPasswordImpl _value,
    $Res Function(_$RequiresResetPasswordImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthenticationResult
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RequiresResetPasswordImpl implements RequiresResetPassword {
  const _$RequiresResetPasswordImpl();

  @override
  String toString() {
    return 'AuthenticationResult.requiresResetPassword()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequiresResetPasswordImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Session session) authenticated,
    required TResult Function(OtpPurpose purpose) requiresOtp,
    required TResult Function() requiresProfileCompletion,
    required TResult Function() requiresResetPassword,
  }) {
    return requiresResetPassword();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Session session)? authenticated,
    TResult? Function(OtpPurpose purpose)? requiresOtp,
    TResult? Function()? requiresProfileCompletion,
    TResult? Function()? requiresResetPassword,
  }) {
    return requiresResetPassword?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Session session)? authenticated,
    TResult Function(OtpPurpose purpose)? requiresOtp,
    TResult Function()? requiresProfileCompletion,
    TResult Function()? requiresResetPassword,
    required TResult orElse(),
  }) {
    if (requiresResetPassword != null) {
      return requiresResetPassword();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Authenticated value) authenticated,
    required TResult Function(RequiresOtp value) requiresOtp,
    required TResult Function(RequiresProfileCompletion value)
    requiresProfileCompletion,
    required TResult Function(RequiresResetPassword value)
    requiresResetPassword,
  }) {
    return requiresResetPassword(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Authenticated value)? authenticated,
    TResult? Function(RequiresOtp value)? requiresOtp,
    TResult? Function(RequiresProfileCompletion value)?
    requiresProfileCompletion,
    TResult? Function(RequiresResetPassword value)? requiresResetPassword,
  }) {
    return requiresResetPassword?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Authenticated value)? authenticated,
    TResult Function(RequiresOtp value)? requiresOtp,
    TResult Function(RequiresProfileCompletion value)?
    requiresProfileCompletion,
    TResult Function(RequiresResetPassword value)? requiresResetPassword,
    required TResult orElse(),
  }) {
    if (requiresResetPassword != null) {
      return requiresResetPassword(this);
    }
    return orElse();
  }
}

abstract class RequiresResetPassword implements AuthenticationResult {
  const factory RequiresResetPassword() = _$RequiresResetPasswordImpl;
}
