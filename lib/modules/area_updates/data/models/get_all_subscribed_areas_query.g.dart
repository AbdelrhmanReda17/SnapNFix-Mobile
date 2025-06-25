// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_subscribed_areas_query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllSubscribedAreasQuery _$GetAllSubscribedAreasQueryFromJson(
        Map<String, dynamic> json) =>
    GetAllSubscribedAreasQuery(
      searchTerm: json['searchTerm'] as String?,
      page: (json['page'] as num?)?.toInt() ?? 1,
      limit: (json['limit'] as num?)?.toInt() ?? 10,
    );

Map<String, dynamic> _$GetAllSubscribedAreasQueryToJson(
        GetAllSubscribedAreasQuery instance) =>
    <String, dynamic>{
      'searchTerm': instance.searchTerm,
      'page': instance.page,
      'limit': instance.limit,
    };
