import 'package:snapnfix/core/infrastructure/networking/error/api_error.dart';
import 'package:snapnfix/core/utils/result.dart';
import 'package:snapnfix/modules/issues/data/models/markers.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue.dart';

abstract class BaseIssueRepository {
  Future<Result<List<Marker>, ApiError>> getNearbyIssues(
    double latitude,
    double longitude,
    double radiusInKm,
  );
  Stream<Result<List<Marker>, ApiError>> watchNearbyIssues(
    double latitude,
    double longitude,
    double radiusInKm,
  );
  Future<Result<Issue, ApiError>> getIssueDetails(String issueId);
  Future<Result<List<Issue>, ApiError>> getUserIssues(String userId);
}
