// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_nearby_issues_query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetNearbyIssuesQuery _$GetNearbyIssuesQueryFromJson(
        Map<String, dynamic> json) =>
    GetNearbyIssuesQuery(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      radius: (json['radius'] as num).toInt(),
    );

Map<String, dynamic> _$GetNearbyIssuesQueryToJson(
        GetNearbyIssuesQuery instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'radius': instance.radius,
    };
