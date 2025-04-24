import 'package:geolocator/geolocator.dart';
import 'package:rxdart/rxdart.dart';
import 'package:snapnfix/core/infrastructure/location/location_service.dart';
import 'package:snapnfix/core/infrastructure/networking/api_error_handler.dart';
import 'package:snapnfix/core/infrastructure/networking/api_result.dart';
import 'package:snapnfix/core/infrastructure/networking/api_service.dart';
import 'package:snapnfix/modules/issues/data/models/issue_model.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_severity.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_status.dart';
import 'package:snapnfix/modules/reports/data/model/media_model.dart';
import 'package:snapnfix/modules/reports/data/model/report_model.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_severity.dart';

abstract class BaseIssueRemoteDataSource {
  Future<ApiResult<List<IssueModel>>> getNearbyIssues(
    double latitude,
    double longitude,
    double radiusInKm,
  );

  Future<ApiResult<IssueModel>> getIssueDetails(String issueId);

  Future<ApiResult<List<IssueModel>>> watchNearbyIssues(
    double latitude,
    double longitude,
    double radiusInKm,
  );

  Future<ApiResult<List<IssueModel>>> getUserIssues(String userId);
}

class IssueRemoteDataSource implements BaseIssueRemoteDataSource {
  final ApiService _apiService;

  IssueRemoteDataSource(this._apiService);
  @override
  Future<ApiResult<IssueModel>> getIssueDetails(String issueId) async {
    try {
      // Simulate a network call to fetch issue details
      // final response = await _apiService.getIssueDetails(issueId);
      // return ApiResult.success(response);
      return ApiResult.success(
        IssueModel(
          id: issueId,
          severity: IssueSeverity.low,
          latitude: 37.7749,
          longitude: -122.4194,
          category: "General",
          reports: [
            ReportModel(
              id: "report1",
              details: 'Sample report details',
              reportMedia: MediaModel(
                image:
                    "https://cdn.discordapp.com/attachments/1307817305253875754/1364715253669171262/9k.png?ex=680aad9f&is=68095c1f&hm=04fbf9612e854fee7b063a94602dd3674a49359b59a3ae923e65210eef2e2ebc&",
                category: "Test Category",
                threshold: 0.8,
              ),
              severity: ReportSeverity.low,
              timestamp: "2023-10-01T12:00:00Z",
              latitude: 37.7749,
              longitude: -122.4194,
            ),
          ],
          status: IssueStatus.pending,
          createdAt: DateTime.now(),
        ),
      );
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<List<IssueModel>>> getNearbyIssues(
    double latitude,
    double longitude,
    double radiusInKm,
  ) async {
    try {
      await Future.delayed(const Duration(milliseconds: 800));
      return ApiResult.success([
        IssueModel(
          id: "1",
          severity: IssueSeverity.low,
          latitude: 30.0083018 + 0.001,
          longitude: 31.3299946 + 0.001,
          category: "Road Damage",
          reports: [
            ReportModel(
              id: "report1",
              details: '1',
              reportMedia: MediaModel(
                image:
                    "https://cdn.discordapp.com/attachments/1307817305253875754/1364715253669171262/9k.png?ex=680aad9f&is=68095c1f&hm=04fbf9612e854fee7b063a94602dd3674a49359b59a3ae923e65210eef2e2ebc&",
                category: "Test Category",
                threshold: 0.8,
              ),
              severity: ReportSeverity.medium,
              timestamp: "2023-10-01T12:00:00Z",
              latitude: 30.008304 + 0.001,
              longitude: 31.3299911 + 0.001,
            ),
            ReportModel(
              id: "report1",
              details: 'Sample report details',
              reportMedia: MediaModel(
                image:
                    "https://cdn.discordapp.com/attachments/1307817305253875754/1364715253669171262/9k.png?ex=680aad9f&is=68095c1f&hm=04fbf9612e854fee7b063a94602dd3674a49359b59a3ae923e65210eef2e2ebc&",
                category: "Test Category",
                threshold: 0.8,
              ),
              severity: ReportSeverity.high,
              timestamp: "2023-10-01T12:00:00Z",
              latitude: 30.7749,
              longitude: -122.4194,
            ),
            ReportModel(
              id: "report1",
              details: 'Sample report details',
              reportMedia: MediaModel(
                image:
                    "https://cdn.discordapp.com/attachments/1307817305253875754/1364715253669171262/9k.png?ex=680aad9f&is=68095c1f&hm=04fbf9612e854fee7b063a94602dd3674a49359b59a3ae923e65210eef2e2ebc&",
                category: "Test Category",
                threshold: 0.8,
              ),
              severity: ReportSeverity.low,
              timestamp: "2023-10-01T12:00:00Z",
              latitude: 30.0083018,
              longitude: 31.3299946 - 0.21,
            ),
          ],
          status: IssueStatus.fixed,
          createdAt: DateTime.now(),
        ),
        IssueModel(
          id: "2",
          severity: IssueSeverity.low,
          latitude: 30.008308 + 0.08,
          longitude: 31.3299911 + 0.002,
          category: "Road Damage",
          reports: [
            ReportModel(
              id: "report1",
              details: 'Sample report details',
              reportMedia: MediaModel(
                image:
                    "https://cdn.discordapp.com/attachments/1307817305253875754/1364715253669171262/9k.png?ex=680aad9f&is=68095c1f&hm=04fbf9612e854fee7b063a94602dd3674a49359b59a3ae923e65210eef2e2ebc&",
                category: "Test Category",
                threshold: 0.8,
              ),
              severity: ReportSeverity.medium,
              timestamp: "2023-10-01T12:00:00Z",
              latitude: 37.7749,
              longitude: -122.4194,
            ),
            ReportModel(
              id: "report1",
              details: 'Sample report details',
              reportMedia: MediaModel(
                image:
                    "https://cdn.discordapp.com/attachments/1307817305253875754/1364715253669171262/9k.png?ex=680aad9f&is=68095c1f&hm=04fbf9612e854fee7b063a94602dd3674a49359b59a3ae923e65210eef2e2ebc&",
                category: "Test Category",
                threshold: 0.8,
              ),
              severity: ReportSeverity.high,
              timestamp: "2023-10-01T12:00:00Z",
              latitude: 37.7749,
              longitude: -122.4194,
            ),
            ReportModel(
              id: "report1",
              details: 'Sample report details',
              reportMedia: MediaModel(
                image: "http://example.com/image.jpg",
                category: "Test Category",
                threshold: 0.8,
              ),
              severity: ReportSeverity.low,
              timestamp: "2023-10-01T12:00:00Z",
              latitude: 30.0083018,
              longitude: 31.3299946 - 0.051,
            ),
          ],
          status: IssueStatus.inProgress,
          createdAt: DateTime.now(),
        ),
        IssueModel(
          id: "3",
          severity: IssueSeverity.high,
          latitude: 30.0083018 + 0.001,
          longitude: 31.3299911 + 0.002,
          category: "Road Damage",
          reports: [
            ReportModel(
              id: "report1",
              details: 'Sample report details',
              reportMedia: MediaModel(
                image:
                    "https://cdn.discordapp.com/attachments/1307817305253875754/1364715253669171262/9k.png?ex=680aad9f&is=68095c1f&hm=04fbf9612e854fee7b063a94602dd3674a49359b59a3ae923e65210eef2e2ebc&",
                category: "Test Category",
                threshold: 0.8,
              ),
              severity: ReportSeverity.medium,
              timestamp: "2023-10-01T12:00:00Z",
              latitude: 37.7749,
              longitude: -122.4194,
            ),
            ReportModel(
              id: "report1",
              details: 'Sample report details',
              reportMedia: MediaModel(
                image:
                    "https://cdn.discordapp.com/attachments/1307817305253875754/1364715253669171262/9k.png?ex=680aad9f&is=68095c1f&hm=04fbf9612e854fee7b063a94602dd3674a49359b59a3ae923e65210eef2e2ebc&",
                category: "Test Category",
                threshold: 0.8,
              ),
              severity: ReportSeverity.high,
              timestamp: "2023-10-01T12:00:00Z",
              latitude: 37.7749,
              longitude: -122.4194,
            ),
            ReportModel(
              id: "report1",
              details: 'Sample report details',
              reportMedia: MediaModel(
                image:
                    "https://cdn.discordapp.com/attachments/1307817305253875754/1364715253669171262/9k.png?ex=680aad9f&is=68095c1f&hm=04fbf9612e854fee7b063a94602dd3674a49359b59a3ae923e65210eef2e2ebc&",
                category: "Test Category",
                threshold: 0.8,
              ),
              severity: ReportSeverity.low,
              timestamp: "2023-10-01T12:00:00Z",
              latitude: 37.7749,
              longitude: -122.4194,
            ),
          ],
          status: IssueStatus.pending,
          createdAt: DateTime.now(),
        ),
        IssueModel(
          id: "4",
          severity: IssueSeverity.medium,
          latitude: 30.0083018 + 0.001,
          longitude: 31 - 0.002,
          category: "Lighting",
          reports: [
            ReportModel(
              id: "report1",
              details: 'Sample report details',
              reportMedia: MediaModel(
                image:
                    "https://cdn.discordapp.com/attachments/1307817305253875754/1364717491158388788/9k.png?ex=680aafb5&is=68095e35&hm=7f3ece1abb0d1dc092cdcbbb9e771446b55b7888e402961686176d805d6d7df4&",
                category: "Lighting",
                threshold: 0.8,
              ),
              severity: ReportSeverity.low,
              timestamp: "2023-10-01T12:00:00Z",
              latitude: 37.7749,
              longitude: -122.4194,
            ),
            ReportModel(
              id: "report1",
              details: 'Sample report details',
              reportMedia: MediaModel(
                image:
                    "https://cdn.discordapp.com/attachments/1307817305253875754/1364717491158388788/9k.png?ex=680aafb5&is=68095e35&hm=7f3ece1abb0d1dc092cdcbbb9e771446b55b7888e402961686176d805d6d7df4&",
                category: "Test Category",
                threshold: 0.8,
              ),
              severity: ReportSeverity.low,
              timestamp: "2023-10-01T12:00:00Z",
              latitude: 37.7749,
              longitude: -122.4194,
            ),
            ReportModel(
              id: "report1",
              details: 'Sample report details',
              reportMedia: MediaModel(
                image:
                    "https://cdn.discordapp.com/attachments/1307817305253875754/1364717491158388788/9k.png?ex=680aafb5&is=68095e35&hm=7f3ece1abb0d1dc092cdcbbb9e771446b55b7888e402961686176d805d6d7df4&",
                category: "Test Category",
                threshold: 0.8,
              ),
              severity: ReportSeverity.low,
              timestamp: "2023-10-01T12:00:00Z",
              latitude: 37.7749,
              longitude: -122.4194,
            ),
          ],
          status: IssueStatus.inProgress,
          createdAt: DateTime.now(),
        ),
      ]);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<List<IssueModel>>> getUserIssues(String userId) async {
    try {
      // Simulate a network call to fetch user issues
      // final response = await _apiService.getUserIssues(userId);
      // return ApiResult.success(response);
      return ApiResult.success([]); // Replace with actual data
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<List<IssueModel>>> watchNearbyIssues(
    double latitude,
    double longitude,
    double radiusInKm,
  ) async {
    try {
      final result = await getNearbyIssues(latitude, longitude, radiusInKm);
      return result.when(
        success: (issues) {
          return ApiResult.success(issues);
        },
        failure: (error) {
          return ApiResult.failure(error);
        },
      );
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
