part of 'paginated_areas_cubit.dart';

@freezed
class PaginatedAreasState with _$PaginatedAreasState {
  const factory PaginatedAreasState.initial() = PaginatedAreasStateInitial;

  const factory PaginatedAreasState.loading() = PaginatedAreasStateLoading;

  const factory PaginatedAreasState.loaded({
    required List<AreaInfo> areas,
    required bool hasReachedEnd,
    required bool isLoadingMore,
    required Set<String> subscribedAreaIds,
  }) = PaginatedAreasStateLoaded;

  const factory PaginatedAreasState.error({
    required ApiError error,
  }) = PaginatedAreasStateError;
} 