import 'package:snapnfix/core/infrastructure/networking/error/api_error.dart';
import 'package:snapnfix/core/utils/result.dart';
import 'package:snapnfix/modules/area_updates/domain/repositories/base_area_updates_repository.dart';

class SubscribeToAreaUseCase {
  final BaseAreaUpdatesRepository _repository;

  SubscribeToAreaUseCase(this._repository);

  Future<Result<void, ApiError>> call(String areaName) async {
    return await _repository.subscribeToArea(areaName);
  }
}
