import 'package:snapnfix/core/infrastructure/networking/error/api_error.dart';
import 'package:snapnfix/core/utils/result.dart';
import 'package:snapnfix/modules/area_updates/domain/entities/area_issue.dart';
import 'package:snapnfix/modules/area_updates/domain/repositories/base_area_updates_repository.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_status.dart';

class GetAreaSpecificIssuesUseCase {
  final BaseAreaUpdatesRepository _repository;

  GetAreaSpecificIssuesUseCase(this._repository);

  Future<Result<MapEntry<List<AreaIssue>, bool>, ApiError>> call({
    required String areaId,
    IssueStatus? status,
    int page = 1,
    int limit = 20,
  }) async {
    return await _repository.getAreaIssues(
      areaId,
      status: status,
      page: page,
      limit: limit,
    );
  }
}
