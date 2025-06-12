import 'package:snapnfix/core/infrastructure/networking/error/api_error.dart';
import 'package:snapnfix/core/utils/result.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue.dart';
import 'package:snapnfix/modules/issues/domain/repositories/base_issue_repository.dart';

class GetUserIssuesUseCase {
  final BaseIssueRepository _repository;

  GetUserIssuesUseCase(this._repository);

  Future<Result<List<Issue>, ApiError>> call(String userId) {
    return _repository.getUserIssues(userId);
  }
}
