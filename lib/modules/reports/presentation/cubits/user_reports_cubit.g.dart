// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_reports_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserReportsStateImpl _$$UserReportsStateImplFromJson(
        Map<String, dynamic> json) =>
    _$UserReportsStateImpl(
      reports: (json['reports'] as List<dynamic>?)
              ?.map((e) => SnapReportModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      isLoading: json['isLoading'] as bool? ?? true,
      isLoadingMore: json['isLoadingMore'] as bool? ?? false,
      hasReachedEnd: json['hasReachedEnd'] as bool? ?? false,
      error: json['error'] as String?,
      currentStatus:
          $enumDecodeNullable(_$ReportStatusEnumMap, json['currentStatus']),
      currentCategory:
          $enumDecodeNullable(_$IssueCategoryEnumMap, json['currentCategory']),
      currentSortOption:
          $enumDecodeNullable(_$SortOptionEnumMap, json['currentSortOption']) ??
              SortOption.dateNewest,
      lastUpdated: json['lastUpdated'] == null
          ? null
          : DateTime.parse(json['lastUpdated'] as String),
    );

Map<String, dynamic> _$$UserReportsStateImplToJson(
        _$UserReportsStateImpl instance) =>
    <String, dynamic>{
      'reports': instance.reports,
      'isLoading': instance.isLoading,
      'isLoadingMore': instance.isLoadingMore,
      'hasReachedEnd': instance.hasReachedEnd,
      'error': instance.error,
      'currentStatus': _$ReportStatusEnumMap[instance.currentStatus],
      'currentCategory': _$IssueCategoryEnumMap[instance.currentCategory],
      'currentSortOption': _$SortOptionEnumMap[instance.currentSortOption]!,
      'lastUpdated': instance.lastUpdated?.toIso8601String(),
    };

const _$ReportStatusEnumMap = {
  ReportStatus.pending: 'pending',
  ReportStatus.approved: 'approved',
  ReportStatus.declined: 'declined',
};

const _$IssueCategoryEnumMap = {
  IssueCategory.garbage: 'garbage',
  IssueCategory.defectiveManhole: 'defectiveManhole',
  IssueCategory.pothole: 'pothole',
  IssueCategory.nonDefectiveManhole: 'nonDefectiveManhole',
};

const _$SortOptionEnumMap = {
  SortOption.dateNewest: 'dateNewest',
  SortOption.dateOldest: 'dateOldest',
};
