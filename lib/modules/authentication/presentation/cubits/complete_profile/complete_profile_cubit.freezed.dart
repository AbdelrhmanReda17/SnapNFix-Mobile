// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'complete_profile_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CompleteProfileState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      bool passwordVisible,
      bool confirmPasswordVisible,
      UserGender gender,
      DateTime? dateOfBirth,
    )
    initial,
    required TResult Function() loading,
    required TResult Function(Session session) success,
    required TResult Function(ApiErrorModel error) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      bool passwordVisible,
      bool confirmPasswordVisible,
      UserGender gender,
      DateTime? dateOfBirth,
    )?
    initial,
    TResult? Function()? loading,
    TResult? Function(Session session)? success,
    TResult? Function(ApiErrorModel error)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      bool passwordVisible,
      bool confirmPasswordVisible,
      UserGender gender,
      DateTime? dateOfBirth,
    )?
    initial,
    TResult Function()? loading,
    TResult Function(Session session)? success,
    TResult Function(ApiErrorModel error)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompleteProfileStateCopyWith<$Res> {
  factory $CompleteProfileStateCopyWith(
    CompleteProfileState value,
    $Res Function(CompleteProfileState) then,
  ) = _$CompleteProfileStateCopyWithImpl<$Res, CompleteProfileState>;
}

/// @nodoc
class _$CompleteProfileStateCopyWithImpl<
  $Res,
  $Val extends CompleteProfileState
>
    implements $CompleteProfileStateCopyWith<$Res> {
  _$CompleteProfileStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CompleteProfileState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
    _$InitialImpl value,
    $Res Function(_$InitialImpl) then,
  ) = __$$InitialImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    bool passwordVisible,
    bool confirmPasswordVisible,
    UserGender gender,
    DateTime? dateOfBirth,
  });
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$CompleteProfileStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
    _$InitialImpl _value,
    $Res Function(_$InitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CompleteProfileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? passwordVisible = null,
    Object? confirmPasswordVisible = null,
    Object? gender = null,
    Object? dateOfBirth = freezed,
  }) {
    return _then(
      _$InitialImpl(
        passwordVisible:
            null == passwordVisible
                ? _value.passwordVisible
                : passwordVisible // ignore: cast_nullable_to_non_nullable
                    as bool,
        confirmPasswordVisible:
            null == confirmPasswordVisible
                ? _value.confirmPasswordVisible
                : confirmPasswordVisible // ignore: cast_nullable_to_non_nullable
                    as bool,
        gender:
            null == gender
                ? _value.gender
                : gender // ignore: cast_nullable_to_non_nullable
                    as UserGender,
        dateOfBirth:
            freezed == dateOfBirth
                ? _value.dateOfBirth
                : dateOfBirth // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
      ),
    );
  }
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl({
    this.passwordVisible = false,
    this.confirmPasswordVisible = false,
    this.gender = UserGender.notSpecified,
    this.dateOfBirth,
  });

  @override
  @JsonKey()
  final bool passwordVisible;
  @override
  @JsonKey()
  final bool confirmPasswordVisible;
  @override
  @JsonKey()
  final UserGender gender;
  @override
  final DateTime? dateOfBirth;

  @override
  String toString() {
    return 'CompleteProfileState.initial(passwordVisible: $passwordVisible, confirmPasswordVisible: $confirmPasswordVisible, gender: $gender, dateOfBirth: $dateOfBirth)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialImpl &&
            (identical(other.passwordVisible, passwordVisible) ||
                other.passwordVisible == passwordVisible) &&
            (identical(other.confirmPasswordVisible, confirmPasswordVisible) ||
                other.confirmPasswordVisible == confirmPasswordVisible) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.dateOfBirth, dateOfBirth) ||
                other.dateOfBirth == dateOfBirth));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    passwordVisible,
    confirmPasswordVisible,
    gender,
    dateOfBirth,
  );

  /// Create a copy of CompleteProfileState
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
      bool passwordVisible,
      bool confirmPasswordVisible,
      UserGender gender,
      DateTime? dateOfBirth,
    )
    initial,
    required TResult Function() loading,
    required TResult Function(Session session) success,
    required TResult Function(ApiErrorModel error) error,
  }) {
    return initial(
      passwordVisible,
      confirmPasswordVisible,
      gender,
      dateOfBirth,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      bool passwordVisible,
      bool confirmPasswordVisible,
      UserGender gender,
      DateTime? dateOfBirth,
    )?
    initial,
    TResult? Function()? loading,
    TResult? Function(Session session)? success,
    TResult? Function(ApiErrorModel error)? error,
  }) {
    return initial?.call(
      passwordVisible,
      confirmPasswordVisible,
      gender,
      dateOfBirth,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      bool passwordVisible,
      bool confirmPasswordVisible,
      UserGender gender,
      DateTime? dateOfBirth,
    )?
    initial,
    TResult Function()? loading,
    TResult Function(Session session)? success,
    TResult Function(ApiErrorModel error)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(
        passwordVisible,
        confirmPasswordVisible,
        gender,
        dateOfBirth,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
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
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements CompleteProfileState {
  const factory _Initial({
    final bool passwordVisible,
    final bool confirmPasswordVisible,
    final UserGender gender,
    final DateTime? dateOfBirth,
  }) = _$InitialImpl;

  bool get passwordVisible;
  bool get confirmPasswordVisible;
  UserGender get gender;
  DateTime? get dateOfBirth;

  /// Create a copy of CompleteProfileState
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
    extends _$CompleteProfileStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
    _$LoadingImpl _value,
    $Res Function(_$LoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CompleteProfileState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'CompleteProfileState.loading()';
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
      bool passwordVisible,
      bool confirmPasswordVisible,
      UserGender gender,
      DateTime? dateOfBirth,
    )
    initial,
    required TResult Function() loading,
    required TResult Function(Session session) success,
    required TResult Function(ApiErrorModel error) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      bool passwordVisible,
      bool confirmPasswordVisible,
      UserGender gender,
      DateTime? dateOfBirth,
    )?
    initial,
    TResult? Function()? loading,
    TResult? Function(Session session)? success,
    TResult? Function(ApiErrorModel error)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      bool passwordVisible,
      bool confirmPasswordVisible,
      UserGender gender,
      DateTime? dateOfBirth,
    )?
    initial,
    TResult Function()? loading,
    TResult Function(Session session)? success,
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
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements CompleteProfileState {
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
    extends _$CompleteProfileStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
    _$SuccessImpl _value,
    $Res Function(_$SuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CompleteProfileState
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
    return 'CompleteProfileState.success(session: $session)';
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

  /// Create a copy of CompleteProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      bool passwordVisible,
      bool confirmPasswordVisible,
      UserGender gender,
      DateTime? dateOfBirth,
    )
    initial,
    required TResult Function() loading,
    required TResult Function(Session session) success,
    required TResult Function(ApiErrorModel error) error,
  }) {
    return success(session);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      bool passwordVisible,
      bool confirmPasswordVisible,
      UserGender gender,
      DateTime? dateOfBirth,
    )?
    initial,
    TResult? Function()? loading,
    TResult? Function(Session session)? success,
    TResult? Function(ApiErrorModel error)? error,
  }) {
    return success?.call(session);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      bool passwordVisible,
      bool confirmPasswordVisible,
      UserGender gender,
      DateTime? dateOfBirth,
    )?
    initial,
    TResult Function()? loading,
    TResult Function(Session session)? success,
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
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success implements CompleteProfileState {
  const factory _Success(final Session session) = _$SuccessImpl;

  Session get session;

  /// Create a copy of CompleteProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
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
    extends _$CompleteProfileStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
    _$ErrorImpl _value,
    $Res Function(_$ErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CompleteProfileState
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
    return 'CompleteProfileState.error(error: $error)';
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

  /// Create a copy of CompleteProfileState
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
      bool passwordVisible,
      bool confirmPasswordVisible,
      UserGender gender,
      DateTime? dateOfBirth,
    )
    initial,
    required TResult Function() loading,
    required TResult Function(Session session) success,
    required TResult Function(ApiErrorModel error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      bool passwordVisible,
      bool confirmPasswordVisible,
      UserGender gender,
      DateTime? dateOfBirth,
    )?
    initial,
    TResult? Function()? loading,
    TResult? Function(Session session)? success,
    TResult? Function(ApiErrorModel error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      bool passwordVisible,
      bool confirmPasswordVisible,
      UserGender gender,
      DateTime? dateOfBirth,
    )?
    initial,
    TResult Function()? loading,
    TResult Function(Session session)? success,
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
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements CompleteProfileState {
  const factory _Error(final ApiErrorModel error) = _$ErrorImpl;

  ApiErrorModel get error;

  /// Create a copy of CompleteProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
