// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_subscribed_areas_query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllSubscribedAreasQuery _$GetAllSubscribedAreasQueryFromJson(
        Map<String, dynamic> json) =>
    GetAllSubscribedAreasQuery(
      searchTerm: json['searchTerm'] as String?,
      pageNumber: (json['pageNumber'] as num?)?.toInt() ?? 1,
      pageSize: (json['pageSize'] as num?)?.toInt() ?? 10,
    );

Map<String, dynamic> _$GetAllSubscribedAreasQueryToJson(
        GetAllSubscribedAreasQuery instance) =>
    <String, dynamic>{
      'searchTerm': instance.searchTerm,
      'pageNumber': instance.pageNumber,
      'pageSize': instance.pageSize,
    };
