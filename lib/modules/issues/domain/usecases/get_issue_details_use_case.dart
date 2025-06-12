import 'package:snapnfix/core/infrastructure/networking/error/api_error.dart';
import 'package:snapnfix/core/utils/result.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue.dart';
import 'package:snapnfix/modules/issues/domain/repositories/base_issue_repository.dart';

class GetIssueDetailsUseCase {
  final BaseIssueRepository _repository;

  GetIssueDetailsUseCase(this._repository);

  Future<Result<Issue, ApiError>> call(String issueId) {
    return _repository.getIssueDetails(issueId);
  }
}
