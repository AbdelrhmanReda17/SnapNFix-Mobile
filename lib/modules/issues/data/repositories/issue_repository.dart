import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:snapnfix/modules/issues/data/datasource/issue_local_data_source.dart';
import 'package:snapnfix/modules/issues/data/datasource/issue_remote_data_source.dart';
import 'package:snapnfix/modules/issues/data/models/issue_model.dart';
import 'package:snapnfix/modules/issues/data/models/markers.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue.dart';
import 'package:snapnfix/modules/issues/domain/repositories/base_issue_repository.dart';
import 'package:snapnfix/core/index.dart';

class IssueRepository implements BaseIssueRepository {
  final BaseIssueRemoteDataSource remoteDataSource;
  final BaseIssueLocalDataSource localDataSource;
  final LocationService locationService;

  IssueRepository({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.locationService,
  });

  @override
  Future<Result<Issue, ApiError>> getIssueDetails(String issueId) async {
    // Check fresh cache first
    final isFresh = await localDataSource.isIssueFresh(issueId);
    if (isFresh) {
      final cachedIssue = await localDataSource.getIssueById(issueId);
      if (cachedIssue != null) {
        return Result.success(cachedIssue);
      }
    }

    // Fetch from remote
    final remoteResult = await remoteDataSource.getIssueDetails(issueId);
    return await remoteResult.when(
      success: (issue) async {
        await localDataSource.cacheIssue(issue);
        return Result.success(issue);
      },
      failure: (error) async {
        // Fallback to stale cache
        final cachedIssue = await localDataSource.getIssueById(issueId);
        if (cachedIssue != null) {
          return Result.success(cachedIssue);
        }
        return Result.failure(error);
      },
    );
  }

  @override
  Future<Result<List<Issue>, ApiError>> getUserIssues(String userId) async {
    final remoteResult = await remoteDataSource.getUserIssues(userId);
    return await remoteResult.when(
      success: (issues) async {
        await localDataSource.cacheIssues(issues);
        return Result.success(issues as List<Issue>);
      },
      failure: (error) async {
        final cachedIssues = await localDataSource.searchIssues(userId);
        if (cachedIssues.isNotEmpty) {
          return Result.success(cachedIssues as List<Issue>);
        }
        return Result.failure(error);
      },
    );
  }

  @override
  Future<Result<List<IssueMarker>, ApiError>> getNearbyIssues({
    required LatLngBounds bounds,
    required int maxResults,
  }) async {
    final remoteResult = await remoteDataSource.getNearbyIssues(
      bounds: bounds,
      maxResults: maxResults,
    );

    return await remoteResult.when(
      success: (issues) async {
        final fullIssues = <IssueModel>[];
        for (final marker in issues) {
          final cached = await localDataSource.getIssueById(marker.issueId);
          if (cached != null) fullIssues.add(cached);
        }
        if (fullIssues.isNotEmpty) {
          await localDataSource.cacheIssues(fullIssues);
        }
        return Result.success(issues);
      },
      failure: (error) async {
        final cachedIssues = await localDataSource.getNearbyIssues(
          bounds: bounds,
          maxResults: maxResults,
        );

        if (cachedIssues.isNotEmpty) {
          return Result.success(cachedIssues);
        }
        return Result.failure(error);
      },
    );
  }
}
