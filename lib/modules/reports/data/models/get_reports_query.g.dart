// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_reports_query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetReportsQuery _$GetReportsQueryFromJson(Map<String, dynamic> json) =>
    GetReportsQuery(
      sort: json['sort'] as String?,
      status: json['status'] as String?,
      category: $enumDecodeNullable(_$IssueCategoryEnumMap, json['category']),
      page: (json['page'] as num?)?.toInt() ?? 1,
      limit: (json['limit'] as num?)?.toInt() ?? 10,
    );

Map<String, dynamic> _$GetReportsQueryToJson(GetReportsQuery instance) =>
    <String, dynamic>{
      'sort': instance.sort,
      'status': instance.status,
      'category': _$IssueCategoryEnumMap[instance.category],
      'page': instance.page,
      'limit': instance.limit,
    };

const _$IssueCategoryEnumMap = {
  IssueCategory.garbage: 'garbage',
  IssueCategory.defectiveManhole: 'defectiveManhole',
  IssueCategory.pothole: 'pothole',
  IssueCategory.nonDefectiveManhole: 'nonDefectiveManhole',
};
