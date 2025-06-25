// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_areas_query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllAreasQuery _$GetAllAreasQueryFromJson(Map<String, dynamic> json) =>
    GetAllAreasQuery(
      searchTerm: json['searchTerm'] as String?,
      page: (json['page'] as num?)?.toInt() ?? 1,
      limit: (json['limit'] as num?)?.toInt() ?? 10,
    );

Map<String, dynamic> _$GetAllAreasQueryToJson(GetAllAreasQuery instance) =>
    <String, dynamic>{
      'searchTerm': instance.searchTerm,
      'page': instance.page,
      'limit': instance.limit,
    };
