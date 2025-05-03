// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'social_authentication_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SocialAuthenticationResult {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String accessToken) success,
    required TResult Function() cancelled,
    required TResult Function(String errorMessage) failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String accessToken)? success,
    TResult? Function()? cancelled,
    TResult? Function(String errorMessage)? failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String accessToken)? success,
    TResult Function()? cancelled,
    TResult Function(String errorMessage)? failure,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SocialAuthenticationSuccess value) success,
    required TResult Function(SocialAuthenticationCancelled value) cancelled,
    required TResult Function(SocialAuthenticationFailure value) failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SocialAuthenticationSuccess value)? success,
    TResult? Function(SocialAuthenticationCancelled value)? cancelled,
    TResult? Function(SocialAuthenticationFailure value)? failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SocialAuthenticationSuccess value)? success,
    TResult Function(SocialAuthenticationCancelled value)? cancelled,
    TResult Function(SocialAuthenticationFailure value)? failure,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SocialAuthenticationResultCopyWith<$Res> {
  factory $SocialAuthenticationResultCopyWith(
    SocialAuthenticationResult value,
    $Res Function(SocialAuthenticationResult) then,
  ) =
      _$SocialAuthenticationResultCopyWithImpl<
        $Res,
        SocialAuthenticationResult
      >;
}

/// @nodoc
class _$SocialAuthenticationResultCopyWithImpl<
  $Res,
  $Val extends SocialAuthenticationResult
>
    implements $SocialAuthenticationResultCopyWith<$Res> {
  _$SocialAuthenticationResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SocialAuthenticationResult
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SocialAuthenticationSuccessImplCopyWith<$Res> {
  factory _$$SocialAuthenticationSuccessImplCopyWith(
    _$SocialAuthenticationSuccessImpl value,
    $Res Function(_$SocialAuthenticationSuccessImpl) then,
  ) = __$$SocialAuthenticationSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String accessToken});
}

/// @nodoc
class __$$SocialAuthenticationSuccessImplCopyWithImpl<$Res>
    extends
        _$SocialAuthenticationResultCopyWithImpl<
          $Res,
          _$SocialAuthenticationSuccessImpl
        >
    implements _$$SocialAuthenticationSuccessImplCopyWith<$Res> {
  __$$SocialAuthenticationSuccessImplCopyWithImpl(
    _$SocialAuthenticationSuccessImpl _value,
    $Res Function(_$SocialAuthenticationSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SocialAuthenticationResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? accessToken = null}) {
    return _then(
      _$SocialAuthenticationSuccessImpl(
        accessToken:
            null == accessToken
                ? _value.accessToken
                : accessToken // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _$SocialAuthenticationSuccessImpl implements SocialAuthenticationSuccess {
  const _$SocialAuthenticationSuccessImpl({required this.accessToken});

  @override
  final String accessToken;

  @override
  String toString() {
    return 'SocialAuthenticationResult.success(accessToken: $accessToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SocialAuthenticationSuccessImpl &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken));
  }

  @override
  int get hashCode => Object.hash(runtimeType, accessToken);

  /// Create a copy of SocialAuthenticationResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SocialAuthenticationSuccessImplCopyWith<_$SocialAuthenticationSuccessImpl>
  get copyWith => __$$SocialAuthenticationSuccessImplCopyWithImpl<
    _$SocialAuthenticationSuccessImpl
  >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String accessToken) success,
    required TResult Function() cancelled,
    required TResult Function(String errorMessage) failure,
  }) {
    return success(accessToken);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String accessToken)? success,
    TResult? Function()? cancelled,
    TResult? Function(String errorMessage)? failure,
  }) {
    return success?.call(accessToken);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String accessToken)? success,
    TResult Function()? cancelled,
    TResult Function(String errorMessage)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(accessToken);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SocialAuthenticationSuccess value) success,
    required TResult Function(SocialAuthenticationCancelled value) cancelled,
    required TResult Function(SocialAuthenticationFailure value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SocialAuthenticationSuccess value)? success,
    TResult? Function(SocialAuthenticationCancelled value)? cancelled,
    TResult? Function(SocialAuthenticationFailure value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SocialAuthenticationSuccess value)? success,
    TResult Function(SocialAuthenticationCancelled value)? cancelled,
    TResult Function(SocialAuthenticationFailure value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class SocialAuthenticationSuccess
    implements SocialAuthenticationResult {
  const factory SocialAuthenticationSuccess({
    required final String accessToken,
  }) = _$SocialAuthenticationSuccessImpl;

  String get accessToken;

  /// Create a copy of SocialAuthenticationResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SocialAuthenticationSuccessImplCopyWith<_$SocialAuthenticationSuccessImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SocialAuthenticationCancelledImplCopyWith<$Res> {
  factory _$$SocialAuthenticationCancelledImplCopyWith(
    _$SocialAuthenticationCancelledImpl value,
    $Res Function(_$SocialAuthenticationCancelledImpl) then,
  ) = __$$SocialAuthenticationCancelledImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SocialAuthenticationCancelledImplCopyWithImpl<$Res>
    extends
        _$SocialAuthenticationResultCopyWithImpl<
          $Res,
          _$SocialAuthenticationCancelledImpl
        >
    implements _$$SocialAuthenticationCancelledImplCopyWith<$Res> {
  __$$SocialAuthenticationCancelledImplCopyWithImpl(
    _$SocialAuthenticationCancelledImpl _value,
    $Res Function(_$SocialAuthenticationCancelledImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SocialAuthenticationResult
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SocialAuthenticationCancelledImpl
    implements SocialAuthenticationCancelled {
  const _$SocialAuthenticationCancelledImpl();

  @override
  String toString() {
    return 'SocialAuthenticationResult.cancelled()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SocialAuthenticationCancelledImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String accessToken) success,
    required TResult Function() cancelled,
    required TResult Function(String errorMessage) failure,
  }) {
    return cancelled();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String accessToken)? success,
    TResult? Function()? cancelled,
    TResult? Function(String errorMessage)? failure,
  }) {
    return cancelled?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String accessToken)? success,
    TResult Function()? cancelled,
    TResult Function(String errorMessage)? failure,
    required TResult orElse(),
  }) {
    if (cancelled != null) {
      return cancelled();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SocialAuthenticationSuccess value) success,
    required TResult Function(SocialAuthenticationCancelled value) cancelled,
    required TResult Function(SocialAuthenticationFailure value) failure,
  }) {
    return cancelled(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SocialAuthenticationSuccess value)? success,
    TResult? Function(SocialAuthenticationCancelled value)? cancelled,
    TResult? Function(SocialAuthenticationFailure value)? failure,
  }) {
    return cancelled?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SocialAuthenticationSuccess value)? success,
    TResult Function(SocialAuthenticationCancelled value)? cancelled,
    TResult Function(SocialAuthenticationFailure value)? failure,
    required TResult orElse(),
  }) {
    if (cancelled != null) {
      return cancelled(this);
    }
    return orElse();
  }
}

abstract class SocialAuthenticationCancelled
    implements SocialAuthenticationResult {
  const factory SocialAuthenticationCancelled() =
      _$SocialAuthenticationCancelledImpl;
}

/// @nodoc
abstract class _$$SocialAuthenticationFailureImplCopyWith<$Res> {
  factory _$$SocialAuthenticationFailureImplCopyWith(
    _$SocialAuthenticationFailureImpl value,
    $Res Function(_$SocialAuthenticationFailureImpl) then,
  ) = __$$SocialAuthenticationFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String errorMessage});
}

/// @nodoc
class __$$SocialAuthenticationFailureImplCopyWithImpl<$Res>
    extends
        _$SocialAuthenticationResultCopyWithImpl<
          $Res,
          _$SocialAuthenticationFailureImpl
        >
    implements _$$SocialAuthenticationFailureImplCopyWith<$Res> {
  __$$SocialAuthenticationFailureImplCopyWithImpl(
    _$SocialAuthenticationFailureImpl _value,
    $Res Function(_$SocialAuthenticationFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SocialAuthenticationResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? errorMessage = null}) {
    return _then(
      _$SocialAuthenticationFailureImpl(
        errorMessage:
            null == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _$SocialAuthenticationFailureImpl implements SocialAuthenticationFailure {
  const _$SocialAuthenticationFailureImpl({required this.errorMessage});

  @override
  final String errorMessage;

  @override
  String toString() {
    return 'SocialAuthenticationResult.failure(errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SocialAuthenticationFailureImpl &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, errorMessage);

  /// Create a copy of SocialAuthenticationResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SocialAuthenticationFailureImplCopyWith<_$SocialAuthenticationFailureImpl>
  get copyWith => __$$SocialAuthenticationFailureImplCopyWithImpl<
    _$SocialAuthenticationFailureImpl
  >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String accessToken) success,
    required TResult Function() cancelled,
    required TResult Function(String errorMessage) failure,
  }) {
    return failure(errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String accessToken)? success,
    TResult? Function()? cancelled,
    TResult? Function(String errorMessage)? failure,
  }) {
    return failure?.call(errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String accessToken)? success,
    TResult Function()? cancelled,
    TResult Function(String errorMessage)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(errorMessage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SocialAuthenticationSuccess value) success,
    required TResult Function(SocialAuthenticationCancelled value) cancelled,
    required TResult Function(SocialAuthenticationFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SocialAuthenticationSuccess value)? success,
    TResult? Function(SocialAuthenticationCancelled value)? cancelled,
    TResult? Function(SocialAuthenticationFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SocialAuthenticationSuccess value)? success,
    TResult Function(SocialAuthenticationCancelled value)? cancelled,
    TResult Function(SocialAuthenticationFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class SocialAuthenticationFailure
    implements SocialAuthenticationResult {
  const factory SocialAuthenticationFailure({
    required final String errorMessage,
  }) = _$SocialAuthenticationFailureImpl;

  String get errorMessage;

  /// Create a copy of SocialAuthenticationResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SocialAuthenticationFailureImplCopyWith<_$SocialAuthenticationFailureImpl>
  get copyWith => throw _privateConstructorUsedError;
}
