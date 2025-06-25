part of 'all_areas_cubit.dart';

@freezed
class AllAreasState with _$AllAreasState {
  const factory AllAreasState.initial() = AllAreasStateInitial;

  const factory AllAreasState.loading() = AllAreasStateLoading;

  const factory AllAreasState.loaded({
    required List<AreaInfo> areas,
    required bool hasReachedEnd,
    required bool isLoadingMore,
    @Default(<String>{}) Set<String> subscribingAreaIds,
    DateTime? lastFetchTime,
    String? operationError,
  }) = AllAreasStateLoaded;

  const factory AllAreasState.error({
    required ApiError error,
  }) = AllAreasStateError;
} 