part of 'area_health_cubit.dart';

@freezed
class AreaHealthState with _$AreaHealthState {
  const factory AreaHealthState.initial() = _Initial;
  const factory AreaHealthState.loading() = _Loading;
  const factory AreaHealthState.loaded(AreaHealthMetrics healthMetrics) = _Loaded;
  const factory AreaHealthState.error(ApiError error) = _Error;
}
