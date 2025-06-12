import 'package:snapnfix/core/infrastructure/networking/error/api_error.dart';
import 'package:snapnfix/core/utils/result.dart';
import 'package:snapnfix/modules/index.dart';
import 'package:snapnfix/modules/issues/data/models/markers.dart';
import 'package:snapnfix/modules/issues/domain/repositories/base_issue_repository.dart';

class GetAreaIssuesUseCase {
  final BaseIssueRepository _repository;

  GetAreaIssuesUseCase(this._repository);

  Future<Result<List<IssueModel>, ApiError>> call(String areaName) async {
    // For now, we'll reuse the getNearbyIssues method from the repository
    // In a real app, we would have a specific API endpoint for this

    // These are example coordinates for the area (would normally be looked up)
    final Map<String, List<double>> areaCoordinates = {
      'Nasr City': [30.0591, 31.3414],
      'Downtown': [30.0444, 31.2357],
      'Maadi': [29.9600, 31.2569],
      'Zamalek': [30.0700, 31.2200],
      'Heliopolis': [30.0855, 31.3560],
      // Add more areas as needed
    };

    // Default coordinates and radius if area not found
    double latitude = 30.0444;
    double longitude = 31.2357;
    double radiusInKm = 2.0;

    // Use coordinates for the specific area if available
    if (areaCoordinates.containsKey(areaName)) {
      final coords = areaCoordinates[areaName]!;
      latitude = coords[0];
      longitude = coords[1];
    }
    // dummy return Result<List<IssueModel>, ApiError>
    return Result.success([]);
  }
}
