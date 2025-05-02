// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tokens_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokensModel _$TokensModelFromJson(Map<String, dynamic> json) => TokensModel(
  accessToken: json['token'] as String,
  refreshToken: json['refreshToken'] as String,
  expiresAt: TokensModel._dateTimeFromString(json['expiresAt'] as String),
);

Map<String, dynamic> _$TokensModelToJson(TokensModel instance) =>
    <String, dynamic>{
      'token': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'expiresAt': TokensModel._dateTimeToString(instance.expiresAt),
    };
