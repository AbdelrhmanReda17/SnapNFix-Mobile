// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paginated_areas_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PaginatedAreasState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<AreaInfo> areas, bool hasReachedEnd,
            bool isLoadingMore, Set<String> subscribedAreaIds)
        loaded,
    required TResult Function(ApiError error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<AreaInfo> areas, bool hasReachedEnd,
            bool isLoadingMore, Set<String> subscribedAreaIds)?
        loaded,
    TResult? Function(ApiError error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<AreaInfo> areas, bool hasReachedEnd,
            bool isLoadingMore, Set<String> subscribedAreaIds)?
        loaded,
    TResult Function(ApiError error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PaginatedAreasStateInitial value) initial,
    required TResult Function(PaginatedAreasStateLoading value) loading,
    required TResult Function(PaginatedAreasStateLoaded value) loaded,
    required TResult Function(PaginatedAreasStateError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PaginatedAreasStateInitial value)? initial,
    TResult? Function(PaginatedAreasStateLoading value)? loading,
    TResult? Function(PaginatedAreasStateLoaded value)? loaded,
    TResult? Function(PaginatedAreasStateError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PaginatedAreasStateInitial value)? initial,
    TResult Function(PaginatedAreasStateLoading value)? loading,
    TResult Function(PaginatedAreasStateLoaded value)? loaded,
    TResult Function(PaginatedAreasStateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginatedAreasStateCopyWith<$Res> {
  factory $PaginatedAreasStateCopyWith(
          PaginatedAreasState value, $Res Function(PaginatedAreasState) then) =
      _$PaginatedAreasStateCopyWithImpl<$Res, PaginatedAreasState>;
}

/// @nodoc
class _$PaginatedAreasStateCopyWithImpl<$Res, $Val extends PaginatedAreasState>
    implements $PaginatedAreasStateCopyWith<$Res> {
  _$PaginatedAreasStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaginatedAreasState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$PaginatedAreasStateInitialImplCopyWith<$Res> {
  factory _$$PaginatedAreasStateInitialImplCopyWith(
          _$PaginatedAreasStateInitialImpl value,
          $Res Function(_$PaginatedAreasStateInitialImpl) then) =
      __$$PaginatedAreasStateInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PaginatedAreasStateInitialImplCopyWithImpl<$Res>
    extends _$PaginatedAreasStateCopyWithImpl<$Res,
        _$PaginatedAreasStateInitialImpl>
    implements _$$PaginatedAreasStateInitialImplCopyWith<$Res> {
  __$$PaginatedAreasStateInitialImplCopyWithImpl(
      _$PaginatedAreasStateInitialImpl _value,
      $Res Function(_$PaginatedAreasStateInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaginatedAreasState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PaginatedAreasStateInitialImpl implements PaginatedAreasStateInitial {
  const _$PaginatedAreasStateInitialImpl();

  @override
  String toString() {
    return 'PaginatedAreasState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaginatedAreasStateInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<AreaInfo> areas, bool hasReachedEnd,
            bool isLoadingMore, Set<String> subscribedAreaIds)
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
    TResult? Function(List<AreaInfo> areas, bool hasReachedEnd,
            bool isLoadingMore, Set<String> subscribedAreaIds)?
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
    TResult Function(List<AreaInfo> areas, bool hasReachedEnd,
            bool isLoadingMore, Set<String> subscribedAreaIds)?
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
    required TResult Function(PaginatedAreasStateInitial value) initial,
    required TResult Function(PaginatedAreasStateLoading value) loading,
    required TResult Function(PaginatedAreasStateLoaded value) loaded,
    required TResult Function(PaginatedAreasStateError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PaginatedAreasStateInitial value)? initial,
    TResult? Function(PaginatedAreasStateLoading value)? loading,
    TResult? Function(PaginatedAreasStateLoaded value)? loaded,
    TResult? Function(PaginatedAreasStateError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PaginatedAreasStateInitial value)? initial,
    TResult Function(PaginatedAreasStateLoading value)? loading,
    TResult Function(PaginatedAreasStateLoaded value)? loaded,
    TResult Function(PaginatedAreasStateError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class PaginatedAreasStateInitial implements PaginatedAreasState {
  const factory PaginatedAreasStateInitial() = _$PaginatedAreasStateInitialImpl;
}

/// @nodoc
abstract class _$$PaginatedAreasStateLoadingImplCopyWith<$Res> {
  factory _$$PaginatedAreasStateLoadingImplCopyWith(
          _$PaginatedAreasStateLoadingImpl value,
          $Res Function(_$PaginatedAreasStateLoadingImpl) then) =
      __$$PaginatedAreasStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PaginatedAreasStateLoadingImplCopyWithImpl<$Res>
    extends _$PaginatedAreasStateCopyWithImpl<$Res,
        _$PaginatedAreasStateLoadingImpl>
    implements _$$PaginatedAreasStateLoadingImplCopyWith<$Res> {
  __$$PaginatedAreasStateLoadingImplCopyWithImpl(
      _$PaginatedAreasStateLoadingImpl _value,
      $Res Function(_$PaginatedAreasStateLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaginatedAreasState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PaginatedAreasStateLoadingImpl implements PaginatedAreasStateLoading {
  const _$PaginatedAreasStateLoadingImpl();

  @override
  String toString() {
    return 'PaginatedAreasState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaginatedAreasStateLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<AreaInfo> areas, bool hasReachedEnd,
            bool isLoadingMore, Set<String> subscribedAreaIds)
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
    TResult? Function(List<AreaInfo> areas, bool hasReachedEnd,
            bool isLoadingMore, Set<String> subscribedAreaIds)?
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
    TResult Function(List<AreaInfo> areas, bool hasReachedEnd,
            bool isLoadingMore, Set<String> subscribedAreaIds)?
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
    required TResult Function(PaginatedAreasStateInitial value) initial,
    required TResult Function(PaginatedAreasStateLoading value) loading,
    required TResult Function(PaginatedAreasStateLoaded value) loaded,
    required TResult Function(PaginatedAreasStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PaginatedAreasStateInitial value)? initial,
    TResult? Function(PaginatedAreasStateLoading value)? loading,
    TResult? Function(PaginatedAreasStateLoaded value)? loaded,
    TResult? Function(PaginatedAreasStateError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PaginatedAreasStateInitial value)? initial,
    TResult Function(PaginatedAreasStateLoading value)? loading,
    TResult Function(PaginatedAreasStateLoaded value)? loaded,
    TResult Function(PaginatedAreasStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class PaginatedAreasStateLoading implements PaginatedAreasState {
  const factory PaginatedAreasStateLoading() = _$PaginatedAreasStateLoadingImpl;
}

/// @nodoc
abstract class _$$PaginatedAreasStateLoadedImplCopyWith<$Res> {
  factory _$$PaginatedAreasStateLoadedImplCopyWith(
          _$PaginatedAreasStateLoadedImpl value,
          $Res Function(_$PaginatedAreasStateLoadedImpl) then) =
      __$$PaginatedAreasStateLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<AreaInfo> areas,
      bool hasReachedEnd,
      bool isLoadingMore,
      Set<String> subscribedAreaIds});
}

/// @nodoc
class __$$PaginatedAreasStateLoadedImplCopyWithImpl<$Res>
    extends _$PaginatedAreasStateCopyWithImpl<$Res,
        _$PaginatedAreasStateLoadedImpl>
    implements _$$PaginatedAreasStateLoadedImplCopyWith<$Res> {
  __$$PaginatedAreasStateLoadedImplCopyWithImpl(
      _$PaginatedAreasStateLoadedImpl _value,
      $Res Function(_$PaginatedAreasStateLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaginatedAreasState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? areas = null,
    Object? hasReachedEnd = null,
    Object? isLoadingMore = null,
    Object? subscribedAreaIds = null,
  }) {
    return _then(_$PaginatedAreasStateLoadedImpl(
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
      subscribedAreaIds: null == subscribedAreaIds
          ? _value._subscribedAreaIds
          : subscribedAreaIds // ignore: cast_nullable_to_non_nullable
              as Set<String>,
    ));
  }
}

/// @nodoc

class _$PaginatedAreasStateLoadedImpl implements PaginatedAreasStateLoaded {
  const _$PaginatedAreasStateLoadedImpl(
      {required final List<AreaInfo> areas,
      required this.hasReachedEnd,
      required this.isLoadingMore,
      required final Set<String> subscribedAreaIds})
      : _areas = areas,
        _subscribedAreaIds = subscribedAreaIds;

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
  final Set<String> _subscribedAreaIds;
  @override
  Set<String> get subscribedAreaIds {
    if (_subscribedAreaIds is EqualUnmodifiableSetView)
      return _subscribedAreaIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_subscribedAreaIds);
  }

  @override
  String toString() {
    return 'PaginatedAreasState.loaded(areas: $areas, hasReachedEnd: $hasReachedEnd, isLoadingMore: $isLoadingMore, subscribedAreaIds: $subscribedAreaIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaginatedAreasStateLoadedImpl &&
            const DeepCollectionEquality().equals(other._areas, _areas) &&
            (identical(other.hasReachedEnd, hasReachedEnd) ||
                other.hasReachedEnd == hasReachedEnd) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            const DeepCollectionEquality()
                .equals(other._subscribedAreaIds, _subscribedAreaIds));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_areas),
      hasReachedEnd,
      isLoadingMore,
      const DeepCollectionEquality().hash(_subscribedAreaIds));

  /// Create a copy of PaginatedAreasState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaginatedAreasStateLoadedImplCopyWith<_$PaginatedAreasStateLoadedImpl>
      get copyWith => __$$PaginatedAreasStateLoadedImplCopyWithImpl<
          _$PaginatedAreasStateLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<AreaInfo> areas, bool hasReachedEnd,
            bool isLoadingMore, Set<String> subscribedAreaIds)
        loaded,
    required TResult Function(ApiError error) error,
  }) {
    return loaded(areas, hasReachedEnd, isLoadingMore, subscribedAreaIds);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<AreaInfo> areas, bool hasReachedEnd,
            bool isLoadingMore, Set<String> subscribedAreaIds)?
        loaded,
    TResult? Function(ApiError error)? error,
  }) {
    return loaded?.call(
        areas, hasReachedEnd, isLoadingMore, subscribedAreaIds);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<AreaInfo> areas, bool hasReachedEnd,
            bool isLoadingMore, Set<String> subscribedAreaIds)?
        loaded,
    TResult Function(ApiError error)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(areas, hasReachedEnd, isLoadingMore, subscribedAreaIds);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PaginatedAreasStateInitial value) initial,
    required TResult Function(PaginatedAreasStateLoading value) loading,
    required TResult Function(PaginatedAreasStateLoaded value) loaded,
    required TResult Function(PaginatedAreasStateError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PaginatedAreasStateInitial value)? initial,
    TResult? Function(PaginatedAreasStateLoading value)? loading,
    TResult? Function(PaginatedAreasStateLoaded value)? loaded,
    TResult? Function(PaginatedAreasStateError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PaginatedAreasStateInitial value)? initial,
    TResult Function(PaginatedAreasStateLoading value)? loading,
    TResult Function(PaginatedAreasStateLoaded value)? loaded,
    TResult Function(PaginatedAreasStateError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class PaginatedAreasStateLoaded implements PaginatedAreasState {
  const factory PaginatedAreasStateLoaded(
          {required final List<AreaInfo> areas,
          required final bool hasReachedEnd,
          required final bool isLoadingMore,
          required final Set<String> subscribedAreaIds}) =
      _$PaginatedAreasStateLoadedImpl;

  List<AreaInfo> get areas;
  bool get hasReachedEnd;
  bool get isLoadingMore;
  Set<String> get subscribedAreaIds;

  /// Create a copy of PaginatedAreasState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaginatedAreasStateLoadedImplCopyWith<_$PaginatedAreasStateLoadedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PaginatedAreasStateErrorImplCopyWith<$Res> {
  factory _$$PaginatedAreasStateErrorImplCopyWith(
          _$PaginatedAreasStateErrorImpl value,
          $Res Function(_$PaginatedAreasStateErrorImpl) then) =
      __$$PaginatedAreasStateErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ApiError error});
}

/// @nodoc
class __$$PaginatedAreasStateErrorImplCopyWithImpl<$Res>
    extends _$PaginatedAreasStateCopyWithImpl<$Res,
        _$PaginatedAreasStateErrorImpl>
    implements _$$PaginatedAreasStateErrorImplCopyWith<$Res> {
  __$$PaginatedAreasStateErrorImplCopyWithImpl(
      _$PaginatedAreasStateErrorImpl _value,
      $Res Function(_$PaginatedAreasStateErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaginatedAreasState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$PaginatedAreasStateErrorImpl(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as ApiError,
    ));
  }
}

/// @nodoc

class _$PaginatedAreasStateErrorImpl implements PaginatedAreasStateError {
  const _$PaginatedAreasStateErrorImpl({required this.error});

  @override
  final ApiError error;

  @override
  String toString() {
    return 'PaginatedAreasState.error(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaginatedAreasStateErrorImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  /// Create a copy of PaginatedAreasState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaginatedAreasStateErrorImplCopyWith<_$PaginatedAreasStateErrorImpl>
      get copyWith => __$$PaginatedAreasStateErrorImplCopyWithImpl<
          _$PaginatedAreasStateErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<AreaInfo> areas, bool hasReachedEnd,
            bool isLoadingMore, Set<String> subscribedAreaIds)
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
    TResult? Function(List<AreaInfo> areas, bool hasReachedEnd,
            bool isLoadingMore, Set<String> subscribedAreaIds)?
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
    TResult Function(List<AreaInfo> areas, bool hasReachedEnd,
            bool isLoadingMore, Set<String> subscribedAreaIds)?
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
    required TResult Function(PaginatedAreasStateInitial value) initial,
    required TResult Function(PaginatedAreasStateLoading value) loading,
    required TResult Function(PaginatedAreasStateLoaded value) loaded,
    required TResult Function(PaginatedAreasStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PaginatedAreasStateInitial value)? initial,
    TResult? Function(PaginatedAreasStateLoading value)? loading,
    TResult? Function(PaginatedAreasStateLoaded value)? loaded,
    TResult? Function(PaginatedAreasStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PaginatedAreasStateInitial value)? initial,
    TResult Function(PaginatedAreasStateLoading value)? loading,
    TResult Function(PaginatedAreasStateLoaded value)? loaded,
    TResult Function(PaginatedAreasStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class PaginatedAreasStateError implements PaginatedAreasState {
  const factory PaginatedAreasStateError({required final ApiError error}) =
      _$PaginatedAreasStateErrorImpl;

  ApiError get error;

  /// Create a copy of PaginatedAreasState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaginatedAreasStateErrorImplCopyWith<_$PaginatedAreasStateErrorImpl>
      get copyWith => throw _privateConstructorUsedError;
}
