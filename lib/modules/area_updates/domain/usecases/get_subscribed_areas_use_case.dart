import 'package:snapnfix/core/infrastructure/networking/error/api_error.dart';
import 'package:snapnfix/core/utils/result.dart';
import 'package:snapnfix/modules/area_updates/domain/repositories/base_area_updates_repository.dart';

class GetSubscribedAreasUseCase {
  final BaseAreaUpdatesRepository _repository;

  GetSubscribedAreasUseCase(this._repository);

  Future<Result<List<String>, ApiError>> call() async {
    return await _repository.getSubscribedAreas();
  }
}
