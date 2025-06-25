// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'all_areas_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AllAreasState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<AreaInfo> areas,
            bool hasReachedEnd,
            bool isLoadingMore,
            Set<String> subscribingAreaIds,
            DateTime? lastFetchTime,
            String? operationError)
        loaded,
    required TResult Function(ApiError error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<AreaInfo> areas,
            bool hasReachedEnd,
            bool isLoadingMore,
            Set<String> subscribingAreaIds,
            DateTime? lastFetchTime,
            String? operationError)?
        loaded,
    TResult? Function(ApiError error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<AreaInfo> areas,
            bool hasReachedEnd,
            bool isLoadingMore,
            Set<String> subscribingAreaIds,
            DateTime? lastFetchTime,
            String? operationError)?
        loaded,
    TResult Function(ApiError error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AllAreasStateInitial value) initial,
    required TResult Function(AllAreasStateLoading value) loading,
    required TResult Function(AllAreasStateLoaded value) loaded,
    required TResult Function(AllAreasStateError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AllAreasStateInitial value)? initial,
    TResult? Function(AllAreasStateLoading value)? loading,
    TResult? Function(AllAreasStateLoaded value)? loaded,
    TResult? Function(AllAreasStateError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AllAreasStateInitial value)? initial,
    TResult Function(AllAreasStateLoading value)? loading,
    TResult Function(AllAreasStateLoaded value)? loaded,
    TResult Function(AllAreasStateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllAreasStateCopyWith<$Res> {
  factory $AllAreasStateCopyWith(
          AllAreasState value, $Res Function(AllAreasState) then) =
      _$AllAreasStateCopyWithImpl<$Res, AllAreasState>;
}

/// @nodoc
class _$AllAreasStateCopyWithImpl<$Res, $Val extends AllAreasState>
    implements $AllAreasStateCopyWith<$Res> {
  _$AllAreasStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AllAreasState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AllAreasStateInitialImplCopyWith<$Res> {
  factory _$$AllAreasStateInitialImplCopyWith(_$AllAreasStateInitialImpl value,
          $Res Function(_$AllAreasStateInitialImpl) then) =
      __$$AllAreasStateInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AllAreasStateInitialImplCopyWithImpl<$Res>
    extends _$AllAreasStateCopyWithImpl<$Res, _$AllAreasStateInitialImpl>
    implements _$$AllAreasStateInitialImplCopyWith<$Res> {
  __$$AllAreasStateInitialImplCopyWithImpl(_$AllAreasStateInitialImpl _value,
      $Res Function(_$AllAreasStateInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of AllAreasState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AllAreasStateInitialImpl implements AllAreasStateInitial {
  const _$AllAreasStateInitialImpl();

  @override
  String toString() {
    return 'AllAreasState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AllAreasStateInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<AreaInfo> areas,
            bool hasReachedEnd,
            bool isLoadingMore,
            Set<String> subscribingAreaIds,
            DateTime? lastFetchTime,
            String? operationError)
        loaded,
    required TResult Function(ApiError error) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<AreaInfo> areas,
            bool hasReachedEnd,
            bool isLoadingMore,
            Set<String> subscribingAreaIds,
            DateTime? lastFetchTime,
            String? operationError)?
        loaded,
    TResult? Function(ApiError error)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<AreaInfo> areas,
            bool hasReachedEnd,
            bool isLoadingMore,
            Set<String> subscribingAreaIds,
            DateTime? lastFetchTime,
            String? operationError)?
        loaded,
    TResult Function(ApiError error)? error,
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
    required TResult Function(AllAreasStateInitial value) initial,
    required TResult Function(AllAreasStateLoading value) loading,
    required TResult Function(AllAreasStateLoaded value) loaded,
    required TResult Function(AllAreasStateError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AllAreasStateInitial value)? initial,
    TResult? Function(AllAreasStateLoading value)? loading,
    TResult? Function(AllAreasStateLoaded value)? loaded,
    TResult? Function(AllAreasStateError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AllAreasStateInitial value)? initial,
    TResult Function(AllAreasStateLoading value)? loading,
    TResult Function(AllAreasStateLoaded value)? loaded,
    TResult Function(AllAreasStateError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class AllAreasStateInitial implements AllAreasState {
  const factory AllAreasStateInitial() = _$AllAreasStateInitialImpl;
}

/// @nodoc
abstract class _$$AllAreasStateLoadingImplCopyWith<$Res> {
  factory _$$AllAreasStateLoadingImplCopyWith(_$AllAreasStateLoadingImpl value,
          $Res Function(_$AllAreasStateLoadingImpl) then) =
      __$$AllAreasStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AllAreasStateLoadingImplCopyWithImpl<$Res>
    extends _$AllAreasStateCopyWithImpl<$Res, _$AllAreasStateLoadingImpl>
    implements _$$AllAreasStateLoadingImplCopyWith<$Res> {
  __$$AllAreasStateLoadingImplCopyWithImpl(_$AllAreasStateLoadingImpl _value,
      $Res Function(_$AllAreasStateLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of AllAreasState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AllAreasStateLoadingImpl implements AllAreasStateLoading {
  const _$AllAreasStateLoadingImpl();

  @override
  String toString() {
    return 'AllAreasState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AllAreasStateLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<AreaInfo> areas,
            bool hasReachedEnd,
            bool isLoadingMore,
            Set<String> subscribingAreaIds,
            DateTime? lastFetchTime,
            String? operationError)
        loaded,
    required TResult Function(ApiError error) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<AreaInfo> areas,
            bool hasReachedEnd,
            bool isLoadingMore,
            Set<String> subscribingAreaIds,
            DateTime? lastFetchTime,
            String? operationError)?
        loaded,
    TResult? Function(ApiError error)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<AreaInfo> areas,
            bool hasReachedEnd,
            bool isLoadingMore,
            Set<String> subscribingAreaIds,
            DateTime? lastFetchTime,
            String? operationError)?
        loaded,
    TResult Function(ApiError error)? error,
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
    required TResult Function(AllAreasStateInitial value) initial,
    required TResult Function(AllAreasStateLoading value) loading,
    required TResult Function(AllAreasStateLoaded value) loaded,
    required TResult Function(AllAreasStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AllAreasStateInitial value)? initial,
    TResult? Function(AllAreasStateLoading value)? loading,
    TResult? Function(AllAreasStateLoaded value)? loaded,
    TResult? Function(AllAreasStateError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AllAreasStateInitial value)? initial,
    TResult Function(AllAreasStateLoading value)? loading,
    TResult Function(AllAreasStateLoaded value)? loaded,
    TResult Function(AllAreasStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class AllAreasStateLoading implements AllAreasState {
  const factory AllAreasStateLoading() = _$AllAreasStateLoadingImpl;
}

/// @nodoc
abstract class _$$AllAreasStateLoadedImplCopyWith<$Res> {
  factory _$$AllAreasStateLoadedImplCopyWith(_$AllAreasStateLoadedImpl value,
          $Res Function(_$AllAreasStateLoadedImpl) then) =
      __$$AllAreasStateLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<AreaInfo> areas,
      bool hasReachedEnd,
      bool isLoadingMore,
      Set<String> subscribingAreaIds,
      DateTime? lastFetchTime,
      String? operationError});
}

/// @nodoc
class __$$AllAreasStateLoadedImplCopyWithImpl<$Res>
    extends _$AllAreasStateCopyWithImpl<$Res, _$AllAreasStateLoadedImpl>
    implements _$$AllAreasStateLoadedImplCopyWith<$Res> {
  __$$AllAreasStateLoadedImplCopyWithImpl(_$AllAreasStateLoadedImpl _value,
      $Res Function(_$AllAreasStateLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AllAreasState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? areas = null,
    Object? hasReachedEnd = null,
    Object? isLoadingMore = null,
    Object? subscribingAreaIds = null,
    Object? lastFetchTime = freezed,
    Object? operationError = freezed,
  }) {
    return _then(_$AllAreasStateLoadedImpl(
      areas: null == areas
          ? _value._areas
          : areas // ignore: cast_nullable_to_non_nullable
              as List<AreaInfo>,
      hasReachedEnd: null == hasReachedEnd
          ? _value.hasReachedEnd
          : hasReachedEnd // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingMore: null == isLoadingMore
          ? _value.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
              as bool,
      subscribingAreaIds: null == subscribingAreaIds
          ? _value._subscribingAreaIds
          : subscribingAreaIds // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      lastFetchTime: freezed == lastFetchTime
          ? _value.lastFetchTime
          : lastFetchTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      operationError: freezed == operationError
          ? _value.operationError
          : operationError // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$AllAreasStateLoadedImpl implements AllAreasStateLoaded {
  const _$AllAreasStateLoadedImpl(
      {required final List<AreaInfo> areas,
      required this.hasReachedEnd,
      required this.isLoadingMore,
      final Set<String> subscribingAreaIds = const <String>{},
      this.lastFetchTime,
      this.operationError})
      : _areas = areas,
        _subscribingAreaIds = subscribingAreaIds;

  final List<AreaInfo> _areas;
  @override
  List<AreaInfo> get areas {
    if (_areas is EqualUnmodifiableListView) return _areas;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_areas);
  }

  @override
  final bool hasReachedEnd;
  @override
  final bool isLoadingMore;
  final Set<String> _subscribingAreaIds;
  @override
  @JsonKey()
  Set<String> get subscribingAreaIds {
    if (_subscribingAreaIds is EqualUnmodifiableSetView)
      return _subscribingAreaIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_subscribingAreaIds);
  }

  @override
  final DateTime? lastFetchTime;
  @override
  final String? operationError;

  @override
  String toString() {
    return 'AllAreasState.loaded(areas: $areas, hasReachedEnd: $hasReachedEnd, isLoadingMore: $isLoadingMore, subscribingAreaIds: $subscribingAreaIds, lastFetchTime: $lastFetchTime, operationError: $operationError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AllAreasStateLoadedImpl &&
            const DeepCollectionEquality().equals(other._areas, _areas) &&
            (identical(other.hasReachedEnd, hasReachedEnd) ||
                other.hasReachedEnd == hasReachedEnd) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            const DeepCollectionEquality()
                .equals(other._subscribingAreaIds, _subscribingAreaIds) &&
            (identical(other.lastFetchTime, lastFetchTime) ||
                other.lastFetchTime == lastFetchTime) &&
            (identical(other.operationError, operationError) ||
                other.operationError == operationError));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_areas),
      hasReachedEnd,
      isLoadingMore,
      const DeepCollectionEquality().hash(_subscribingAreaIds),
      lastFetchTime,
      operationError);

  /// Create a copy of AllAreasState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AllAreasStateLoadedImplCopyWith<_$AllAreasStateLoadedImpl> get copyWith =>
      __$$AllAreasStateLoadedImplCopyWithImpl<_$AllAreasStateLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<AreaInfo> areas,
            bool hasReachedEnd,
            bool isLoadingMore,
            Set<String> subscribingAreaIds,
            DateTime? lastFetchTime,
            String? operationError)
        loaded,
    required TResult Function(ApiError error) error,
  }) {
    return loaded(areas, hasReachedEnd, isLoadingMore, subscribingAreaIds,
        lastFetchTime, operationError);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<AreaInfo> areas,
            bool hasReachedEnd,
            bool isLoadingMore,
            Set<String> subscribingAreaIds,
            DateTime? lastFetchTime,
            String? operationError)?
        loaded,
    TResult? Function(ApiError error)? error,
  }) {
    return loaded?.call(areas, hasReachedEnd, isLoadingMore, subscribingAreaIds,
        lastFetchTime, operationError);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<AreaInfo> areas,
            bool hasReachedEnd,
            bool isLoadingMore,
            Set<String> subscribingAreaIds,
            DateTime? lastFetchTime,
            String? operationError)?
        loaded,
    TResult Function(ApiError error)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(areas, hasReachedEnd, isLoadingMore, subscribingAreaIds,
          lastFetchTime, operationError);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AllAreasStateInitial value) initial,
    required TResult Function(AllAreasStateLoading value) loading,
    required TResult Function(AllAreasStateLoaded value) loaded,
    required TResult Function(AllAreasStateError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AllAreasStateInitial value)? initial,
    TResult? Function(AllAreasStateLoading value)? loading,
    TResult? Function(AllAreasStateLoaded value)? loaded,
    TResult? Function(AllAreasStateError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AllAreasStateInitial value)? initial,
    TResult Function(AllAreasStateLoading value)? loading,
    TResult Function(AllAreasStateLoaded value)? loaded,
    TResult Function(AllAreasStateError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class AllAreasStateLoaded implements AllAreasState {
  const factory AllAreasStateLoaded(
      {required final List<AreaInfo> areas,
      required final bool hasReachedEnd,
      required final bool isLoadingMore,
      final Set<String> subscribingAreaIds,
      final DateTime? lastFetchTime,
      final String? operationError}) = _$AllAreasStateLoadedImpl;

  List<AreaInfo> get areas;
  bool get hasReachedEnd;
  bool get isLoadingMore;
  Set<String> get subscribingAreaIds;
  DateTime? get lastFetchTime;
  String? get operationError;

  /// Create a copy of AllAreasState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AllAreasStateLoadedImplCopyWith<_$AllAreasStateLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AllAreasStateErrorImplCopyWith<$Res> {
  factory _$$AllAreasStateErrorImplCopyWith(_$AllAreasStateErrorImpl value,
          $Res Function(_$AllAreasStateErrorImpl) then) =
      __$$AllAreasStateErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ApiError error});
}

/// @nodoc
class __$$AllAreasStateErrorImplCopyWithImpl<$Res>
    extends _$AllAreasStateCopyWithImpl<$Res, _$AllAreasStateErrorImpl>
    implements _$$AllAreasStateErrorImplCopyWith<$Res> {
  __$$AllAreasStateErrorImplCopyWithImpl(_$AllAreasStateErrorImpl _value,
      $Res Function(_$AllAreasStateErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of AllAreasState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$AllAreasStateErrorImpl(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as ApiError,
    ));
  }
}

/// @nodoc

class _$AllAreasStateErrorImpl implements AllAreasStateError {
  const _$AllAreasStateErrorImpl({required this.error});

  @override
  final ApiError error;

  @override
  String toString() {
    return 'AllAreasState.error(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AllAreasStateErrorImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  /// Create a copy of AllAreasState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AllAreasStateErrorImplCopyWith<_$AllAreasStateErrorImpl> get copyWith =>
      __$$AllAreasStateErrorImplCopyWithImpl<_$AllAreasStateErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<AreaInfo> areas,
            bool hasReachedEnd,
            bool isLoadingMore,
            Set<String> subscribingAreaIds,
            DateTime? lastFetchTime,
            String? operationError)
        loaded,
    required TResult Function(ApiError error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<AreaInfo> areas,
            bool hasReachedEnd,
            bool isLoadingMore,
            Set<String> subscribingAreaIds,
            DateTime? lastFetchTime,
            String? operationError)?
        loaded,
    TResult? Function(ApiError error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<AreaInfo> areas,
            bool hasReachedEnd,
            bool isLoadingMore,
            Set<String> subscribingAreaIds,
            DateTime? lastFetchTime,
            String? operationError)?
        loaded,
    TResult Function(ApiError error)? error,
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
    required TResult Function(AllAreasStateInitial value) initial,
    required TResult Function(AllAreasStateLoading value) loading,
    required TResult Function(AllAreasStateLoaded value) loaded,
    required TResult Function(AllAreasStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AllAreasStateInitial value)? initial,
    TResult? Function(AllAreasStateLoading value)? loading,
    TResult? Function(AllAreasStateLoaded value)? loaded,
    TResult? Function(AllAreasStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AllAreasStateInitial value)? initial,
    TResult Function(AllAreasStateLoading value)? loading,
    TResult Function(AllAreasStateLoaded value)? loaded,
    TResult Function(AllAreasStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class AllAreasStateError implements AllAreasState {
  const factory AllAreasStateError({required final ApiError error}) =
      _$AllAreasStateErrorImpl;

  ApiError get error;

  /// Create a copy of AllAreasState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AllAreasStateErrorImplCopyWith<_$AllAreasStateErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
