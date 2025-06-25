// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'channels_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ChannelsState {
  String get selectedChannel => throw _privateConstructorUsedError;
  bool get isSubscribed => throw _privateConstructorUsedError;
  List<String> get channels => throw _privateConstructorUsedError;
  Map<String, List<IssueUpdate>> get updates =>
      throw _privateConstructorUsedError;
  List<IssueStatus> get selectedStatuses => throw _privateConstructorUsedError;

  /// Create a copy of ChannelsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChannelsStateCopyWith<ChannelsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChannelsStateCopyWith<$Res> {
  factory $ChannelsStateCopyWith(
          ChannelsState value, $Res Function(ChannelsState) then) =
      _$ChannelsStateCopyWithImpl<$Res, ChannelsState>;
  @useResult
  $Res call(
      {String selectedChannel,
      bool isSubscribed,
      List<String> channels,
      Map<String, List<IssueUpdate>> updates,
      List<IssueStatus> selectedStatuses});
}

/// @nodoc
class _$ChannelsStateCopyWithImpl<$Res, $Val extends ChannelsState>
    implements $ChannelsStateCopyWith<$Res> {
  _$ChannelsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChannelsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedChannel = null,
    Object? isSubscribed = null,
    Object? channels = null,
    Object? updates = null,
    Object? selectedStatuses = null,
  }) {
    return _then(_value.copyWith(
      selectedChannel: null == selectedChannel
          ? _value.selectedChannel
          : selectedChannel // ignore: cast_nullable_to_non_nullable
              as String,
      isSubscribed: null == isSubscribed
          ? _value.isSubscribed
          : isSubscribed // ignore: cast_nullable_to_non_nullable
              as bool,
      channels: null == channels
          ? _value.channels
          : channels // ignore: cast_nullable_to_non_nullable
              as List<String>,
      updates: null == updates
          ? _value.updates
          : updates // ignore: cast_nullable_to_non_nullable
              as Map<String, List<IssueUpdate>>,
      selectedStatuses: null == selectedStatuses
          ? _value.selectedStatuses
          : selectedStatuses // ignore: cast_nullable_to_non_nullable
              as List<IssueStatus>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChannelsStateImplCopyWith<$Res>
    implements $ChannelsStateCopyWith<$Res> {
  factory _$$ChannelsStateImplCopyWith(
          _$ChannelsStateImpl value, $Res Function(_$ChannelsStateImpl) then) =
      __$$ChannelsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String selectedChannel,
      bool isSubscribed,
      List<String> channels,
      Map<String, List<IssueUpdate>> updates,
      List<IssueStatus> selectedStatuses});
}

/// @nodoc
class __$$ChannelsStateImplCopyWithImpl<$Res>
    extends _$ChannelsStateCopyWithImpl<$Res, _$ChannelsStateImpl>
    implements _$$ChannelsStateImplCopyWith<$Res> {
  __$$ChannelsStateImplCopyWithImpl(
      _$ChannelsStateImpl _value, $Res Function(_$ChannelsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChannelsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedChannel = null,
    Object? isSubscribed = null,
    Object? channels = null,
    Object? updates = null,
    Object? selectedStatuses = null,
  }) {
    return _then(_$ChannelsStateImpl(
      selectedChannel: null == selectedChannel
          ? _value.selectedChannel
          : selectedChannel // ignore: cast_nullable_to_non_nullable
              as String,
      isSubscribed: null == isSubscribed
          ? _value.isSubscribed
          : isSubscribed // ignore: cast_nullable_to_non_nullable
              as bool,
      channels: null == channels
          ? _value._channels
          : channels // ignore: cast_nullable_to_non_nullable
              as List<String>,
      updates: null == updates
          ? _value._updates
          : updates // ignore: cast_nullable_to_non_nullable
              as Map<String, List<IssueUpdate>>,
      selectedStatuses: null == selectedStatuses
          ? _value._selectedStatuses
          : selectedStatuses // ignore: cast_nullable_to_non_nullable
              as List<IssueStatus>,
    ));
  }
}

/// @nodoc

class _$ChannelsStateImpl implements _ChannelsState {
  const _$ChannelsStateImpl(
      {required this.selectedChannel,
      required this.isSubscribed,
      required final List<String> channels,
      required final Map<String, List<IssueUpdate>> updates,
      final List<IssueStatus> selectedStatuses = const []})
      : _channels = channels,
        _updates = updates,
        _selectedStatuses = selectedStatuses;

  @override
  final String selectedChannel;
  @override
  final bool isSubscribed;
  final List<String> _channels;
  @override
  List<String> get channels {
    if (_channels is EqualUnmodifiableListView) return _channels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_channels);
  }

  final Map<String, List<IssueUpdate>> _updates;
  @override
  Map<String, List<IssueUpdate>> get updates {
    if (_updates is EqualUnmodifiableMapView) return _updates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_updates);
  }

  final List<IssueStatus> _selectedStatuses;
  @override
  @JsonKey()
  List<IssueStatus> get selectedStatuses {
    if (_selectedStatuses is EqualUnmodifiableListView)
      return _selectedStatuses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedStatuses);
  }

  @override
  String toString() {
    return 'ChannelsState(selectedChannel: $selectedChannel, isSubscribed: $isSubscribed, channels: $channels, updates: $updates, selectedStatuses: $selectedStatuses)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChannelsStateImpl &&
            (identical(other.selectedChannel, selectedChannel) ||
                other.selectedChannel == selectedChannel) &&
            (identical(other.isSubscribed, isSubscribed) ||
                other.isSubscribed == isSubscribed) &&
            const DeepCollectionEquality().equals(other._channels, _channels) &&
            const DeepCollectionEquality().equals(other._updates, _updates) &&
            const DeepCollectionEquality()
                .equals(other._selectedStatuses, _selectedStatuses));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      selectedChannel,
      isSubscribed,
      const DeepCollectionEquality().hash(_channels),
      const DeepCollectionEquality().hash(_updates),
      const DeepCollectionEquality().hash(_selectedStatuses));

  /// Create a copy of ChannelsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChannelsStateImplCopyWith<_$ChannelsStateImpl> get copyWith =>
      __$$ChannelsStateImplCopyWithImpl<_$ChannelsStateImpl>(this, _$identity);
}

abstract class _ChannelsState implements ChannelsState {
  const factory _ChannelsState(
      {required final String selectedChannel,
      required final bool isSubscribed,
      required final List<String> channels,
      required final Map<String, List<IssueUpdate>> updates,
      final List<IssueStatus> selectedStatuses}) = _$ChannelsStateImpl;

  @override
  String get selectedChannel;
  @override
  bool get isSubscribed;
  @override
  List<String> get channels;
  @override
  Map<String, List<IssueUpdate>> get updates;
  @override
  List<IssueStatus> get selectedStatuses;

  /// Create a copy of ChannelsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChannelsStateImplCopyWith<_$ChannelsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
