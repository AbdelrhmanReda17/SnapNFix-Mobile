// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_areas_query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllAreasQuery _$GetAllAreasQueryFromJson(Map<String, dynamic> json) =>
    GetAllAreasQuery(
      searchTerm: json['searchTerm'] as String?,
      pageNumber: (json['pageNumber'] as num?)?.toInt() ?? 1,
      pageSize: (json['pageSize'] as num?)?.toInt() ?? 10,
    );

Map<String, dynamic> _$GetAllAreasQueryToJson(GetAllAreasQuery instance) =>
    <String, dynamic>{
      'searchTerm': instance.searchTerm,
      'pageNumber': instance.pageNumber,
      'pageSize': instance.pageSize,
    };
