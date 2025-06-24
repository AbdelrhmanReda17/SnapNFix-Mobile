import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:snapnfix/modules/area_updates/domain/usecases/get_subscribed_areas_use_case.dart';
import 'package:snapnfix/modules/area_updates/domain/usecases/subscribe_to_area_use_case.dart';
import 'package:snapnfix/modules/area_updates/domain/usecases/unsubscribe_from_area_use_case.dart';
import 'package:snapnfix/modules/area_updates/domain/usecases/toggle_area_subscription_use_case.dart';
import 'package:snapnfix/modules/area_updates/domain/entities/area_info.dart';
import 'package:snapnfix/core/index.dart';
import 'area_subscription_state.dart';

class AreaSubscriptionCubit extends HydratedCubit<AreaSubscriptionState> {
  final GetSubscribedAreasUseCase _getSubscribedAreasUseCase;
  final SubscribeToAreaUseCase _subscribeToAreaUseCase;
  final UnsubscribeFromAreaUseCase _unsubscribeFromAreaUseCase;
  final ToggleAreaSubscriptionUseCase _toggleAreaSubscriptionUseCase;

  AreaSubscriptionCubit({
    required GetSubscribedAreasUseCase getSubscribedAreasUseCase,
    required SubscribeToAreaUseCase subscribeToAreaUseCase,
    required UnsubscribeFromAreaUseCase unsubscribeFromAreaUseCase,
    required ToggleAreaSubscriptionUseCase toggleAreaSubscriptionUseCase,
  }) : _getSubscribedAreasUseCase = getSubscribedAreasUseCase,
       _subscribeToAreaUseCase = subscribeToAreaUseCase,
       _unsubscribeFromAreaUseCase = unsubscribeFromAreaUseCase,
       _toggleAreaSubscriptionUseCase = toggleAreaSubscriptionUseCase,
       super(const AreaSubscriptionState.initial());
  @override
  String get id => 'AreaSubscriptionCubit_v3'; // Version change to clear old cache

  // Initialize with cached data
  void initialize() {
    state.maybeWhen(
      loaded: (_, __) {
        // Already have cached data
        return;
      },
      orElse: () {
        // Load from remote if no cached data
        fetchSubscribedAreas();
      },
    );
  }

  // Fetch subscribed areas from API
  Future<void> fetchSubscribedAreas({bool isRefresh = false}) async {
    try {
      state.maybeWhen(
        loaded: (subscribedAreas, _) {
          if (isRefresh) {
            emit(
              AreaSubscriptionState.loaded(
                subscribedAreas: subscribedAreas,
                isRefreshing: true,
              ),
            );
          }
        },
        orElse: () {
          emit(const AreaSubscriptionState.loading());
        },
      );

      final result = await _getSubscribedAreasUseCase.call();

      if (isClosed) return;      result.when(
        success: (areas) {
          print('🔥 DEBUG: Loaded ${areas.length} areas: ${areas.map((a) => '${a.cityName} (${a.activeIssuesCount})').join(', ')}');
          emit(
            AreaSubscriptionState.loaded(
              subscribedAreas: areas,
              isRefreshing: false,
            ),
          );
        },
        failure: (error) {
          final cachedAreas = _getCachedAreas();
          emit(
            AreaSubscriptionState.error(
              error: error,
              cachedAreas: cachedAreas,
            ),
          );
        },
      );
    } catch (e) {
      if (isClosed) return;
      final cachedAreas = _getCachedAreas();
      emit(
        AreaSubscriptionState.error(
          error: ApiError(message: 'An unexpected error occurred'),
          cachedAreas: cachedAreas,
        ),
      );
    }
  }

  // Subscribe to an area
  Future<void> subscribeToArea(String areaName) async {
    await state.maybeWhen(
      loaded: (subscribedAreas, isRefreshing) async {
        try {
          // Check if already subscribed
          if (subscribedAreas.any((area) => area.cityName == areaName)) {
            return;
          }

          final result = await _subscribeToAreaUseCase.call(areaName);

          if (isClosed) return;
          result.when(
            success: (_) {
              // Refresh to get updated list from server
              fetchSubscribedAreas();
            },
            failure: (error) {
              // You might want to show a snackbar or error message here
            },
          );
        } catch (e) {
          // Handle error
        }
      },
      orElse: () async {},
    );
  }

  // Unsubscribe from an area
  Future<void> unsubscribeFromArea(String areaName) async {
    await state.maybeWhen(
      loaded: (subscribedAreas, isRefreshing) async {
        try {
          final result = await _unsubscribeFromAreaUseCase.call(areaName);

          if (isClosed) return;
          result.when(
            success: (_) {
              // Refresh to get updated list from server
              fetchSubscribedAreas();
            },
            failure: (error) {
              // You might want to show a snackbar or error message here
            },
          );
        } catch (e) {
          // Handle error
        }
      },
      orElse: () async {},
    );
  }

  // Toggle subscription for an area
  Future<void> toggleAreaSubscription(String areaName) async {
    if (isSubscribedToArea(areaName)) {
      await unsubscribeFromArea(areaName);
    } else {
      await subscribeToArea(areaName);
    }
  }

  // Check if user is subscribed to an area
  bool isSubscribedToArea(String areaName) {
    return state.maybeWhen(      loaded: (subscribedAreas, _) => subscribedAreas.any((area) => area.cityName == areaName),
      error: (_, cachedAreas) => cachedAreas.any((area) => area.cityName == areaName),
      orElse: () => false,
    );
  }

  // Get subscribed areas count
  int get subscribedAreasCount {
    return state.maybeWhen(
      loaded: (subscribedAreas, _) => subscribedAreas.length,
      error: (_, cachedAreas) => cachedAreas.length,
      orElse: () => 0,
    );
  }  // Get current subscribed areas list
  List<AreaInfo> get subscribedAreas {
    return state.maybeWhen(
      loaded: (subscribedAreas, _) => subscribedAreas,
      error: (_, cachedAreas) => cachedAreas,
      orElse: () => <AreaInfo>[],
    );
  }

  // Refresh data
  Future<void> refresh() async {
    await fetchSubscribedAreas(isRefresh: true);
  }

  // Clear all subscriptions (for logout)
  void clearSubscriptions() {
    emit(const AreaSubscriptionState.initial());
  }

  // Get cached areas from current state
  List<AreaInfo> _getCachedAreas() {
    return state.maybeWhen(
      loaded: (subscribedAreas, _) => subscribedAreas,
      orElse: () => [],
    );
  }
  // Hydrated Bloc methods for persistence  @override
  AreaSubscriptionState? fromJson(Map<String, dynamic> json) {
    try {
      final subscribedAreasJson = json['subscribedAreas'] as List<dynamic>;
      if (subscribedAreasJson.isNotEmpty && subscribedAreasJson.first is String) {
        return null;
      }
      final subscribedAreas = subscribedAreasJson
          .map((areaJson) {
            if (areaJson is Map<String, dynamic>) {              return AreaInfo(
                cityId: areaJson['cityId'] ?? 0,
                cityName: areaJson['cityName'] ?? '',
                state: areaJson['state'] ?? '',
                activeIssuesCount: areaJson['activeIssuesCount'] ?? 0,
              );
            }
            return null;
          })
          .where((area) => area != null)
          .cast<AreaInfo>()
          .toList();
      
      return AreaSubscriptionState.loaded(
        subscribedAreas: subscribedAreas,
        isRefreshing: false,
      );
    } catch (e) {
      // Return null if deserialization fails, this will force a refresh from API
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(AreaSubscriptionState state) {
    return state.maybeWhen(
      loaded: (subscribedAreas, _) => {        'subscribedAreas': subscribedAreas
            .map((area) => {
                  'cityId': area.cityId,
                  'cityName': area.cityName,
                  'state': area.state,
                  'activeIssuesCount': area.activeIssuesCount,
                })
            .toList()
      },
      orElse: () => null, // Don't persist other states
    );
  }
}
