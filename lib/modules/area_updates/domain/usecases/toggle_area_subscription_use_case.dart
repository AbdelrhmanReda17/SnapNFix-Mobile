import 'package:snapnfix/core/infrastructure/networking/error/api_error.dart';
import 'package:snapnfix/core/utils/result.dart';
import 'package:snapnfix/modules/area_updates/domain/repositories/base_area_updates_repository.dart';

class ToggleAreaSubscriptionUseCase {
  final BaseAreaUpdatesRepository _repository;

  ToggleAreaSubscriptionUseCase(this._repository);

  Future<Result<bool, ApiError>> call(String areaName) async {
    if (areaName.trim().isEmpty) {
      return Result.failure(ApiError(message: 'Area name cannot be empty'));
    }

    // First get current subscriptions to check if already subscribed
    final subscriptionsResult = await _repository.getSubscribedAreas();

    return subscriptionsResult.when(
      success: (subscribedAreas) async {
        final isCurrentlySubscribed = subscribedAreas.key.contains(areaName);

        if (isCurrentlySubscribed) {
          // Unsubscribe
          final unsubscribeResult = await _repository.unsubscribeFromArea(
            areaName,
          );
          return unsubscribeResult.when(
            success: (_) => Result.success(false), // false = unsubscribed
            failure: (error) => Result.failure(error),
          );
        } else {
          // Subscribe
          final subscribeResult = await _repository.subscribeToArea(areaName);
          return subscribeResult.when(
            success: (_) => Result.success(true), // true = subscribed
            failure: (error) => Result.failure(error),
          );
        }
      },
      failure: (error) => Result.failure(error),
    );
  }
}
