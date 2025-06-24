// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AreaInfoModel _$AreaInfoModelFromJson(Map<String, dynamic> json) =>
    AreaInfoModel(
      cityId: (json['cityId'] as num).toInt(),
      cityName: json['cityName'] as String,
      state: json['state'] as String,
      activeIssuesCount: (json['activeIssuesCount'] as num).toInt(),
    );

Map<String, dynamic> _$AreaInfoModelToJson(AreaInfoModel instance) =>
    <String, dynamic>{
      'cityId': instance.cityId,
      'cityName': instance.cityName,
      'state': instance.state,
      'activeIssuesCount': instance.activeIssuesCount,
    };
