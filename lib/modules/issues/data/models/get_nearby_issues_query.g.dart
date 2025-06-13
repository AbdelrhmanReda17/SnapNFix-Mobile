// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_nearby_issues_query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetNearbyIssuesQuery _$GetNearbyIssuesQueryFromJson(
        Map<String, dynamic> json) =>
    GetNearbyIssuesQuery(
      northEastLat: (json['northEastLat'] as num).toDouble(),
      northEastLng: (json['northEastLng'] as num).toDouble(),
      southWestLat: (json['southWestLat'] as num).toDouble(),
      southWestLng: (json['southWestLng'] as num).toDouble(),
      maxResults: (json['maxResults'] as num?)?.toInt(),
    );

Map<String, dynamic> _$GetNearbyIssuesQueryToJson(
        GetNearbyIssuesQuery instance) =>
    <String, dynamic>{
      'northEastLat': instance.northEastLat,
      'northEastLng': instance.northEastLng,
      'southWestLat': instance.southWestLat,
      'southWestLng': instance.southWestLng,
      'maxResults': instance.maxResults,
    };
