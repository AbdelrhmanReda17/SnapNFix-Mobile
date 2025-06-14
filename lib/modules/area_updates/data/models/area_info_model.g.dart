// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AreaInfoModel _$AreaInfoModelFromJson(Map<String, dynamic> json) =>
    AreaInfoModel(
      name: json['name'] as String,
      displayName: json['displayName'] as String,
      governorate: json['governorate'] as String,
      issuesCount: (json['issuesCount'] as num).toInt(),
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
    );

Map<String, dynamic> _$AreaInfoModelToJson(AreaInfoModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'displayName': instance.displayName,
      'governorate': instance.governorate,
      'issuesCount': instance.issuesCount,
      'lastUpdated': instance.lastUpdated.toIso8601String(),
    };
