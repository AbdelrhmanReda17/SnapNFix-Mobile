import 'package:json_annotation/json_annotation.dart';

part 'get_nearby_issues_query.g.dart';

@JsonSerializable()
class GetNearbyIssuesQuery {
  final double northEastLat;
  final double northEastLng;
  final double southWestLat;
  final double southWestLng;
  final int? maxResults;

  GetNearbyIssuesQuery({
    required this.northEastLat,
    required this.northEastLng,
    required this.southWestLat,
    required this.southWestLng,
    this.maxResults,
  });

  factory GetNearbyIssuesQuery.fromJson(Map<String, dynamic> json) =>
      _$GetNearbyIssuesQueryFromJson(json);

  Map<String, dynamic> toJson() => _$GetNearbyIssuesQueryToJson(this);
}
