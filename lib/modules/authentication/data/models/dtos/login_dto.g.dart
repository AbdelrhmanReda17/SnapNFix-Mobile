// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginDTO _$LoginDTOFromJson(Map<String, dynamic> json) =>
    LoginDTO(
        emailOrPhoneNumber: json['emailOrPhoneNumber'] as String,
        password: json['password'] as String,
      )
      ..deviceId = json['deviceId'] as String?
      ..deviceName = json['deviceName'] as String?
      ..deviceType = json['deviceType'] as String?
      ..platform = json['platform'] as String?;

Map<String, dynamic> _$LoginDTOToJson(LoginDTO instance) => <String, dynamic>{
  'emailOrPhoneNumber': instance.emailOrPhoneNumber,
  'password': instance.password,
  'deviceId': instance.deviceId,
  'deviceName': instance.deviceName,
  'deviceType': instance.deviceType,
  'platform': instance.platform,
};
