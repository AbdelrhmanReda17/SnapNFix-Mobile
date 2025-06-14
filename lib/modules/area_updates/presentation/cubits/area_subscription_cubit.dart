import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:snapnfix/modules/area_updates/domain/repositories/base_area_updates_repository.dart';
import 'area_subscription_state.dart';

class AreaSubscriptionCubit extends HydratedCubit<AreaSubscriptionState> {
  final BaseAreaUpdatesRepository _repository;

  AreaSubscriptionCubit(this._repository)
    : super(const AreaSubscriptionState.initial());

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

    final result = await _repository.getSubscribedAreas();

    result.when(
      success: (areas) {
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
            message: error.message,
            cachedAreas: cachedAreas,
          ),
        );
      },
    );
  }

  // Subscribe to an area
  Future<void> subscribeToArea(String areaName) async {
    await state.maybeWhen(
      loaded: (subscribedAreas, isRefreshing) async {
        // Optimistic update
        final updatedAreas = [...subscribedAreas, areaName];
        emit(
          AreaSubscriptionState.loaded(
            subscribedAreas: updatedAreas,
            isRefreshing: isRefreshing,
          ),
        );

        final result = await _repository.subscribeToArea(areaName);

        result.when(
          success: (_) {
            // Keep the optimistic update
          },
          failure: (error) {
            // Revert optimistic update
            emit(
              AreaSubscriptionState.loaded(
                subscribedAreas: subscribedAreas,
                isRefreshing: isRefreshing,
              ),
            );
            // You might want to show a snackbar or error message here
          },
        );
      },
      orElse: () async {},
    );
  }

  // Unsubscribe from an area
  Future<void> unsubscribeFromArea(String areaName) async {
    await state.maybeWhen(
      loaded: (subscribedAreas, isRefreshing) async {
        // Optimistic update
        final updatedAreas =
            subscribedAreas.where((area) => area != areaName).toList();
        emit(
          AreaSubscriptionState.loaded(
            subscribedAreas: updatedAreas,
            isRefreshing: isRefreshing,
          ),
        );

        final result = await _repository.unsubscribeFromArea(areaName);

        result.when(
          success: (_) {
            // Keep the optimistic update
          },
          failure: (error) {
            // Revert optimistic update
            emit(
              AreaSubscriptionState.loaded(
                subscribedAreas: subscribedAreas,
                isRefreshing: isRefreshing,
              ),
            );
            // You might want to show a snackbar or error message here
          },
        );
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
    return state.maybeWhen(
      loaded: (subscribedAreas, _) => subscribedAreas.contains(areaName),
      error: (_, cachedAreas) => cachedAreas.contains(areaName),
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
  }

  // Get current subscribed areas list
  List<String> get subscribedAreas {
    return state.maybeWhen(
      loaded: (subscribedAreas, _) => subscribedAreas,
      error: (_, cachedAreas) => cachedAreas,
      orElse: () => [],
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
  List<String> _getCachedAreas() {
    return state.maybeWhen(
      loaded: (subscribedAreas, _) => subscribedAreas,
      orElse: () => [],
    );
  }

  // Hydrated Bloc methods for persistence
  @override
  AreaSubscriptionState? fromJson(Map<String, dynamic> json) {
    try {
      final subscribedAreas =
          (json['subscribedAreas'] as List<dynamic>).cast<String>();
      return AreaSubscriptionState.loaded(
        subscribedAreas: subscribedAreas,
        isRefreshing: false,
      );
    } catch (e) {
      // Return null if deserialization fails
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(AreaSubscriptionState state) {
    return state.maybeWhen(
      loaded: (subscribedAreas, _) => {'subscribedAreas': subscribedAreas},
      orElse: () => null, // Don't persist other states
    );
  }
}
