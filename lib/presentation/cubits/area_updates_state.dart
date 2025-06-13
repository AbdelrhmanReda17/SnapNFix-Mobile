import 'package:freezed_annotation/freezed_annotation.dart';

part 'area_updates_state.freezed.dart';

@freezed
class AreaUpdatesState with _$AreaUpdatesState {
  const factory AreaUpdatesState({
    required String selectedArea,
    required List<MapEntry<String, String>> areas,
  }) = _AreaUpdatesState;

  factory AreaUpdatesState.initial() => AreaUpdatesState(
    selectedArea: 'Mokattam',
    areas: const [
      MapEntry('Mokattam', 'Cairo'), 
      MapEntry('Nasr City', 'Cairo'),
      MapEntry('Maadi', 'Cairo'),
      MapEntry('Zamalek', 'Cairo'),
      MapEntry('Dokki', 'Giza'),
      MapEntry('Mohandessin', 'Giza'),
    ],
  );
}
