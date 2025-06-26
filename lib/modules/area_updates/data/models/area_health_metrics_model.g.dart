// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area_health_metrics_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AreaHealthMetricsModel _$AreaHealthMetricsModelFromJson(
        Map<String, dynamic> json) =>
    AreaHealthMetricsModel(
      inProgressIssuesCount: (json['inProgressIssuesCount'] as num).toInt(),
      fixedIssuesCount: (json['fixedIssuesCount'] as num).toInt(),
      pendingIssuesCount: (json['pendingIssuesCount'] as num).toInt(),
      totalSubscribers: (json['totalSubscribers'] as num).toInt(),
      healthCondition:
          $enumDecode(_$HealthConditionEnumMap, json['healthCondition']),
      healthPercentage: (json['healthPercentage'] as num).toDouble(),
    );

Map<String, dynamic> _$AreaHealthMetricsModelToJson(
        AreaHealthMetricsModel instance) =>
    <String, dynamic>{
      'inProgressIssuesCount': instance.inProgressIssuesCount,
      'fixedIssuesCount': instance.fixedIssuesCount,
      'pendingIssuesCount': instance.pendingIssuesCount,
      'healthCondition': _$HealthConditionEnumMap[instance.healthCondition]!,
      'healthPercentage': instance.healthPercentage,
      'totalSubscribers': instance.totalSubscribers,
    };

const _$HealthConditionEnumMap = {
  HealthCondition.poor: 'poor',
  HealthCondition.average: 'average',
  HealthCondition.good: 'good',
  HealthCondition.excellent: 'excellent',
};
