part of 'subscribed_areas_cubit.dart';

@freezed
class SubscribedAreasState with _$SubscribedAreasState {
  const factory SubscribedAreasState.initial() = SubscribedAreasStateInitial;

  const factory SubscribedAreasState.loading() = SubscribedAreasStateLoading;

  const factory SubscribedAreasState.loaded({
    required List<AreaInfo> areas,
    required bool hasReachedEnd,
    required bool isLoadingMore,
    @Default(<String>{}) Set<String> unsubscribingAreaIds,
    DateTime? lastFetchTime,
    String? operationError,
  }) = SubscribedAreasStateLoaded;

  const factory SubscribedAreasState.error({
    required ApiError error,
  }) = SubscribedAreasStateError;
} 