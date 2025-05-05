import 'package:snapnfix/core/infrastructure/networking/api_error_handler.dart';
import 'package:snapnfix/core/infrastructure/networking/api_result.dart';
import 'package:snapnfix/core/infrastructure/networking/api_service.dart';
import 'package:snapnfix/modules/issues/data/models/issue_description_model.dart';
import 'package:snapnfix/modules/issues/data/models/issue_model.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_category.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_severity.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_status.dart';
import 'package:snapnfix/modules/reports/data/model/media_model.dart';
import 'package:snapnfix/modules/reports/data/model/report_model.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_severity.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_status.dart';

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
          category: IssueCategory.manhole,
          status: IssueStatus.pending,
          createdAt: DateTime.now(),
          reportsCount: 2,
          location: "Dokki Street",
          images: ["issue1.jpg", "issue2.jpg", "issue3.jpg"],
          descriptions: [
            IssueDescriptionModel(
              id: "description1",
              username: "John Doe",
              userImage:
                  "https://cdn.discordapp.com/attachments/1307817305253875754/1364715253669171262/9k.png?ex=680aad9f&is=68095c1f&hm=04fbf9612e854fee7b063a94602dd3674a49359b59a3ae923e65210eef2e2ebc&",
              text: "This is a big issue that needs to be fixed soon.",
              createdAt: DateTime.now(),
            ),
            IssueDescriptionModel(
              id: "description2",
              text: "I've seen this problem for weeks now.",
              username: "Sarah",
              createdAt: DateTime.now().subtract(const Duration(hours: 3)),
            ),
          ],
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
          category: IssueCategory.roadDamage,
          resolvedAt: DateTime.now().subtract(const Duration(days: 2)),
          reportsCount: 2,
          location: "Nasr City",
          images: ["issue1.jpg"],
          descriptions: [
            IssueDescriptionModel(
              id: "description1",
              text: "This road damage is getting worse.",
              username: "Alex",
              createdAt: DateTime.now().subtract(const Duration(days: 9)),
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
          category: IssueCategory.roadDamage,
          status: IssueStatus.inProgress,
          createdAt: DateTime.now(),
          reportsCount: 3,
          location: "New Cairo",
          images: ["issue2.jpg"],
          descriptions: [
            IssueDescriptionModel(
              id: "description1",
              text: "The road is getting fixed, crews are working on it.",
              username: "Michael",
              createdAt: DateTime.now().subtract(const Duration(days: 2)),
            ),
            IssueDescriptionModel(
              id: "description2",
              text: "Finally! This has been an issue for months.",
              username: "Rebecca",
              createdAt: DateTime.now().subtract(const Duration(days: 1)),
            ),
          ],
        ),
        IssueModel(
          id: "3",
          severity: IssueSeverity.high,
          latitude: 30.0083018 + 0.007,
          longitude: 31.3299911 + 0.002,
          category: IssueCategory.roadDamage,
          status: IssueStatus.pending,
          createdAt: DateTime.now(),
          reportsCount: 1,
          location: "Dokki Street",
          images: ["issue3.jpg"],
          descriptions: [],
        ),
        IssueModel(
          id: "4",
          severity: IssueSeverity.medium,
          latitude: 30.0083018 + 0.001,
          longitude: 31.3299911 + 0.002,
          category: IssueCategory.lighting,
          status: IssueStatus.inProgress,
          createdAt: DateTime.now(),
          reportsCount: 2,
          location: "Dokki Street",
          images: ["issue1.jpg"],
          descriptions: [
            IssueDescriptionModel(
              id: "description1",
              text:
                  "Street lights have been out for days, making it unsafe at night.",
              username: "Jennifer",
              createdAt: DateTime.now().subtract(const Duration(days: 6)),
            ),
          ],
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
