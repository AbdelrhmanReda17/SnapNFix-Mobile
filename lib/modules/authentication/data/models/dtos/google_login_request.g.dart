// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_login_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoogleLoginRequest _$GoogleLoginRequestFromJson(Map<String, dynamic> json) =>
    GoogleLoginRequest(
      idToken: json['idToken'] as String,
    )
      ..deviceId = json['deviceId'] as String?
      ..deviceType = json['deviceType'] as String?
      ..deviceName = json['deviceName'] as String?
      ..platform = json['platform'] as String?
      ..fcmToken = json['fcmToken'] as String?;

Map<String, dynamic> _$GoogleLoginRequestToJson(GoogleLoginRequest instance) =>
    <String, dynamic>{
      'idToken': instance.idToken,
      'deviceId': instance.deviceId,
      'deviceType': instance.deviceType,
      'deviceName': instance.deviceName,
      'platform': instance.platform,
      'fcmToken': instance.fcmToken,
    };
