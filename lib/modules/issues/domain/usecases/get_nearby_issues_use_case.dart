import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:snapnfix/core/infrastructure/networking/error/api_error.dart';
import 'package:snapnfix/core/utils/result.dart';
import 'package:snapnfix/modules/issues/data/models/markers.dart';
import 'package:snapnfix/modules/issues/domain/entities/view_port_data.dart';
import 'package:snapnfix/modules/issues/domain/repositories/base_issue_repository.dart';

class GetNearbyIssuesUseCase {
  final BaseIssueRepository _repository;

  GetNearbyIssuesUseCase(this._repository);

  Future<Result<List<IssueMarker>, ApiError>> getNearbyIssues({
    required double latitude, // Will be ignored if viewport is provided
    required double longitude, // Will be ignored if viewport is provided
    double radiusInKm = 0.3, // Will be calculated from viewport if provided
    LatLngBounds? viewport,
    int? maxResults,
  }) async {
    // Always prioritize viewport-based fetching when viewport is available
    if (viewport != null) {
      return _fetchByViewport(viewport, maxResults);
    }

    // Fallback to point-based fetching (for initialization or error recovery)
    return _fetchByPoint(latitude, longitude, radiusInKm, maxResults);
  }

  /// Viewport-based fetching - primary method
  Future<Result<List<IssueMarker>, ApiError>> _fetchByViewport(
    LatLngBounds viewport,
    int? maxResults,
  ) async {
    final viewportData = _calculateViewportParameters(viewport);

    return _repository.getNearbyIssues(
      viewportData.centerLat,
      viewportData.centerLng,
      viewportData.radiusInKm,
      bounds: viewport,
      maxResults: maxResults ?? viewportData.recommendedMaxResults,
    );
  }

  /// Point-based fetching - fallback method
  Future<Result<List<IssueMarker>, ApiError>> _fetchByPoint(
    double latitude,
    double longitude,
    double radiusInKm,
    int? maxResults,
  ) async {
    return _repository.getNearbyIssues(
      latitude,
      longitude,
      radiusInKm,
      maxResults: maxResults ?? _getDefaultMaxResults(radiusInKm),
    );
  }

  /// Calculate viewport parameters for optimized fetching
  ViewportData _calculateViewportParameters(LatLngBounds bounds) {
    // Calculate center point
    final centerLat =
        (bounds.northeast.latitude + bounds.southwest.latitude) / 2;
    final centerLng =
        (bounds.northeast.longitude + bounds.southwest.longitude) / 2;

    // Calculate diagonal distance of viewport
    final distance = Geolocator.distanceBetween(
      bounds.southwest.latitude,
      bounds.southwest.longitude,
      bounds.northeast.latitude,
      bounds.northeast.longitude,
    );

    // Convert to radius in km with some buffer
    final radiusInKm = (distance / 1000) * 0.7; // 70% of diagonal for buffer

    // Calculate recommended max results based on viewport area
    final area = radiusInKm * radiusInKm * 3.14159; // Approximate area
    final recommendedMaxResults = _calculateMaxResultsForArea(area);

    return ViewportData(
      centerLat: centerLat,
      centerLng: centerLng,
      radiusInKm: radiusInKm,
      recommendedMaxResults: recommendedMaxResults,
    );
  }

  /// Calculate max results based on viewport area
  int _calculateMaxResultsForArea(double areaInKmSquared) {
    if (areaInKmSquared < 1) return 30; // Very small area
    if (areaInKmSquared < 5) return 60; // Small area
    if (areaInKmSquared < 25) return 100; // Medium area
    if (areaInKmSquared < 100) return 150; // Large area
    return 200; // Very large area
  }

  /// Default max results for point-based fetching
  int _getDefaultMaxResults(double radiusInKm) {
    if (radiusInKm <= 0.5) return 20;
    if (radiusInKm <= 1.0) return 50;
    if (radiusInKm <= 2.0) return 100;
    return 150;
  }
}
