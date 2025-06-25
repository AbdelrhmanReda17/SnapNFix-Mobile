import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snapnfix/core/infrastructure/networking/error/api_error.dart';
import 'package:snapnfix/modules/area_updates/domain/entities/area_info.dart';
import 'package:snapnfix/modules/area_updates/domain/usecases/get_all_areas_use_case.dart';
import 'package:snapnfix/modules/area_updates/domain/usecases/get_subscribed_areas_use_case.dart';
import 'package:snapnfix/modules/area_updates/domain/usecases/subscribe_to_area_use_case.dart';
import 'package:snapnfix/modules/area_updates/domain/usecases/unsubscribe_from_area_use_case.dart';

part 'paginated_areas_cubit.freezed.dart';
part 'paginated_areas_state.dart';

class PaginatedAreasCubit extends Cubit<PaginatedAreasState> {
  final GetAllAreasUseCase _getAllAreasUseCase;
  final GetSubscribedAreasUseCase _getSubscribedAreasUseCase;
  final SubscribeToAreaUseCase _subscribeToAreaUseCase;
  final UnsubscribeFromAreaUseCase _unsubscribeFromAreaUseCase;

  int _currentPage = 1;
  final int _pageSize = 10;
  String _searchQuery = '';
  bool _isSubscribedMode = false;

  PaginatedAreasCubit({
    required GetAllAreasUseCase getAllAreasUseCase,
    required GetSubscribedAreasUseCase getSubscribedAreasUseCase,
    required SubscribeToAreaUseCase subscribeToAreaUseCase,
    required UnsubscribeFromAreaUseCase unsubscribeFromAreaUseCase,
  }) : _getAllAreasUseCase = getAllAreasUseCase,
       _getSubscribedAreasUseCase = getSubscribedAreasUseCase,
       _subscribeToAreaUseCase = subscribeToAreaUseCase,
       _unsubscribeFromAreaUseCase = unsubscribeFromAreaUseCase,
       super(const PaginatedAreasState.initial());

  // Initialize with all areas
  Future<void> initialize({bool subscribed = false}) async {
    _isSubscribedMode = subscribed;
    _currentPage = 1;
    _searchQuery = '';
    await _loadAreas(isRefresh: true);
  }

  // Load initial subscribed areas (limited to 4 for home screen)
  Future<void> loadSubscribedAreasForHome() async {
    emit(const PaginatedAreasState.loading());

    try {
      final result = await _getSubscribedAreasUseCase.call(page: 1, limit: 4);

      result.when(
        success: (data) {
          emit(
            PaginatedAreasState.loaded(
              areas: data.key,
              hasReachedEnd: !data.value,
              isLoadingMore: false,
              subscribedAreaIds: data.key.map((e) => e.id).toSet(),
            ),
          );
        },
        failure: (error) {
          emit(PaginatedAreasState.error(error: error));
        },
      );
    } catch (e) {
      emit(
        PaginatedAreasState.error(
          error: ApiError(message: 'Failed to load subscribed areas: $e'),
        ),
      );
    }
  }

  // Refresh the current list
  Future<void> refresh() async {
    _currentPage = 1;
    await _loadAreas(isRefresh: true);
  }

  // Load more items (pagination)
  Future<void> loadMore() async {
    final currentState = state;
    if (currentState is PaginatedAreasStateLoaded &&
        !currentState.hasReachedEnd &&
        !currentState.isLoadingMore) {
      emit(currentState.copyWith(isLoadingMore: true));
      _currentPage++;
      await _loadAreas(isLoadMore: true);
    }
  }

  // Search areas
  Future<void> searchAreas(String query) async {
    if (_searchQuery != query) {
      _searchQuery = query;
      _currentPage = 1;
      await _loadAreas(isRefresh: true);
    }
  }

  // Toggle between all areas and subscribed areas
  Future<void> toggleMode({bool subscribed = false}) async {
    if (_isSubscribedMode != subscribed) {
      _isSubscribedMode = subscribed;
      _currentPage = 1;
      _searchQuery = '';
      await _loadAreas(isRefresh: true);
    }
  }

  // Subscribe to area
  Future<void> subscribeToArea(String cityId) async {
    try {
      final result = await _subscribeToAreaUseCase.call(cityId);

      result.when(
        success: (_) {
          _updateSubscriptionInState(cityId, true);
        },
        failure: (error) {
          // Handle error - could emit a temporary error or show snackbar
        },
      );
    } catch (e) {
      // Handle error
    }
  }

  // Unsubscribe from area
  Future<void> unsubscribeFromArea(String areaName) async {
    try {
      final result = await _unsubscribeFromAreaUseCase.call(areaName);

      result.when(
        success: (_) {
          _updateSubscriptionInState(areaName, false);
        },
        failure: (error) {
        },
      );
    } catch (e) {
    }
  }

  // Check if subscribed to area
  bool isSubscribedToArea(String areaName) {
    return state.maybeWhen(
      loaded:
          (_, __, ___, subscribedAreaNames) =>
              subscribedAreaNames.contains(areaName),
      orElse: () => false,
    );
  }

  // Private methods
  Future<void> _loadAreas({
    bool isRefresh = false,
    bool isLoadMore = false,
  }) async {
    if (isRefresh) {
      emit(const PaginatedAreasState.loading());
    }
    debugPrint(
      'Loading areas: page $_currentPage, size $_pageSize, search "$_searchQuery", subscribed mode $_isSubscribedMode',
    );
    try {
      final result =
          _isSubscribedMode
              ? await _getSubscribedAreasUseCase.call(
                page: _currentPage,
                limit: _pageSize,
                searchTerm: _searchQuery.isEmpty ? null : _searchQuery,
              )
              : await _getAllAreasUseCase.call(
                page: _currentPage,
                limit: _pageSize,
                searchTerm: _searchQuery.isEmpty ? null : _searchQuery,
              );

      result.when(
        success: (data) {
          final currentState = state;
          List<AreaInfo> newAreas = data.key;
          Set<String> subscribedAreaNames = <String>{};

          // If we're loading more, combine with existing areas
          if (isLoadMore && currentState is PaginatedAreasStateLoaded) {
            newAreas = [...currentState.areas, ...data.key];
            subscribedAreaNames = currentState.subscribedAreaIds;
          }

          // Update subscribed area names if we're in subscribed mode
          if (_isSubscribedMode) {
            subscribedAreaNames = newAreas.map((e) => e.id).toSet();
          } else {
            // Load subscribed areas to mark them in all areas list
            _loadSubscribedAreaNames().then((id) {
              if (!isClosed) {
                final updatedState = state;
                if (updatedState is PaginatedAreasStateLoaded) {
                  emit(updatedState.copyWith(subscribedAreaIds: id));
                }
              }
            });
          }

          emit(
            PaginatedAreasState.loaded(
              areas: newAreas,
              hasReachedEnd: !data.value,
              isLoadingMore: false,
              subscribedAreaIds: subscribedAreaNames,
            ),
          );
        },
        failure: (error) {
          if (isLoadMore) {
            // If loading more failed, just stop the loading state
            final currentState = state;
            if (currentState is PaginatedAreasStateLoaded) {
              emit(currentState.copyWith(isLoadingMore: false));
            }
          } else {
            emit(PaginatedAreasState.error(error: error));
          }
        },
      );
    } catch (e) {
      if (isLoadMore) {
        final currentState = state;
        if (currentState is PaginatedAreasStateLoaded) {
          emit(currentState.copyWith(isLoadingMore: false));
        }
      } else {
        emit(
          PaginatedAreasState.error(
            error: ApiError(message: 'Failed to load areas: $e'),
          ),
        );
      }
    }
  }

  Future<Set<String>> _loadSubscribedAreaNames() async {
    try {
      final result = await _getSubscribedAreasUseCase.call(
        page: 1,
        limit: 10,
      );
      return result.when(
        success: (data) => data.key.map((e) => e.id).toSet(),
        failure: (_) => <String>{},
      );
    } catch (e) {
      return <String>{};
    }
  }

  void _updateSubscriptionInState(String cityId, bool isSubscribed) {
    final currentState = state;
    if (currentState is PaginatedAreasStateLoaded) {
      final updatedSubscriptions = Set<String>.from(
        currentState.subscribedAreaIds,
      );
      if (isSubscribed) {
        updatedSubscriptions.add(cityId);
      } else {
        updatedSubscriptions.remove(cityId);
      }
      emit(currentState.copyWith(subscribedAreaIds: updatedSubscriptions));
    }
  }
}
