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
                    "data:image/jpeg;base64,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",
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
