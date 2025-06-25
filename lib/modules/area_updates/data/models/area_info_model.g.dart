// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AreaInfoModel _$AreaInfoModelFromJson(Map<String, dynamic> json) =>
    AreaInfoModel(
      id: json['id'] as String,
      name: json['name'] as String,
      state: json['state'] as String,
      activeIssuesCount: (json['activeIssuesCount'] as num).toInt(),
    );

Map<String, dynamic> _$AreaInfoModelToJson(AreaInfoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'state': instance.state,
      'activeIssuesCount': instance.activeIssuesCount,
    };
