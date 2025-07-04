// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_area_issues_query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAreaIssuesQuery _$GetAreaIssuesQueryFromJson(Map<String, dynamic> json) =>
    GetAreaIssuesQuery(
      status: $enumDecodeNullable(_$IssueStatusEnumMap, json['status']),
      pageNumber: (json['pageNumber'] as num?)?.toInt() ?? 1,
      pageSize: (json['pageSize'] as num?)?.toInt() ?? 10,
    );

Map<String, dynamic> _$GetAreaIssuesQueryToJson(GetAreaIssuesQuery instance) =>
    <String, dynamic>{
      'status': _$IssueStatusEnumMap[instance.status],
      'pageNumber': instance.pageNumber,
      'pageSize': instance.pageSize,
    };

const _$IssueStatusEnumMap = {
  IssueStatus.pending: 'pending',
  IssueStatus.inProgress: 'inProgress',
  IssueStatus.completed: 'completed',
};
