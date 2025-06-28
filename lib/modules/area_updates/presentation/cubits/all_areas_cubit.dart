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
  final AreaSubscriptionNotifier _notifier;
  StreamSubscription<AreaSubscriptionEvent>? _subscriptionListener;

  static const Duration _cacheDuration = Duration(minutes: 5);

  AllAreasCubit({
    required GetAllAreasUseCase getAllAreasUseCase,
    required SubscribeToAreaUseCase subscribeToAreaUseCase,
    required AreaSubscriptionNotifier notifier,
  }) : _getAllAreasUseCase = getAllAreasUseCase,
       _subscribeToAreaUseCase = subscribeToAreaUseCase,
       _notifier = notifier,
       super(const AllAreasState.initial()) {
    _subscriptionListener = _notifier.stream.listen((event) {
      debugPrint('📢 AllAreasCubit received subscription event:');
      debugPrint('  Area: ${event.areaInfo.name} (${event.areaInfo.id})');
      debugPrint('  Is subscribed: ${event.isSubscribed}');

      if (!event.isSubscribed) {
        debugPrint('➕ Adding area back to all areas (unsubscribed)');
        _addAreaToState(event.areaInfo);
      } else {
        debugPrint('➖ Removing area from all areas (subscribed)');
        _removeAreaFromStateByInfo(event.areaInfo);
      }
    });
  }

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

      final areas =
          (json['areas'] as List<dynamic>?)
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
      loaded:
          (
            areas,
            hasReachedEnd,
            isLoadingMore,
            subscribingAreaIds,
            lastFetchTime,
            operationError,
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
      '🕒 All areas cache ${isValid ? 'VALID' : 'EXPIRED'} (age: ${age.inMinutes}m)',
    );
    return isValid;
  }

  void _updateCacheTime() {
    _cachedUserPhone = _currentUserPhone;
    _lastFetchTime = DateTime.now();
  }

  Future<void> initialize() async {
    _clearCacheIfUserChanged();
    _currentPage = 1;
    _searchQuery = '';

    debugPrint('🔄 Initializing all areas for user: $_currentUserPhone');

    final currentState = state;
    if (currentState is AllAreasStateLoaded &&
        _isCacheValid() &&
        currentState.areas.isNotEmpty) {
      debugPrint('✅ Using cached all areas');
      return;
    }

    await _loadAreas(isRefresh: true);
  }

  Future<void> refresh() async {
    _clearCacheIfUserChanged();
    debugPrint('🔄 Refreshing all areas');
    _currentPage = 1;
    await _loadAreas(isRefresh: true, forceRefresh: true);
  }

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

  Future<void> searchAreas(String query) async {
    if (_searchQuery != query) {
      _searchQuery = query;
      _currentPage = 1;
      await _loadAreas(isRefresh: true, forceRefresh: true);
    }
  }

  Future<void> subscribeToArea(String cityId) async {
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

    if (currentState is AllAreasStateLoaded) {
      final updatedSubscribing = Set<String>.from(
        currentState.subscribingAreaIds,
      )..add(cityId);
      emit(currentState.copyWith(subscribingAreaIds: updatedSubscribing));
    }

    try {
      final result = await _subscribeToAreaUseCase.call(cityId);

      result.when(
        success: (_) {
          debugPrint('✅ Successfully subscribed to area: $cityId');
          // Remove from subscribing state first
          final currentState = state;
          if (currentState is AllAreasStateLoaded) {
            final updatedSubscribing = Set<String>.from(
              currentState.subscribingAreaIds,
            )..remove(cityId);
            emit(currentState.copyWith(subscribingAreaIds: updatedSubscribing));
          }
          
          // Notify subscription - this will trigger the listener to remove the area
          if (areaToSubscribe != null) {
            _notifier.notifySubscribed(areaToSubscribe);
          }
        },
        failure: (error) {
          debugPrint('Failed to subscribe to area: ${error.message}');
          final currentState = state;
          if (currentState is AllAreasStateLoaded) {
            final updatedSubscribing = Set<String>.from(
              currentState.subscribingAreaIds,
            )..remove(cityId);
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
      // Remove from subscribing list and show error
      final currentState = state;
      if (currentState is AllAreasStateLoaded) {
        final updatedSubscribing = Set<String>.from(
          currentState.subscribingAreaIds,
        )..remove(cityId);
        emit(
          currentState.copyWith(
            subscribingAreaIds: updatedSubscribing,
            operationError: 'Error subscribing to area: $e',
          ),
        );
      }
    }
  }

  bool isSubscribedToArea(String areaId) {
    return false;
  }

  bool isSubscribing(String areaId) {
    final currentState = state;
    if (currentState is AllAreasStateLoaded) {
      return currentState.subscribingAreaIds.contains(areaId);
    }
    return false;
  }

  void clearOperationError() {
    final currentState = state;
    if (currentState is AllAreasStateLoaded &&
        currentState.operationError != null) {
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
    if (isRefresh && !forceRefresh && _searchQuery.isEmpty && _isCacheValid()) {
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

    debugPrint(
      '🔄 Loading all areas: page $_currentPage, search "$_searchQuery"',
    );

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

  void _removeAreaFromState(String areaId) {
    final currentState = state;
    if (currentState is AllAreasStateLoaded) {
      final existingAreaIndex = currentState.areas.indexWhere(
        (area) => area.id == areaId,
      );

      if (existingAreaIndex != -1) {
        final updatedAreas =
            currentState.areas.where((a) => a.id != areaId).toList();
        final updatedSubscribing = Set<String>.from(
          currentState.subscribingAreaIds,
        )..remove(areaId);

        emit(
          currentState.copyWith(
            areas: updatedAreas,
            subscribingAreaIds: updatedSubscribing,
            operationError: null,
          ),
        );

        debugPrint('✅ Removed area $areaId from all areas state');
        debugPrint(
          '  Areas count: ${currentState.areas.length} → ${updatedAreas.length}',
        );
      } else {
        debugPrint('⚠️ Area $areaId not found in all areas state');
      }
    } else {
      debugPrint('⚠️ Cannot remove area - all areas state not loaded');
    }
  }

  void _removeAreaFromStateByInfo(AreaInfo areaInfo) {
    final currentState = state;
    if (currentState is AllAreasStateLoaded) {
      final existingAreaIndex = currentState.areas.indexWhere(
        (area) => area.id == areaInfo.id,
      );

      if (existingAreaIndex != -1) {
        final updatedAreas =
            currentState.areas.where((a) => a.id != areaInfo.id).toList();
        final updatedSubscribing = Set<String>.from(
          currentState.subscribingAreaIds,
        )..remove(areaInfo.id);

        emit(
          currentState.copyWith(
            areas: updatedAreas,
            subscribingAreaIds: updatedSubscribing,
            operationError: null,
          ),
        );

        debugPrint(
          '✅ Removed area ${areaInfo.name} (${areaInfo.id}) from all areas state',
        );
        debugPrint(
          '  Areas count: ${currentState.areas.length} → ${updatedAreas.length}',
        );
      } else {
        debugPrint(
          '⚠️ Area ${areaInfo.name} (${areaInfo.id}) not found in all areas state',
        );
      }
    } else {
      debugPrint('⚠️ Cannot remove area - all areas state not loaded');
    }
  }

  void _addAreaToState(AreaInfo newArea) {
    final currentState = state;
    if (currentState is AllAreasStateLoaded) {
      final existingAreaIndex = currentState.areas.indexWhere(
        (area) => area.id == newArea.id,
      );

      if (existingAreaIndex == -1) {
        final updatedAreas = [newArea, ...currentState.areas];
        emit(currentState.copyWith(areas: updatedAreas, operationError: null));
        debugPrint(
          '✅ Added area ${newArea.name} (${newArea.id}) to all areas state',
        );
        debugPrint(
          '  Areas count: ${currentState.areas.length} → ${updatedAreas.length}',
        );
      } else {
        debugPrint(
          '⚠️ Area ${newArea.name} (${newArea.id}) already exists in all areas state',
        );
      }
    } else {
      debugPrint('⚠️ Cannot add area - all areas state not loaded');
    }
  }

  @override
  Future<void> close() {
    _subscriptionListener?.cancel();
    return super.close();
  }
}
