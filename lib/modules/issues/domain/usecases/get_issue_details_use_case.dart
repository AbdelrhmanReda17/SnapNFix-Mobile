import 'package:snapnfix/core/infrastructure/networking/api_result.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue.dart';
import 'package:snapnfix/modules/issues/domain/repositories/base_issue_repository.dart';

class GetIssueDetailsUseCase {
  final BaseIssueRepository _repository;

  GetIssueDetailsUseCase(this._repository);

  Future<ApiResult<Issue>> call(String issueId) {
    return _repository.getIssueDetails(issueId);
  }
}
