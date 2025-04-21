// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaModel _$MediaModelFromJson(Map<String, dynamic> json) => MediaModel(
  image: json['image'] as String,
  category: json['category'] as String?,
  threshold: (json['threshold'] as num?)?.toDouble(),
);

Map<String, dynamic> _$MediaModelToJson(MediaModel instance) =>
    <String, dynamic>{
      'image': instance.image,
      'category': instance.category,
      'threshold': instance.threshold,
    };
