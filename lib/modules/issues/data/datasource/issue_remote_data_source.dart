import 'package:snapnfix/core/infrastructure/networking/api_error_handler.dart';
import 'package:snapnfix/core/infrastructure/networking/api_result.dart';
import 'package:snapnfix/core/infrastructure/networking/api_service.dart';
import 'package:snapnfix/modules/issues/data/models/issue_model.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_category.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_severity.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_status.dart';
import 'package:snapnfix/modules/reports/data/model/report_model.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_severity.dart';

abstract class BaseIssueRemoteDataSource {
  Future<ApiResult<List<IssueModel>>> getNearbyIssues(
    double latitude,
    double longitude,
    double radiusInKm,
  );

  Future<ApiResult<IssueModel>> getIssueDetails(String issueId);

  Future<ApiResult<List<IssueModel>>> getUserIssues(String userId);

  Future<ApiResult<List<IssueModel>>> watchNearbyIssues(
    double latitude,
    double longitude,
    double radiusInKm,
  );
}

class IssueRemoteDataSource implements BaseIssueRemoteDataSource {
  // TODO: Use _apiService when implementing actual API calls
  final ApiService _apiService;

  IssueRemoteDataSource(this._apiService);

  @override
  Future<ApiResult<IssueModel>> getIssueDetails(String issueId) async {
    try {
      // Simulate a network call to fetch issue details
      return ApiResult.success(
        IssueModel(
          id: issueId,
          severity: IssueSeverity.low,
          latitude: 37.7749,
          longitude: -122.4194,
          category: IssueCategory.manhole,
          reports: [
            ReportModel(
              id: "report1",
              issueId: issueId,
              details: 'Sample report details',
              image: "https://cdn.discordapp.com/attachments/1307817305253875754/1364715253669171262/9k.png",
              category: "Test Category",
              threshold: 0.8,
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
          latitude: latitude + 0.001,
          longitude: longitude + 0.001,
          category: IssueCategory.roadDamage,
          reports: [
            ReportModel(
              id: "report1",
              issueId: "1",
              details: 'Sample report details',
              image: "https://cdn.discordapp.com/attachments/1307817305253875754/1364715253669171262/9k.png",
              category: "Test Category",
              threshold: 0.8,
              severity: ReportSeverity.medium,
              timestamp: "2023-10-01T12:00:00Z",
              latitude: latitude + 0.001,
              longitude: longitude + 0.001,
            ),
          ],
          status: IssueStatus.fixed,
          createdAt: DateTime.now(),
        ),
        IssueModel(
          id: "2",
          severity: IssueSeverity.medium,
          latitude: latitude + 0.08,
          longitude: longitude + 0.002,
          category: IssueCategory.lighting,
          reports: [
            ReportModel(
              id: "report2",
              issueId: "2",
              details: 'Sample report details',
              image: "https://cdn.discordapp.com/attachments/1307817305253875754/1364717491158388788/9k.png",
              category: "Lighting",
              threshold: 0.8,
              severity: ReportSeverity.low,
              timestamp: "2023-10-01T12:00:00Z",
              latitude: latitude + 0.08,
              longitude: longitude + 0.002,
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
      return ApiResult.success([]); // Replace with actual data when implementing
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
