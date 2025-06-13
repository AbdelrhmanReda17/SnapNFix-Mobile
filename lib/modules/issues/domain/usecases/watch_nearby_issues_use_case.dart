import 'package:snapnfix/core/infrastructure/networking/error/api_error.dart';
import 'package:snapnfix/core/utils/result.dart';
import 'package:snapnfix/modules/issues/data/models/markers.dart';
import 'package:snapnfix/modules/issues/domain/repositories/base_issue_repository.dart';

class WatchNearbyIssuesUseCase {
  final BaseIssueRepository _repository;

  WatchNearbyIssuesUseCase(this._repository);

  Stream<Result<List<IssueMarker>, ApiError>> call(
    double latitude,
    double longitude, {
    double radius = 0.3,
    int? maxResults,
  }) {
    return _repository.watchNearbyIssues(
      latitude,
      longitude,
      radius,
      maxResults: maxResults,
    );
  }
}
