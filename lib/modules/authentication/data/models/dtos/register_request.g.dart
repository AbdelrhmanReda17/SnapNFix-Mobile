// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) =>
    RegisterRequest(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      password: json['password'] as String,
    )
      ..confirmPassword = json['confirmPassword'] as String
      ..deviceId = json['deviceId'] as String?
      ..deviceType = json['deviceType'] as String?
      ..deviceName = json['deviceName'] as String?
      ..platform = json['platform'] as String?
      ..fcmToken = json['fcmToken'] as String?;

Map<String, dynamic> _$RegisterRequestToJson(RegisterRequest instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'password': instance.password,
      'confirmPassword': instance.confirmPassword,
      'deviceId': instance.deviceId,
      'deviceType': instance.deviceType,
      'deviceName': instance.deviceName,
      'platform': instance.platform,
      'fcmToken': instance.fcmToken,
    };
