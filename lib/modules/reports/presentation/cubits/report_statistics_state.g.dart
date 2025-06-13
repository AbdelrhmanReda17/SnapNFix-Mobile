// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_statistics_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReportStatisticsStateImpl _$$ReportStatisticsStateImplFromJson(
        Map<String, dynamic> json) =>
    _$ReportStatisticsStateImpl(
      statistics: json['statistics'] == null
          ? null
          : ReportStatisticsModel.fromJson(
              json['statistics'] as Map<String, dynamic>),
      isLoading: json['isLoading'] as bool? ?? true,
      error: json['error'] as String?,
      lastUpdated: json['lastUpdated'] == null
          ? null
          : DateTime.parse(json['lastUpdated'] as String),
    );

Map<String, dynamic> _$$ReportStatisticsStateImplToJson(
        _$ReportStatisticsStateImpl instance) =>
    <String, dynamic>{
      'statistics': instance.statistics,
      'isLoading': instance.isLoading,
      'error': instance.error,
      'lastUpdated': instance.lastUpdated?.toIso8601String(),
    };
