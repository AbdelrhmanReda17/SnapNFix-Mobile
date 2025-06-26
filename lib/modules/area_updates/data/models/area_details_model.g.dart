// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AreaDetailsModel _$AreaDetailsModelFromJson(Map<String, dynamic> json) =>
    AreaDetailsModel(
      area: AreaInfoModel.fromJson(json['area'] as Map<String, dynamic>),
      issues: (json['issues'] as List<dynamic>)
          .map((e) => AreaIssueModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      healthMetrics: AreaHealthMetricsModel.fromJson(
          json['healthMetrics'] as Map<String, dynamic>),
      isSubscribed: json['isSubscribed'] as bool,
      hasNext: json['hasNext'] as bool? ?? false,
    );

Map<String, dynamic> _$AreaDetailsModelToJson(AreaDetailsModel instance) =>
    <String, dynamic>{
      'issues': instance.issues,
      'healthMetrics': instance.healthMetrics,
      'isSubscribed': instance.isSubscribed,
      'hasNext': instance.hasNext,
      'area': instance.area,
    };
