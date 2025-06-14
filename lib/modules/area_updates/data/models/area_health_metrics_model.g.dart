// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area_health_metrics_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AreaHealthMetricsModel _$AreaHealthMetricsModelFromJson(
        Map<String, dynamic> json) =>
    AreaHealthMetricsModel(
      totalIssues: (json['totalIssues'] as num).toInt(),
      closedIssues: (json['closedIssues'] as num).toInt(),
      resolvedIssues: (json['resolvedIssues'] as num).toInt(),
      areaHealthScore: (json['areaHealthScore'] as num).toDouble(),
      openIssues: (json['openIssues'] as num).toInt(),
    );

Map<String, dynamic> _$AreaHealthMetricsModelToJson(
        AreaHealthMetricsModel instance) =>
    <String, dynamic>{
      'totalIssues': instance.totalIssues,
      'openIssues': instance.openIssues,
      'closedIssues': instance.closedIssues,
      'resolvedIssues': instance.resolvedIssues,
      'areaHealthScore': instance.areaHealthScore,
    };
