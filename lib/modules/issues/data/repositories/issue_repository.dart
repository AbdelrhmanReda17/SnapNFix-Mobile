import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:snapnfix/modules/issues/data/datasource/issue_local_data_source.dart';
import 'package:snapnfix/modules/issues/data/datasource/issue_remote_data_source.dart';
import 'package:snapnfix/modules/issues/data/models/issue_model.dart';
import 'package:snapnfix/modules/issues/data/models/markers.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue.dart';
import 'package:snapnfix/modules/issues/domain/repositories/base_issue_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:geolocator/geolocator.dart';

import 'package:snapnfix/core/index.dart';

class IssueRepository implements BaseIssueRepository {
  final BaseIssueRemoteDataSource remoteDataSource;
  final BaseIssueLocalDataSource localDataSource;
  final LocationService locationService;

  static const _minDistanceChange = 100.0; // 100 meters
  static const _periodicUpdateInterval = Duration(minutes: 2);

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
  Future<Result<List<IssueMarker>, ApiError>> getNearbyIssues(
    double latitude,
    double longitude,
    double radiusInKm, {
    LatLngBounds? bounds,
    int? maxResults,
  }) async {
    final remoteResult = await remoteDataSource.getNearbyIssues(
      latitude,
      longitude,
      radiusInKm,
      bounds: bounds,
      maxResults: maxResults ?? _getDefaultMaxResults(radiusInKm),
    );

    return await remoteResult.when(
      success: (issues) async {
        // Cache the full issue data if available
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
        // Fallback to cache
        final cachedIssues = await localDataSource.getNearbyIssues(
          latitude,
          longitude,
          radiusInKm,
        );

        if (cachedIssues.isNotEmpty) {
          return Result.success(cachedIssues);
        }
        return Result.failure(error);
      },
    );
  }

  @override
  Stream<Result<List<IssueMarker>, ApiError>> watchNearbyIssues(
    double latitude,
    double longitude,
    double radiusInKm, {
    int? maxResults,
  }) async* {
    try {
      // Initial fetch
      yield await getNearbyIssues(
        latitude,
        longitude,
        radiusInKm,
        maxResults: maxResults,
      );

      Position? lastPosition;
      final periodicStream = Stream.periodic(_periodicUpdateInterval);
      final locationStream = locationService.onLocationChanged();

      await for (final trigger in Rx.merge([periodicStream, locationStream])) {
        Position currentPosition;

        if (trigger is Position) {
          currentPosition = trigger;

          // Skip if movement is too small
          if (lastPosition != null) {
            final distance = Geolocator.distanceBetween(
              lastPosition.latitude,
              lastPosition.longitude,
              currentPosition.latitude,
              currentPosition.longitude,
            );

            if (distance < _minDistanceChange) continue;
          }
        } else {
          // Periodic update
          currentPosition = await locationService.getCurrentPosition();
        }

        lastPosition = currentPosition;

        final result = await getNearbyIssues(
          currentPosition.latitude,
          currentPosition.longitude,
          radiusInKm,
          maxResults: maxResults,
        );

        yield result;
      }
    } catch (error) {
      yield Result<List<IssueMarker>, ApiError>.failure(
        error is ApiError ? error : ApiError(message: error.toString()),
      );
    }
  }

  int _getDefaultMaxResults(double radiusInKm) {
    // Dynamic max results based on radius
    if (radiusInKm <= 0.5) return 20;
    if (radiusInKm <= 1.0) return 50;
    if (radiusInKm <= 2.0) return 100;
    return 200;
  }
}
