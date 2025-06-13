import 'package:json_annotation/json_annotation.dart';

part 'get_nearby_issues_query.g.dart';

@JsonSerializable()
class GetNearbyIssuesQuery {
  final double latitude;
  final double longitude;
  final double radius;

  // Optional viewport parameters
  final double? northEastLat;
  final double? northEastLng;
  final double? southWestLat;
  final double? southWestLng;
  final int? maxResults;

  GetNearbyIssuesQuery({
    required this.latitude,
    required this.longitude,
    required this.radius,
    this.northEastLat,
    this.northEastLng,
    this.southWestLat,
    this.southWestLng,
    this.maxResults,
  });

  factory GetNearbyIssuesQuery.fromJson(Map<String, dynamic> json) =>
      _$GetNearbyIssuesQueryFromJson(json);

  Map<String, dynamic> toJson() => _$GetNearbyIssuesQueryToJson(this);
}
