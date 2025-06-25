import 'package:snapnfix/core/infrastructure/networking/error/api_error.dart';
import 'package:snapnfix/core/utils/result.dart';
import 'package:snapnfix/modules/area_updates/domain/entities/area_info.dart';
import 'package:snapnfix/modules/area_updates/domain/repositories/base_area_updates_repository.dart';

class RefreshAreaDataUseCase {
  final BaseAreaUpdatesRepository _repository;

  RefreshAreaDataUseCase(this._repository);

    Future<Result<MapEntry<List<AreaInfo>, bool>, ApiError>> call() async {
    return await _repository.getAllAreas();
  }
}
