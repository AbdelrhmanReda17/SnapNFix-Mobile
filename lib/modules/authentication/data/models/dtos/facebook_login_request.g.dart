// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'facebook_login_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FacebookLoginRequest _$FacebookLoginRequestFromJson(
        Map<String, dynamic> json) =>
    FacebookLoginRequest(
      idToken: json['idToken'] as String,
    )
      ..deviceId = json['deviceId'] as String?
      ..deviceType = json['deviceType'] as String?
      ..deviceName = json['deviceName'] as String?
      ..platform = json['platform'] as String?
      ..fcmToken = json['fcmToken'] as String?;

Map<String, dynamic> _$FacebookLoginRequestToJson(
        FacebookLoginRequest instance) =>
    <String, dynamic>{
      'idToken': instance.idToken,
      'deviceId': instance.deviceId,
      'deviceType': instance.deviceType,
      'deviceName': instance.deviceName,
      'platform': instance.platform,
      'fcmToken': instance.fcmToken,
    };
