// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_reset_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PasswordResetRequest _$PasswordResetRequestFromJson(
        Map<String, dynamic> json) =>
    PasswordResetRequest(
      emailOrPhoneNumber: json['emailOrPhoneNumber'] as String,
    );

Map<String, dynamic> _$PasswordResetRequestToJson(
        PasswordResetRequest instance) =>
    <String, dynamic>{
      'emailOrPhoneNumber': instance.emailOrPhoneNumber,
    };
