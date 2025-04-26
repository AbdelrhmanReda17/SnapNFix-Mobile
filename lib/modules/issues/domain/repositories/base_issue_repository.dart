import 'package:snapnfix/core/infrastructure/networking/api_result.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue.dart';

abstract class BaseIssueRepository {
  Future<ApiResult<List<Issue>>> getNearbyIssues(
    double latitude,
    double longitude,
    double radiusInKm,
  );

  Future<ApiResult<Issue>> getIssueDetails(String issueId);

  Stream<ApiResult<List<Issue>>> watchNearbyIssues(
    double latitude,
    double longitude,
    double radiusInKm,
  );

  Future<ApiResult<List<Issue>>> getUserIssues(String userId);
}
