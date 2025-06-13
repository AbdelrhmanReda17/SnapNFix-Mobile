// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issue_fast_reports_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$IssueFastReportsStateImpl _$$IssueFastReportsStateImplFromJson(
        Map<String, dynamic> json) =>
    _$IssueFastReportsStateImpl(
      reports: (json['reports'] as List<dynamic>?)
              ?.map((e) => FastReportModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      isLoading: json['isLoading'] as bool? ?? false,
      isLoadingMore: json['isLoadingMore'] as bool? ?? false,
      hasReachedEnd: json['hasReachedEnd'] as bool? ?? false,
      error: json['error'] as String?,
    );

Map<String, dynamic> _$$IssueFastReportsStateImplToJson(
        _$IssueFastReportsStateImpl instance) =>
    <String, dynamic>{
      'reports': instance.reports,
      'isLoading': instance.isLoading,
      'isLoadingMore': instance.isLoadingMore,
      'hasReachedEnd': instance.hasReachedEnd,
      'error': instance.error,
    };
