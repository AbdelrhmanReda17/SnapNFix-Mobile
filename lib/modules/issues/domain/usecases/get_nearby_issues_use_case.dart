import 'package:snapnfix/core/infrastructure/networking/api_result.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue.dart';
import 'package:snapnfix/modules/issues/domain/repositories/base_issue_repository.dart';

class GetNearbyIssuesUseCase {
  final BaseIssueRepository _repository;

  GetNearbyIssuesUseCase(this._repository);

  Future<ApiResult<List<Issue>>> call(
    double latitude,
    double longitude, {
    double radius = 1.0,
  }) {
    return _repository.getNearbyIssues(latitude, longitude, radius);
  }
}
