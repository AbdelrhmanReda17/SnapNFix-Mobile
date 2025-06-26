import 'package:snapnfix/core/infrastructure/networking/error/api_error.dart';
import 'package:snapnfix/core/utils/result.dart';
import 'package:snapnfix/modules/area_updates/domain/repositories/base_area_updates_repository.dart';

class ToggleAreaSubscriptionUseCase {
  final BaseAreaUpdatesRepository _repository;

  ToggleAreaSubscriptionUseCase(this._repository);

  Future<Result<bool, ApiError>> call(String areaId, bool isSubscribed) async {
    if (isSubscribed) {
      final result = await _repository.unsubscribeFromArea(areaId);
      return result.when(
        success: (_) => Result.success(true),
        failure: (error) => Result.failure(error),
      );
    } else {
      final result = await _repository.subscribeToArea(areaId);
      return result.when(
        success: (_) => Result.success(true),
        failure: (error) => Result.failure(error),
      );
    }
  }
}
