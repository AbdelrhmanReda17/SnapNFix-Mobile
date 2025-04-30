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
    required TResult Function(
      String phoneNumber,
      String verificationToken,
      OtpPurpose purpose,
    )
    requiresOtp,
    required TResult Function(String phoneNumber) unverified,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Session session)? authenticated,
    TResult? Function(
      String phoneNumber,
      String verificationToken,
      OtpPurpose purpose,
    )?
    requiresOtp,
    TResult? Function(String phoneNumber)? unverified,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Session session)? authenticated,
    TResult Function(
      String phoneNumber,
      String verificationToken,
      OtpPurpose purpose,
    )?
    requiresOtp,
    TResult Function(String phoneNumber)? unverified,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Authenticated value) authenticated,
    required TResult Function(RequiresOtp value) requiresOtp,
    required TResult Function(Unverified value) unverified,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Authenticated value)? authenticated,
    TResult? Function(RequiresOtp value)? requiresOtp,
    TResult? Function(Unverified value)? unverified,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Authenticated value)? authenticated,
    TResult Function(RequiresOtp value)? requiresOtp,
    TResult Function(Unverified value)? unverified,
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
    required TResult Function(
      String phoneNumber,
      String verificationToken,
      OtpPurpose purpose,
    )
    requiresOtp,
    required TResult Function(String phoneNumber) unverified,
  }) {
    return authenticated(session);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Session session)? authenticated,
    TResult? Function(
      String phoneNumber,
      String verificationToken,
      OtpPurpose purpose,
    )?
    requiresOtp,
    TResult? Function(String phoneNumber)? unverified,
  }) {
    return authenticated?.call(session);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Session session)? authenticated,
    TResult Function(
      String phoneNumber,
      String verificationToken,
      OtpPurpose purpose,
    )?
    requiresOtp,
    TResult Function(String phoneNumber)? unverified,
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
    required TResult Function(Unverified value) unverified,
  }) {
    return authenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Authenticated value)? authenticated,
    TResult? Function(RequiresOtp value)? requiresOtp,
    TResult? Function(Unverified value)? unverified,
  }) {
    return authenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Authenticated value)? authenticated,
    TResult Function(RequiresOtp value)? requiresOtp,
    TResult Function(Unverified value)? unverified,
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
  $Res call({String phoneNumber, String verificationToken, OtpPurpose purpose});
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
  $Res call({
    Object? phoneNumber = null,
    Object? verificationToken = null,
    Object? purpose = null,
  }) {
    return _then(
      _$RequiresOtpImpl(
        phoneNumber:
            null == phoneNumber
                ? _value.phoneNumber
                : phoneNumber // ignore: cast_nullable_to_non_nullable
                    as String,
        verificationToken:
            null == verificationToken
                ? _value.verificationToken
                : verificationToken // ignore: cast_nullable_to_non_nullable
                    as String,
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
  const _$RequiresOtpImpl({
    required this.phoneNumber,
    required this.verificationToken,
    required this.purpose,
  });

  @override
  final String phoneNumber;
  @override
  final String verificationToken;
  @override
  final OtpPurpose purpose;

  @override
  String toString() {
    return 'AuthenticationResult.requiresOtp(phoneNumber: $phoneNumber, verificationToken: $verificationToken, purpose: $purpose)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequiresOtpImpl &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.verificationToken, verificationToken) ||
                other.verificationToken == verificationToken) &&
            (identical(other.purpose, purpose) || other.purpose == purpose));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, phoneNumber, verificationToken, purpose);

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
    required TResult Function(
      String phoneNumber,
      String verificationToken,
      OtpPurpose purpose,
    )
    requiresOtp,
    required TResult Function(String phoneNumber) unverified,
  }) {
    return requiresOtp(phoneNumber, verificationToken, purpose);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Session session)? authenticated,
    TResult? Function(
      String phoneNumber,
      String verificationToken,
      OtpPurpose purpose,
    )?
    requiresOtp,
    TResult? Function(String phoneNumber)? unverified,
  }) {
    return requiresOtp?.call(phoneNumber, verificationToken, purpose);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Session session)? authenticated,
    TResult Function(
      String phoneNumber,
      String verificationToken,
      OtpPurpose purpose,
    )?
    requiresOtp,
    TResult Function(String phoneNumber)? unverified,
    required TResult orElse(),
  }) {
    if (requiresOtp != null) {
      return requiresOtp(phoneNumber, verificationToken, purpose);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Authenticated value) authenticated,
    required TResult Function(RequiresOtp value) requiresOtp,
    required TResult Function(Unverified value) unverified,
  }) {
    return requiresOtp(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Authenticated value)? authenticated,
    TResult? Function(RequiresOtp value)? requiresOtp,
    TResult? Function(Unverified value)? unverified,
  }) {
    return requiresOtp?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Authenticated value)? authenticated,
    TResult Function(RequiresOtp value)? requiresOtp,
    TResult Function(Unverified value)? unverified,
    required TResult orElse(),
  }) {
    if (requiresOtp != null) {
      return requiresOtp(this);
    }
    return orElse();
  }
}

abstract class RequiresOtp implements AuthenticationResult {
  const factory RequiresOtp({
    required final String phoneNumber,
    required final String verificationToken,
    required final OtpPurpose purpose,
  }) = _$RequiresOtpImpl;

  String get phoneNumber;
  String get verificationToken;
  OtpPurpose get purpose;

  /// Create a copy of AuthenticationResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RequiresOtpImplCopyWith<_$RequiresOtpImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnverifiedImplCopyWith<$Res> {
  factory _$$UnverifiedImplCopyWith(
    _$UnverifiedImpl value,
    $Res Function(_$UnverifiedImpl) then,
  ) = __$$UnverifiedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String phoneNumber});
}

/// @nodoc
class __$$UnverifiedImplCopyWithImpl<$Res>
    extends _$AuthenticationResultCopyWithImpl<$Res, _$UnverifiedImpl>
    implements _$$UnverifiedImplCopyWith<$Res> {
  __$$UnverifiedImplCopyWithImpl(
    _$UnverifiedImpl _value,
    $Res Function(_$UnverifiedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthenticationResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? phoneNumber = null}) {
    return _then(
      _$UnverifiedImpl(
        phoneNumber:
            null == phoneNumber
                ? _value.phoneNumber
                : phoneNumber // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _$UnverifiedImpl implements Unverified {
  const _$UnverifiedImpl({required this.phoneNumber});

  @override
  final String phoneNumber;

  @override
  String toString() {
    return 'AuthenticationResult.unverified(phoneNumber: $phoneNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnverifiedImpl &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber));
  }

  @override
  int get hashCode => Object.hash(runtimeType, phoneNumber);

  /// Create a copy of AuthenticationResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnverifiedImplCopyWith<_$UnverifiedImpl> get copyWith =>
      __$$UnverifiedImplCopyWithImpl<_$UnverifiedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Session session) authenticated,
    required TResult Function(
      String phoneNumber,
      String verificationToken,
      OtpPurpose purpose,
    )
    requiresOtp,
    required TResult Function(String phoneNumber) unverified,
  }) {
    return unverified(phoneNumber);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Session session)? authenticated,
    TResult? Function(
      String phoneNumber,
      String verificationToken,
      OtpPurpose purpose,
    )?
    requiresOtp,
    TResult? Function(String phoneNumber)? unverified,
  }) {
    return unverified?.call(phoneNumber);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Session session)? authenticated,
    TResult Function(
      String phoneNumber,
      String verificationToken,
      OtpPurpose purpose,
    )?
    requiresOtp,
    TResult Function(String phoneNumber)? unverified,
    required TResult orElse(),
  }) {
    if (unverified != null) {
      return unverified(phoneNumber);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Authenticated value) authenticated,
    required TResult Function(RequiresOtp value) requiresOtp,
    required TResult Function(Unverified value) unverified,
  }) {
    return unverified(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Authenticated value)? authenticated,
    TResult? Function(RequiresOtp value)? requiresOtp,
    TResult? Function(Unverified value)? unverified,
  }) {
    return unverified?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Authenticated value)? authenticated,
    TResult Function(RequiresOtp value)? requiresOtp,
    TResult Function(Unverified value)? unverified,
    required TResult orElse(),
  }) {
    if (unverified != null) {
      return unverified(this);
    }
    return orElse();
  }
}

abstract class Unverified implements AuthenticationResult {
  const factory Unverified({required final String phoneNumber}) =
      _$UnverifiedImpl;

  String get phoneNumber;

  /// Create a copy of AuthenticationResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnverifiedImplCopyWith<_$UnverifiedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
