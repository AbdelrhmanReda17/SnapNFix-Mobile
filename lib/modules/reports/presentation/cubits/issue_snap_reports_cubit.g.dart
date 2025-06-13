// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issue_snap_reports_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$IssueSnapReportsStateImpl _$$IssueSnapReportsStateImplFromJson(
        Map<String, dynamic> json) =>
    _$IssueSnapReportsStateImpl(
      reports: (json['reports'] as List<dynamic>?)
              ?.map((e) => SnapReportModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      isLoading: json['isLoading'] as bool? ?? false,
      isLoadingMore: json['isLoadingMore'] as bool? ?? false,
      hasReachedEnd: json['hasReachedEnd'] as bool? ?? false,
      error: json['error'] as String?,
    );

Map<String, dynamic> _$$IssueSnapReportsStateImplToJson(
        _$IssueSnapReportsStateImpl instance) =>
    <String, dynamic>{
      'reports': instance.reports,
      'isLoading': instance.isLoading,
      'isLoadingMore': instance.isLoadingMore,
      'hasReachedEnd': instance.hasReachedEnd,
      'error': instance.error,
    };
