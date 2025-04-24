import 'package:snapnfix/core/infrastructure/networking/api_result.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue.dart';
import 'package:snapnfix/modules/issues/domain/repositories/base_issue_repository.dart';

class GetUserIssuesUseCase {
  final BaseIssueRepository _repository;

  GetUserIssuesUseCase(this._repository);

  Future<ApiResult<List<Issue>>> call(String userId) {
    return _repository.getUserIssues(userId);
  }
}
