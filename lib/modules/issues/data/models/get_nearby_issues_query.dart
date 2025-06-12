import 'package:json_annotation/json_annotation.dart';

part 'get_nearby_issues_query.g.dart';

@JsonSerializable()
class GetNearbyIssuesQuery {
  final double latitude;
  final double longitude;
  final int radius;
  GetNearbyIssuesQuery({
    required this.latitude,
    required this.longitude,
    required this.radius,
  });

  Map<String, dynamic> toJson() {
    return {'latitude': latitude, 'longitude': longitude, 'radius': radius};
  }
}
