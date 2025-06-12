// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) => LoginRequest(
      emailOrPhoneNumber: json['emailOrPhoneNumber'] as String,
      password: json['password'] as String,
    )
      ..deviceId = json['deviceId'] as String?
      ..deviceType = json['deviceType'] as String?
      ..deviceName = json['deviceName'] as String?
      ..platform = json['platform'] as String?;

Map<String, dynamic> _$LoginRequestToJson(LoginRequest instance) =>
    <String, dynamic>{
      'emailOrPhoneNumber': instance.emailOrPhoneNumber,
      'password': instance.password,
      'deviceId': instance.deviceId,
      'deviceType': instance.deviceType,
      'deviceName': instance.deviceName,
      'platform': instance.platform,
    };
