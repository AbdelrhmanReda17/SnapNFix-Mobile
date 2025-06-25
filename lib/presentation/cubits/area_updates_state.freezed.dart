// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'area_updates_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AreaUpdatesState {
  String get selectedArea => throw _privateConstructorUsedError;
  List<MapEntry<String, String>> get areas =>
      throw _privateConstructorUsedError;

  /// Create a copy of AreaUpdatesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AreaUpdatesStateCopyWith<AreaUpdatesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AreaUpdatesStateCopyWith<$Res> {
  factory $AreaUpdatesStateCopyWith(
          AreaUpdatesState value, $Res Function(AreaUpdatesState) then) =
      _$AreaUpdatesStateCopyWithImpl<$Res, AreaUpdatesState>;
  @useResult
  $Res call({String selectedArea, List<MapEntry<String, String>> areas});
}

/// @nodoc
class _$AreaUpdatesStateCopyWithImpl<$Res, $Val extends AreaUpdatesState>
    implements $AreaUpdatesStateCopyWith<$Res> {
  _$AreaUpdatesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AreaUpdatesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedArea = null,
    Object? areas = null,
  }) {
    return _then(_value.copyWith(
      selectedArea: null == selectedArea
          ? _value.selectedArea
          : selectedArea // ignore: cast_nullable_to_non_nullable
              as String,
      areas: null == areas
          ? _value.areas
          : areas // ignore: cast_nullable_to_non_nullable
              as List<MapEntry<String, String>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AreaUpdatesStateImplCopyWith<$Res>
    implements $AreaUpdatesStateCopyWith<$Res> {
  factory _$$AreaUpdatesStateImplCopyWith(_$AreaUpdatesStateImpl value,
          $Res Function(_$AreaUpdatesStateImpl) then) =
      __$$AreaUpdatesStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String selectedArea, List<MapEntry<String, String>> areas});
}

/// @nodoc
class __$$AreaUpdatesStateImplCopyWithImpl<$Res>
    extends _$AreaUpdatesStateCopyWithImpl<$Res, _$AreaUpdatesStateImpl>
    implements _$$AreaUpdatesStateImplCopyWith<$Res> {
  __$$AreaUpdatesStateImplCopyWithImpl(_$AreaUpdatesStateImpl _value,
      $Res Function(_$AreaUpdatesStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AreaUpdatesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedArea = null,
    Object? areas = null,
  }) {
    return _then(_$AreaUpdatesStateImpl(
      selectedArea: null == selectedArea
          ? _value.selectedArea
          : selectedArea // ignore: cast_nullable_to_non_nullable
              as String,
      areas: null == areas
          ? _value._areas
          : areas // ignore: cast_nullable_to_non_nullable
              as List<MapEntry<String, String>>,
    ));
  }
}

/// @nodoc

class _$AreaUpdatesStateImpl implements _AreaUpdatesState {
  const _$AreaUpdatesStateImpl(
      {required this.selectedArea,
      required final List<MapEntry<String, String>> areas})
      : _areas = areas;

  @override
  final String selectedArea;
  final List<MapEntry<String, String>> _areas;
  @override
  List<MapEntry<String, String>> get areas {
    if (_areas is EqualUnmodifiableListView) return _areas;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_areas);
  }

  @override
  String toString() {
    return 'AreaUpdatesState(selectedArea: $selectedArea, areas: $areas)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AreaUpdatesStateImpl &&
            (identical(other.selectedArea, selectedArea) ||
                other.selectedArea == selectedArea) &&
            const DeepCollectionEquality().equals(other._areas, _areas));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, selectedArea, const DeepCollectionEquality().hash(_areas));

  /// Create a copy of AreaUpdatesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AreaUpdatesStateImplCopyWith<_$AreaUpdatesStateImpl> get copyWith =>
      __$$AreaUpdatesStateImplCopyWithImpl<_$AreaUpdatesStateImpl>(
          this, _$identity);
}

abstract class _AreaUpdatesState implements AreaUpdatesState {
  const factory _AreaUpdatesState(
          {required final String selectedArea,
          required final List<MapEntry<String, String>> areas}) =
      _$AreaUpdatesStateImpl;

  @override
  String get selectedArea;
  @override
  List<MapEntry<String, String>> get areas;

  /// Create a copy of AreaUpdatesState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AreaUpdatesStateImplCopyWith<_$AreaUpdatesStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
