import 'package:snapnfix/core/infrastructure/networking/error/api_error.dart';
import 'package:snapnfix/core/utils/result.dart';
import 'package:snapnfix/modules/area_updates/domain/entities/area_info.dart';
import 'package:snapnfix/modules/area_updates/domain/repositories/base_area_updates_repository.dart';

class GetAllAreasUseCase {
  final BaseAreaUpdatesRepository _repository;

  GetAllAreasUseCase(this._repository);

  Future<Result<MapEntry<List<AreaInfo>, bool>, ApiError>> call({
    int page = 1,
    int limit = 10,
    String? searchTerm,
  }) async {
    return await _repository.getAllAreas(
      page: page,
      limit: limit,
      searchTerm: searchTerm,
    );
  }
}
