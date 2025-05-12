import 'package:freezed_annotation/freezed_annotation.dart';

part 'area_updates_state.freezed.dart';

@freezed
class AreaUpdatesState with _$AreaUpdatesState {
  const factory AreaUpdatesState({
    required String selectedArea,
    required List<String> areas,
  }) = _AreaUpdatesState;

  factory AreaUpdatesState.initial() => const AreaUpdatesState(
    selectedArea: 'Nasr City',
    areas: [
      'Nasr City',
      'Downtown',
      'Maadi',
      'Zamalek',
      'Heliopolis',
    ],
  );
} 