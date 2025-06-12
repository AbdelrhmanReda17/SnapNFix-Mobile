import 'package:snapnfix/core/infrastructure/networking/error/api_error.dart';
import 'package:snapnfix/core/utils/result.dart';
import 'package:snapnfix/modules/issues/data/models/markers.dart';
import 'package:snapnfix/modules/issues/domain/repositories/base_issue_repository.dart';

class GetNearbyIssuesUseCase {
  final BaseIssueRepository _repository;

  GetNearbyIssuesUseCase(this._repository);

  Future<Result<List<Marker>, ApiError>> call(
    double latitude,
    double longitude, {
    double radius = 1.0,
  }) {
    return _repository.getNearbyIssues(latitude, longitude, radius);
  }
}
