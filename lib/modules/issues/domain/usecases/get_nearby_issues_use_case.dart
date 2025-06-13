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
    required double latitude,
    required double longitude,
    double radiusInKm = 0.3,
    LatLngBounds? viewport,
    int? maxResults,
  }) async {
    if (viewport != null) {
      final viewportData = _calculateViewportParameters(viewport);
      return _repository.getNearbyIssues(
        viewportData.centerLat,
        viewportData.centerLng,
        radiusInKm,
        bounds: viewport,
        maxResults: maxResults ?? viewportData.recommendedMaxResults,
      );
    }
    return _repository.getNearbyIssues(
      latitude,
      longitude,
      radiusInKm,
      maxResults: maxResults,
    );
  }

  ViewportData _calculateViewportParameters(LatLngBounds bounds) {
    final centerLat =
        (bounds.northeast.latitude + bounds.southwest.latitude) / 2;
    final centerLng =
        (bounds.northeast.longitude + bounds.southwest.longitude) / 2;
    final distance = Geolocator.distanceBetween(
      bounds.southwest.latitude,
      bounds.southwest.longitude,
      bounds.northeast.latitude,
      bounds.northeast.longitude,
    );
    final radiusInKm = (distance / 1000) * 0.6;
    final area = radiusInKm * radiusInKm;
    int recommendedMaxResults;
    if (area < 1) {
      recommendedMaxResults = 50;
    } else if (area < 4) {
      recommendedMaxResults = 100;
    } else if (area < 16) {
      recommendedMaxResults = 200;
    } else {
      recommendedMaxResults = 300;
    }

    return ViewportData(
      centerLat: centerLat,
      centerLng: centerLng,
      radiusInKm: radiusInKm,
      recommendedMaxResults: recommendedMaxResults,
    );
  }
}
