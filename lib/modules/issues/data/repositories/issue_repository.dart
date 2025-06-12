import 'package:snapnfix/modules/issues/data/datasource/issue_local_data_source.dart';
import 'package:snapnfix/modules/issues/data/datasource/issue_remote_data_source.dart';
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

  IssueRepository({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.locationService,
  });

  @override
  Future<Result<Issue, ApiError>> getIssueDetails(String issueId) async {
    final remoteResult = await remoteDataSource.getIssueDetails(issueId);
    return await remoteResult.when(
      success: (issue) async {
        await localDataSource.cacheIssue(issue);
        return Result.success(issue);
      },
      failure: (error) async {
        final cachedIssue = await localDataSource.getIssueById(issueId);
        if (cachedIssue != null) {
          return Result.success(cachedIssue);
        }
        return Result.failure(error);
      },
    );
  }

  @override
  Future<Result<List<IssueMarker>, ApiError>> getNearbyIssues(
    double latitude,
    double longitude,
    double radiusInKm,
  ) async {
    final remoteResult = await remoteDataSource.getNearbyIssues(
      latitude,
      longitude,
      radiusInKm,
    );

    return await remoteResult.when(
      success: (issues) async {
        // await localDataSource.cacheIssues(issues);
        return Result.success(issues);
      },
      failure: (error) async {
        // final cachedIssues = await localDataSource.getNearbyIssues(
        //   latitude,
        //   longitude,
        //   radiusInKm,
        // );

        // if (cachedIssues.isNotEmpty) {
        //   return Result.success(cachedIssues);
        // }
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
  Stream<Result<List<IssueMarker>, ApiError>> watchNearbyIssues(
    double latitude,
    double longitude,
    double radiusInKm,
  ) async* {
    try {
      // Initial fetch
      yield await getNearbyIssues(latitude, longitude, radiusInKm);

      Position? lastPosition;
      final periodicStream = Stream.periodic(const Duration(minutes: 2));
      final locationStream = locationService.onLocationChanged();

      await for (final trigger in Rx.merge([periodicStream, locationStream])) {
        Position currentPosition;

        if (trigger is Position) {
          // Location update
          currentPosition = trigger;

          // Check if we've moved enough
          if (lastPosition != null) {
            final distance = Geolocator.distanceBetween(
              lastPosition.latitude,
              lastPosition.longitude,
              currentPosition.latitude,
              currentPosition.longitude,
            );

            if (distance < _minDistanceChange) {
              continue; // Skip if haven't moved enough
            }
          }
        } else {
          // Periodic update
          currentPosition = await locationService.getCurrentPosition();
        }

        lastPosition = currentPosition;

        final result = await remoteDataSource.getNearbyIssues(
          currentPosition.latitude,
          currentPosition.longitude,
          radiusInKm,
        );

        final outputResult = await result.when(
          success: (issues) async {
            // await localDataSource.cacheIssues(issues);
            return Result<List<IssueMarker>, ApiError>.success(issues);
          },
          failure: (error) async {
            final cachedIssues = await localDataSource.getNearbyIssues(
              currentPosition.latitude,
              currentPosition.longitude,
              radiusInKm,
            );

            if (cachedIssues.isNotEmpty) {
              return Result<List<IssueMarker>, ApiError>.success(
                cachedIssues as List<IssueMarker>,
              );
            }
            return Result<List<IssueMarker>, ApiError>.failure(error);
          },
        );

        yield outputResult;
      }
    } catch (error) {
      yield Result<List<IssueMarker>, ApiError>.failure(
        error is ApiError ? error : ApiError(message: error.toString()),
      );
    }
  }
}
