import 'dart:async';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:snapnfix/index.dart';
import 'package:snapnfix/modules/area_updates/presentation/cubits/area_subscription_notifier.dart';

part 'subscribed_areas_cubit.freezed.dart';
part 'subscribed_areas_state.dart';

class SubscribedAreasCubit extends HydratedCubit<SubscribedAreasState> {
  final GetSubscribedAreasUseCase _getSubscribedAreasUseCase;
  final UnsubscribeFromAreaUseCase _unsubscribeFromAreaUseCase;

  int _currentPage = 1;
  final int _pageSize = 10;
  String _searchQuery = '';
  DateTime? _lastFetchTime;
  String? _cachedUserPhone;
  final AreaSubscriptionNotifier _notifier;
  StreamSubscription<AreaSubscriptionEvent>? _subscriptionListener;
  bool _isHomeMode = false;

  static const Duration _cacheDuration = Duration(minutes: 5);

  SubscribedAreasCubit({
    required GetSubscribedAreasUseCase getSubscribedAreasUseCase,
    required UnsubscribeFromAreaUseCase unsubscribeFromAreaUseCase,
    required AreaSubscriptionNotifier notifier,
  }) : _getSubscribedAreasUseCase = getSubscribedAreasUseCase,
       _unsubscribeFromAreaUseCase = unsubscribeFromAreaUseCase,
       _notifier = notifier,
       super(const SubscribedAreasState.initial()) {
    _subscriptionListener = _notifier.stream.listen((event) {
      if (isClosed) return;
      
      if (event.isSubscribed) {
        _addAreaToState(event.areaInfo);
      } else {
        _removeAreaFromStateByInfo(event.areaInfo);
      }
    });
  }

  String? get _currentUserInfo {
    try {
      return getIt<ApplicationConfigurations>()
              .currentSession
              ?.user
              .phoneNumber ??
          getIt<ApplicationConfigurations>().currentSession?.user.email ??
          'anonymous';
    } catch (e) {
      debugPrint('Error getting user phone: $e');
      return null;
    }
  }

  bool _isCacheForCurrentUser() {
    final currentPhone = _currentUserInfo;
    if (currentPhone == null || _cachedUserPhone == null) return false;
    return currentPhone == _cachedUserPhone;
  }

  @override
  String get id => 'subscribed_areas_${_currentUserInfo ?? "anonymous"}';

  @override
  SubscribedAreasState? fromJson(Map<String, dynamic> json) {
    try {
      final cachedPhone = json['userPhone'] as String?;
      final currentPhone = _currentUserInfo;

      if (cachedPhone == null ||
          currentPhone == null ||
          cachedPhone != currentPhone) {
        debugPrint(
          '🗑️ Subscribed areas cache is for different user, clearing...',
        );
        return null;
      }

      _cachedUserPhone = cachedPhone;

      final lastFetchTimeStr = json['lastFetchTime'] as String?;
      if (lastFetchTimeStr != null) {
        _lastFetchTime = DateTime.parse(lastFetchTimeStr);
      }

      final areas =
          (json['areas'] as List<dynamic>?)
              ?.map((e) => AreaInfoModel.fromJson(e as Map<String, dynamic>))
              .cast<AreaInfo>()
              .toList() ??
          [];

      debugPrint('✅ Loaded subscribed areas cache: ${areas.length} areas');

      return SubscribedAreasState.loaded(
        areas: areas,
        hasReachedEnd: json['hasReachedEnd'] as bool? ?? true,
        isLoadingMore: false,
        isRefreshing: false,
        unsubscribingAreaIds: <String>{},
        lastFetchTime: _lastFetchTime,
        operationError: null,
      );
    } catch (e) {
      debugPrint('❌ Error deserializing SubscribedAreasState: $e');
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(SubscribedAreasState state) {
    final currentPhone = _currentUserInfo;
    if (currentPhone == null) return null;

    return state.maybeWhen(
      loaded:
          (
            List<AreaInfo> areas,
            bool hasReachedEnd,
            bool isLoadingMore,
            bool isRefreshing,
            Set<String> unsubscribingAreaIds,
            DateTime? lastFetchTime,
            String? operationError,
          ) => {
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
    debugPrint(
      '🕒 Subscribed areas cache ${isValid ? 'VALID' : 'EXPIRED'} (age: ${age.inMinutes}m)',
    );
    return isValid;
  }

  void _updateCacheTime() {
    _cachedUserPhone = _currentUserInfo;
    _lastFetchTime = DateTime.now();
  }

  Future<void> initialize() async {
    _clearCacheIfUserChanged();
    _currentPage = 1;
    _searchQuery = '';
    _isHomeMode = false;
    debugPrint('🔄 Initializing subscribed areas for user: $_currentUserInfo');
    final currentState = state;
    if (currentState is SubscribedAreasStateLoaded &&
        _isCacheValid() &&
        currentState.areas.isNotEmpty) {
      debugPrint('✅ Using cached subscribed areas');
      return;
    }

    await _loadAreas(isRefresh: true);
  }

  Future<void> loadForHome({bool forceRefresh = false}) async {
    _clearCacheIfUserChanged();
    _isHomeMode = true;
    final currentState = state;

    if (!forceRefresh &&
        currentState is SubscribedAreasStateLoaded &&
        _isCacheValid() &&
        currentState.areas.isNotEmpty) {
      debugPrint('✅ Using cached subscribed areas for home');
      final limitedAreas = currentState.areas.take(4).toList();
      if (isClosed) return;
      emit(currentState.copyWith(areas: limitedAreas, isRefreshing: false));
      return;
    }

    if (!forceRefresh &&
        currentState is SubscribedAreasStateLoaded &&
        currentState.areas.isNotEmpty) {
      debugPrint('🔄 Refreshing subscribed areas for home with existing data');
      final limitedAreas = currentState.areas.take(4).toList();
      if (isClosed) return;
      emit(currentState.copyWith(areas: limitedAreas, isRefreshing: true));
      await _loadSubscribedAreas(limit: 4, isRefreshing: true);
      return;
    }

    debugPrint('🔄 Loading subscribed areas for home (no cache)');
    if (isClosed) return;
    emit(const SubscribedAreasState.loading());
    await _loadSubscribedAreas(limit: 4);
  }

  Future<void> refresh() async {
    _clearCacheIfUserChanged();
    debugPrint('🔄 Refreshing subscribed areas');
    _currentPage = 1;
    _isHomeMode = false;
    await _loadAreas(isRefresh: true, forceRefresh: true);
  }

  Future<void> loadMore() async {
    if (isClosed) return;
    
    final currentState = state;
    if (currentState is SubscribedAreasStateLoaded &&
        !currentState.hasReachedEnd &&
        !currentState.isLoadingMore) {
      if (isClosed) return;
      emit(currentState.copyWith(isLoadingMore: true));
      _currentPage++;
      await _loadAreas(isLoadMore: true);
    }
  }

  Future<void> searchAreas(String query) async {
    if (_searchQuery != query) {
      _searchQuery = query;
      _currentPage = 1;
      await _loadAreas(isRefresh: true, forceRefresh: true);
    }
  }

  Future<void> unsubscribeFromArea(String areaId) async {
    final currentState = state;
    AreaInfo? areaToUnsubscribe;
    if (currentState is SubscribedAreasStateLoaded) {
      try {
        areaToUnsubscribe = currentState.areas.firstWhere(
          (area) => area.id == areaId,
        );
      } catch (e) {
        debugPrint('⚠️ Area $areaId not found in current state');
      }
    }

    if (currentState is SubscribedAreasStateLoaded) {
      final updatedUnsubscribing = Set<String>.from(
        currentState.unsubscribingAreaIds,
      )..add(areaId);
      if (isClosed) return;
      emit(currentState.copyWith(unsubscribingAreaIds: updatedUnsubscribing));
    }

    try {
      final result = await _unsubscribeFromAreaUseCase.call(areaId);

      result.when(
        success: (_) {
          debugPrint('✅ Successfully unsubscribed from area: $areaId');
          _removeAreaFromState(areaId);
          if (areaToUnsubscribe != null) {
            _notifier.notifyUnsubscribed(areaToUnsubscribe);
          }
        },
        failure: (error) {
          if (isClosed) return;
          
          debugPrint('Failed to unsubscribe from area: ${error.message}');
          final currentState = state;
          if (currentState is SubscribedAreasStateLoaded) {
            final updatedUnsubscribing = Set<String>.from(
              currentState.unsubscribingAreaIds,
            )..remove(areaId);
            if (isClosed) return;
            emit(
              currentState.copyWith(
                unsubscribingAreaIds: updatedUnsubscribing,
                operationError: 'Failed to unsubscribe: ${error.message}',
              ),
            );
          }
        },
      );
    } catch (e) {
      if (isClosed) return;
      final currentState = state;
      if (currentState is SubscribedAreasStateLoaded) {
        final updatedUnsubscribing = Set<String>.from(
          currentState.unsubscribingAreaIds,
        )..remove(areaId);
        if (isClosed) return;
        emit(
          currentState.copyWith(
            unsubscribingAreaIds: updatedUnsubscribing,
            operationError: 'Error unsubscribing from area: $e',
          ),
        );
      }
    }
  }

  void _clearCacheIfUserChanged() {
    if (!_isCacheForCurrentUser()) {
      debugPrint('🗑️ User changed, clearing subscribed areas cache...');
      _lastFetchTime = null;
      _cachedUserPhone = _currentUserInfo;
      if (isClosed) return;
      emit(const SubscribedAreasState.initial());
    }
  }

  Future<void> _loadAreas({
    bool isRefresh = false,
    bool isLoadMore = false,
    bool forceRefresh = false,
  }) async {
    if (isRefresh && !forceRefresh && _searchQuery.isEmpty && _isCacheValid()) {
      final currentState = state;
      if (currentState is SubscribedAreasStateLoaded &&
          currentState.areas.isNotEmpty) {
        debugPrint('✅ Using valid subscribed areas cache');
        return;
      }
    }

    if (isRefresh) {
      if (isClosed) return;
      emit(const SubscribedAreasState.loading());
    }

    await _loadSubscribedAreas(
      page: _currentPage,
      limit: _pageSize,
      isLoadMore: isLoadMore,
    );
  }

  Future<void> _loadSubscribedAreas({
    int page = 1,
    int limit = 10,
    bool isLoadMore = false,
    bool isRefreshing = false,
  }) async {
    debugPrint(
      '🔄 Loading subscribed areas: page $page, search "$_searchQuery"',
    );

    try {
      final result = await _getSubscribedAreasUseCase.call(
        page: page,
        limit: limit,
        searchTerm: _searchQuery.isEmpty ? null : _searchQuery,
      );

      result.when(
        success: (data) {
          if (isClosed) return;
          
          final currentState = state;
          List<AreaInfo> newAreas = data.key;
          if (isLoadMore && currentState is SubscribedAreasStateLoaded) {
            newAreas = [...currentState.areas, ...data.key];
          }

          _updateCacheTime();

          if (isClosed) return;
          emit(
            SubscribedAreasState.loaded(
              areas: newAreas,
              hasReachedEnd: !data.value,
              isLoadingMore: false,
              isRefreshing: false,
              unsubscribingAreaIds: <String>{},
              lastFetchTime: _lastFetchTime,
              operationError: null,
            ),
          );
        },
        failure: (error) {
          if (isClosed) return;
          
          if (isLoadMore) {
            final currentState = state;
            if (currentState is SubscribedAreasStateLoaded) {
              if (isClosed) return;
              emit(currentState.copyWith(isLoadingMore: false));
            }
          } else {
            if (isClosed) return;
            emit(SubscribedAreasState.error(error: error));
          }
        },
      );
    } catch (e) {
      if (isClosed) return;
      
      if (isLoadMore) {
        final currentState = state;
        if (currentState is SubscribedAreasStateLoaded) {
          if (isClosed) return;
          emit(currentState.copyWith(isLoadingMore: false));
        }
      } else {
        if (isClosed) return;
        emit(
          SubscribedAreasState.error(
            error: ApiError(message: 'Failed to load subscribed areas: $e'),
          ),
        );
      }
    }
  }

  void _removeAreaFromState(String areaId) {
    if (isClosed) return;
    
    final currentState = state;
    if (currentState is SubscribedAreasStateLoaded) {
      final updatedAreas =
          currentState.areas.where((a) => a.id != areaId).toList();
      final updatedUnsubscribing = Set<String>.from(
        currentState.unsubscribingAreaIds,
      )..remove(areaId);
      if (isClosed) return;
      emit(
        currentState.copyWith(
          areas: updatedAreas,
          unsubscribingAreaIds: updatedUnsubscribing,
          operationError: null,
        ),
      );
    }
  }

  void _removeAreaFromStateByInfo(AreaInfo areaInfo) {
    if (isClosed) return;
    
    final currentState = state;
    if (currentState is SubscribedAreasStateLoaded) {
      final existingAreaIndex = currentState.areas.indexWhere(
        (area) => area.id == areaInfo.id,
      );
      if (existingAreaIndex != -1) {
        final updatedAreas =
            currentState.areas.where((a) => a.id != areaInfo.id).toList();

        if (isClosed) return;
        emit(currentState.copyWith(areas: updatedAreas, operationError: null));
        debugPrint(
          '✅ Removed area ${areaInfo.id} from subscribed areas state (home mode: $_isHomeMode)',
        );
      }
    }
  }

  bool isUnsubscribing(String areaId) {
    final currentState = state;
    if (currentState is SubscribedAreasStateLoaded) {
      return currentState.unsubscribingAreaIds.contains(areaId);
    }
    return false;
  }

  void clearOperationError() {
    if (isClosed) return;
    
    final currentState = state;
    if (currentState is SubscribedAreasStateLoaded &&
        currentState.operationError != null) {
      if (isClosed) return;
      emit(currentState.copyWith(operationError: null));
    }
  }

  void _addAreaToState(AreaInfo newArea) {
    if (isClosed) return;
    
    final currentState = state;
    if (currentState is SubscribedAreasStateLoaded) {
      final existingAreaIndex = currentState.areas.indexWhere(
        (area) => area.id == newArea.id,
      );
      if (existingAreaIndex == -1) {
        List<AreaInfo> updatedAreas = [newArea, ...currentState.areas];
        if (_isHomeMode && updatedAreas.length > 4) {
          updatedAreas = updatedAreas.take(4).toList();
          debugPrint('🏠 Limited areas to 4 for home mode');
        }

        if (isClosed) return;
        emit(currentState.copyWith(areas: updatedAreas, operationError: null));
        debugPrint(
          '✅ Added area ${newArea.id} to subscribed areas state (home mode: $_isHomeMode)',
        );
      }
    }
  }

  @override
  Future<void> close() {
    _subscriptionListener?.cancel();
    return super.close();
  }
}
