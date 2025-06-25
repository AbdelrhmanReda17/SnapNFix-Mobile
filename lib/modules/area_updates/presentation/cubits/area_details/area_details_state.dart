part of 'area_details_cubit.dart';

@freezed
class AreaDetailsState with _$AreaDetailsState {
  const factory AreaDetailsState.initial() = _Initial;
  const factory AreaDetailsState.loading() = _Loading;
  const factory AreaDetailsState.loaded(AreaDetails areaDetails) = _Loaded;
  const factory AreaDetailsState.error(ApiError error) = _Error;
}
