import 'package:snapnfix/core/infrastructure/location/location_service.dart';
import 'package:snapnfix/core/infrastructure/networking/api_error_handler.dart';
import 'package:snapnfix/core/infrastructure/networking/api_result.dart';
import 'package:snapnfix/modules/issues/data/datasource/issue_local_data_source.dart';
import 'package:snapnfix/modules/issues/data/datasource/issue_remote_data_source.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue.dart';
import 'package:snapnfix/modules/issues/domain/repositories/base_issue_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:geolocator/geolocator.dart';

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
  Future<ApiResult<Issue>> getIssueDetails(String issueId) async {
    try {
      final remoteResult = await remoteDataSource.getIssueDetails(issueId);

      return await remoteResult.when(
        success: (issue) async {
          await localDataSource.cacheIssue(issue);
          return ApiResult.success(issue);
        },
        failure: (error) async {
          final cachedIssue = await localDataSource.getIssueById(issueId);
          if (cachedIssue != null) {
            return ApiResult.success(cachedIssue);
          }
          return ApiResult.failure(error);
        },
      );
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<List<Issue>>> getNearbyIssues(
    double latitude,
    double longitude,
    double radiusInKm,
  ) async {
    try {
      final remoteResult = await remoteDataSource.getNearbyIssues(
        latitude,
        longitude,
        radiusInKm,
      );

      return await remoteResult.when(
        success: (issues) async {
          await localDataSource.cacheIssues(issues);
          return ApiResult.success(issues as List<Issue>);
        },
        failure: (error) async {
          final cachedIssues = await localDataSource.getNearbyIssues(
            latitude,
            longitude,
            radiusInKm,
          );

          if (cachedIssues.isNotEmpty) {
            return ApiResult.success(cachedIssues as List<Issue>);
          }
          return ApiResult.failure(error);
        },
      );
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<List<Issue>>> getUserIssues(String userId) async {
    try {
      final remoteResult = await remoteDataSource.getUserIssues(userId);

      return await remoteResult.when(
        success: (issues) async {
          await localDataSource.cacheIssues(issues);
          return ApiResult.success(issues as List<Issue>);
        },
        failure: (error) async {
          final cachedIssues = await localDataSource.searchIssues(userId);

          if (cachedIssues.isNotEmpty) {
            return ApiResult.success(cachedIssues as List<Issue>);
          }
          return ApiResult.failure(error);
        },
      );
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  @override
  Stream<ApiResult<List<Issue>>> watchNearbyIssues(
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
            await localDataSource.cacheIssues(issues);
            return ApiResult<List<Issue>>.success(issues as List<Issue>);
          },
          failure: (error) async {
            final cachedIssues = await localDataSource.getNearbyIssues(
              currentPosition.latitude,
              currentPosition.longitude,
              radiusInKm,
            );

            if (cachedIssues.isNotEmpty) {
              return ApiResult<List<Issue>>.success(
                cachedIssues as List<Issue>,
              );
            }
            return ApiResult<List<Issue>>.failure(error);
          },
        );

        yield outputResult;
      }
    } catch (error) {
      yield ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
