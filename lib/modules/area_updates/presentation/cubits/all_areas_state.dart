import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snapnfix/modules/area_updates/domain/entities/area_info.dart';

part 'all_areas_state.freezed.dart';

@freezed
class AllAreasState with _$AllAreasState {
  const factory AllAreasState.initial() = _Initial;
  const factory AllAreasState.loading() = _Loading;
  const factory AllAreasState.loaded(List<AreaInfo> areas) = _Loaded;
  const factory AllAreasState.error(String message) = _Error;
}
