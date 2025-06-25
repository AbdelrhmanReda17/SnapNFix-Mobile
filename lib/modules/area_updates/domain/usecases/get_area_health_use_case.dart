import 'package:snapnfix/core/infrastructure/networking/error/api_error.dart';
import 'package:snapnfix/core/utils/result.dart';
import 'package:snapnfix/modules/area_updates/domain/entities/area_health_metrics.dart';
import 'package:snapnfix/modules/area_updates/domain/repositories/base_area_updates_repository.dart';

class GetAreaHealthUseCase {
  final BaseAreaUpdatesRepository _repository;

  GetAreaHealthUseCase(this._repository);

  Future<Result<AreaHealthMetrics, ApiError>> call(String areaName) async {
    return await _repository.getAreaHealth(areaName);
  }
}
