// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issue_description_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IssueDescriptionModel _$IssueDescriptionModelFromJson(
  Map<String, dynamic> json,
) => IssueDescriptionModel(
  id: json['id'] as String,
  username: json['username'] as String,
  userImage: json['userImage'] as String?,
  text: json['text'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$IssueDescriptionModelToJson(
  IssueDescriptionModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'text': instance.text,
  'createdAt': instance.createdAt.toIso8601String(),
  'username': instance.username,
  'userImage': instance.userImage,
};
