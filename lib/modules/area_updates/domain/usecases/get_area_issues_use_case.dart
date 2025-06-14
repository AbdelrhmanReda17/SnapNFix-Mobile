import 'package:snapnfix/core/infrastructure/networking/error/api_error.dart';
import 'package:snapnfix/core/utils/result.dart';
import 'package:snapnfix/modules/area_updates/domain/repositories/base_area_updates_repository.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue.dart';

class GetAreaIssuesUseCase {
  final BaseAreaUpdatesRepository _repository;

  GetAreaIssuesUseCase(this._repository);

  Future<Result<List<Issue>, ApiError>> call({
    required String areaName,
    int page = 1,
    int limit = 20,
  }) async {
    return await _repository.getAreaIssues(areaName, page: page, limit: limit);
  }
}
