import 'dart:async';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:snapnfix/index.dart';
import 'package:snapnfix/modules/area_updates/presentation/cubits/area_subscription_notifier.dart';

part 'all_areas_cubit.freezed.dart';
part 'all_areas_state.dart';

class AllAreasCubit extends HydratedCubit<AllAreasState> {
  final GetAllAreasUseCase _getAllAreasUseCase;
  final SubscribeToAreaUseCase _subscribeToAreaUseCase;

  int _currentPage = 1;
  final int _pageSize = 10;
  String _searchQuery = '';
  DateTime? _lastFetchTime;
  String? _cachedUserPhone;
  final AreaSubscriptionNotifier _notifier = AreaSubscriptionNotifier();
  StreamSubscription<AreaSubscriptionEvent>? _subscriptionListener;

  // Cache duration - 5 minutes
  static const Duration _cacheDuration = Duration(minutes: 5);

  AllAreasCubit({
    required GetAllAreasUseCase getAllAreasUseCase,
    required SubscribeToAreaUseCase subscribeToAreaUseCase,
  }) : _getAllAreasUseCase = getAllAreasUseCase,
       _subscribeToAreaUseCase = subscribeToAreaUseCase,
       super(const AllAreasState.initial()) {
    debugPrint('🎯 AllAreasCubit instance created: ${hashCode}');
    _subscriptionListener = _notifier.stream.listen((event) {
      debugPrint('🔔 AllAreasCubit (${hashCode}) received notification: ${event.areaInfo.name} - subscribed: ${event.isSubscribed}');
      if (!event.isSubscribed) {
        // Add the unsubscribed area directly to state
        _addAreaToState(event.areaInfo);
      }
    });
  }

  // Get current user's phone for cache key
  String? get _currentUserPhone {
    try {
      return getIt<ApplicationConfigurations>()
          .currentSession
          ?.user
          .phoneNumber;
    } catch (e) {
      debugPrint('Error getting user phone: $e');
      return null;
    }
  }

  bool _isCacheForCurrentUser() {
    final currentPhone = _currentUserPhone;
    if (currentPhone == null || _cachedUserPhone == null) return false;
    return currentPhone == _cachedUserPhone;
  }

  @override
  String get id => 'all_areas_${_currentUserPhone ?? "anonymous"}';

  @override
  AllAreasState? fromJson(Map<String, dynamic> json) {
    try {
      final cachedPhone = json['userPhone'] as String?;
      final currentPhone = _currentUserPhone;

      if (cachedPhone == null ||
          currentPhone == null ||
          cachedPhone != currentPhone) {
        debugPrint('🗑️ All areas cache is for different user, clearing...');
        return null;
      }

      _cachedUserPhone = cachedPhone;

      final lastFetchTimeStr = json['lastFetchTime'] as String?;
      if (lastFetchTimeStr != null) {
        _lastFetchTime = DateTime.parse(lastFetchTimeStr);
      }

      final areas = (json['areas'] as List<dynamic>?)
              ?.map((e) => AreaInfoModel.fromJson(e as Map<String, dynamic>))
              .cast<AreaInfo>()
              .toList() ??
          [];

      debugPrint('✅ Loaded all areas cache: ${areas.length} areas');

      return AllAreasState.loaded(
        areas: areas,
        hasReachedEnd: json['hasReachedEnd'] as bool? ?? true,
        isLoadingMore: false,
        subscribingAreaIds: <String>{},
        lastFetchTime: _lastFetchTime,
        operationError: null,
      );
    } catch (e) {
      debugPrint('❌ Error deserializing AllAreasState: $e');
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(AllAreasState state) {
    final currentPhone = _currentUserPhone;
    if (currentPhone == null) return null;

    return state.maybeWhen(
      loaded: (areas, hasReachedEnd, isLoadingMore, subscribingAreaIds, lastFetchTime, operationError) => {
        'userPhone': currentPhone,
        'areas': areas.map((e) => (e as AreaInfoModel).toJson()).toList(),
        'hasReachedEnd': hasReachedEnd,
        'lastFetchTime': lastFetchTime?.toIso8601String(),
      },
      orElse: () => null,
    );
  }

  bool _isCacheValid() {
    if (!_isCacheForCurrentUser()) return false;
    if (_lastFetchTime == null) return false;

    final age = DateTime.now().difference(_lastFetchTime!);
    final isValid = age < _cacheDuration;
    debugPrint('🕒 All areas cache ${isValid ? 'VALID' : 'EXPIRED'} (age: ${age.inMinutes}m)');
    return isValid;
  }

  void _updateCacheTime() {
    _cachedUserPhone = _currentUserPhone;
    _lastFetchTime = DateTime.now();
  }

  // Initialize all areas
  Future<void> initialize() async {
    _clearCacheIfUserChanged();
    _currentPage = 1;
    _searchQuery = '';

    debugPrint('🔄 Initializing all areas for user: $_currentUserPhone');

    // Check cache first
    final currentState = state;
    if (currentState is AllAreasStateLoaded &&
        _isCacheValid() &&
        currentState.areas.isNotEmpty) {
      debugPrint('✅ Using cached all areas');
      return;
    }

    await _loadAreas(isRefresh: true);
  }

  // Refresh areas
  Future<void> refresh() async {
    _clearCacheIfUserChanged();
    debugPrint('🔄 Refreshing all areas');
    _currentPage = 1;
    await _loadAreas(isRefresh: true, forceRefresh: true);
  }

  // Load more areas (pagination)
  Future<void> loadMore() async {
    final currentState = state;
    if (currentState is AllAreasStateLoaded &&
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
      await _loadAreas(isRefresh: true, forceRefresh: true);
    }
  }

  // Subscribe to area
  Future<void> subscribeToArea(String cityId) async {
    // Find the area info for notification
    final currentState = state;
    AreaInfo? areaToSubscribe;
    if (currentState is AllAreasStateLoaded) {
      try {
        areaToSubscribe = currentState.areas.firstWhere(
          (area) => area.id == cityId,
        );
      } catch (e) {
        debugPrint('⚠️ Area $cityId not found in current state');
      }
    }

    // Add to subscribing list
    if (currentState is AllAreasStateLoaded) {
      final updatedSubscribing = Set<String>.from(currentState.subscribingAreaIds)
        ..add(cityId);
      emit(currentState.copyWith(subscribingAreaIds: updatedSubscribing));
    }

    try {
      final result = await _subscribeToAreaUseCase.call(cityId);

      result.when(
        success: (_) {
          debugPrint('✅ Successfully subscribed to area: $cityId');
          _updateSubscriptionInState(cityId, true);
          // Remove from all areas list since it's now subscribed
          _removeAreaFromState(cityId);
          // Notify other cubits with area info
          if (areaToSubscribe != null) {
            debugPrint('📢 AllAreasCubit (${hashCode}) sending subscription notification for: ${areaToSubscribe.name}');
            _notifier.notifySubscribed(areaToSubscribe);
          }
        },
        failure: (error) {
          debugPrint('Failed to subscribe to area: ${error.message}');
          // Remove from subscribing list and show error
          final currentState = state;
          if (currentState is AllAreasStateLoaded) {
            final updatedSubscribing = Set<String>.from(currentState.subscribingAreaIds)
              ..remove(cityId);
            emit(
              currentState.copyWith(
                subscribingAreaIds: updatedSubscribing,
                operationError: 'Failed to subscribe: ${error.message}',
              ),
            );
          }
        },
      );
    } catch (e) {
      debugPrint('Error subscribing to area: $e');
      // Remove from subscribing list and show error
      final currentState = state;
      if (currentState is AllAreasStateLoaded) {
        final updatedSubscribing = Set<String>.from(currentState.subscribingAreaIds)
          ..remove(cityId);
        emit(
          currentState.copyWith(
            subscribingAreaIds: updatedSubscribing,
            operationError: 'Error subscribing to area: $e',
          ),
        );
      }
    }
  }

  // Check if subscribed to area (always false since API only returns unsubscribed areas)
  bool isSubscribedToArea(String areaId) {
    return false; // All areas in this cubit are unsubscribed by design
  }

  // Check if area is being subscribed
  bool isSubscribing(String areaId) {
    final currentState = state;
    if (currentState is AllAreasStateLoaded) {
      return currentState.subscribingAreaIds.contains(areaId);
    }
    return false;
  }

  // Clear operation error
  void clearOperationError() {
    final currentState = state;
    if (currentState is AllAreasStateLoaded && currentState.operationError != null) {
      emit(currentState.copyWith(operationError: null));
    }
  }

  void _clearCacheIfUserChanged() {
    if (!_isCacheForCurrentUser()) {
      debugPrint('🗑️ User changed, clearing all areas cache...');
      _lastFetchTime = null;
      _cachedUserPhone = _currentUserPhone;
      emit(const AllAreasState.initial());
    }
  }

  Future<void> _loadAreas({
    bool isRefresh = false,
    bool isLoadMore = false,
    bool forceRefresh = false,
  }) async {
    // Check cache
    if (isRefresh &&
        !forceRefresh &&
        _searchQuery.isEmpty &&
        _isCacheValid()) {
      final currentState = state;
      if (currentState is AllAreasStateLoaded &&
          currentState.areas.isNotEmpty) {
        debugPrint('✅ Using valid all areas cache');
        return;
      }
    }

    if (isRefresh) {
      emit(const AllAreasState.loading());
    }

    debugPrint('🔄 Loading all areas: page $_currentPage, search "$_searchQuery"');

    try {
      final result = await _getAllAreasUseCase.call(
        page: _currentPage,
        limit: _pageSize,
        searchTerm: _searchQuery.isEmpty ? null : _searchQuery,
      );

      result.when(
        success: (data) {
          final currentState = state;
          List<AreaInfo> newAreas = data.key;

          // If loading more, combine with existing areas
          if (isLoadMore && currentState is AllAreasStateLoaded) {
            newAreas = [...currentState.areas, ...data.key];
          }

          _updateCacheTime();

          emit(
            AllAreasState.loaded(
              areas: newAreas,
              hasReachedEnd: !data.value,
              isLoadingMore: false,
              subscribingAreaIds: <String>{},
              lastFetchTime: _lastFetchTime,
              operationError: null,
            ),
          );
        },
        failure: (error) {
          if (isLoadMore) {
            final currentState = state;
            if (currentState is AllAreasStateLoaded) {
              emit(currentState.copyWith(isLoadingMore: false));
            }
          } else {
            emit(AllAreasState.error(error: error));
          }
        },
      );
    } catch (e) {
      if (isLoadMore) {
        final currentState = state;
        if (currentState is AllAreasStateLoaded) {
          emit(currentState.copyWith(isLoadingMore: false));
        }
      } else {
        emit(
          AllAreasState.error(
            error: ApiError(message: 'Failed to load all areas: $e'),
          ),
        );
      }
    }
  }

  void _updateSubscriptionInState(String cityId, bool isSubscribed) {
    // No need to track subscriptions since API only returns unsubscribed areas
    // This method is kept for interface compatibility
  }

  void _removeAreaFromState(String areaId) {
    final currentState = state;
    if (currentState is AllAreasStateLoaded) {
      final updatedAreas = currentState.areas.where((a) => a.id != areaId).toList();
      final updatedSubscribing = Set<String>.from(currentState.subscribingAreaIds)
        ..remove(areaId);
      emit(currentState.copyWith(
        areas: updatedAreas,
        subscribingAreaIds: updatedSubscribing,
        operationError: null,
      ));
    }
  }

  void _addAreaToState(AreaInfo newArea) {
    final currentState = state;
    if (currentState is AllAreasStateLoaded) {
      // Check if area already exists
      final existingAreaIndex = currentState.areas.indexWhere((area) => area.id == newArea.id);
      if (existingAreaIndex == -1) {
        // Add new area to the beginning of the list
        final updatedAreas = [newArea, ...currentState.areas];
        emit(currentState.copyWith(
          areas: updatedAreas,
          operationError: null,
        ));
        debugPrint('✅ Added area ${newArea.id} to all areas state');
      }
    }
  }

  @override
  Future<void> close() {
    _subscriptionListener?.cancel();
    return super.close();
  }
} 