import 'package:snapnfix/core/infrastructure/networking/error/api_error.dart';
import 'package:snapnfix/core/utils/result.dart';
import 'package:snapnfix/modules/issues/data/models/markers.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class BaseIssueRepository {
  Future<Result<List<IssueMarker>, ApiError>> getNearbyIssues({
    required LatLngBounds bounds,
    required int maxResults,
  });
  Future<Result<Issue, ApiError>> getIssueDetails(String issueId);
  Future<Result<List<Issue>, ApiError>> getUserIssues(String userId);
}
