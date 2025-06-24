import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:snapnfix/core/infrastructure/networking/error/api_error.dart';
import 'package:snapnfix/core/utils/result.dart';
import 'package:snapnfix/modules/issues/data/models/markers.dart';
import 'package:snapnfix/modules/issues/domain/repositories/base_issue_repository.dart';

class GetNearbyIssuesUseCase {
  final BaseIssueRepository _repository;

  GetNearbyIssuesUseCase(this._repository);

  Future<Result<List<IssueMarker>, ApiError>> call({
    required LatLngBounds bounds,
    int maxResults = 100,
  }) {
      return _repository.getNearbyIssues(
        bounds: bounds,
        maxResults: maxResults,
      );
  }
}
