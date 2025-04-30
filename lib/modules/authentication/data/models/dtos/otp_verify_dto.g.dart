// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_verify_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OTPVerifyDTO _$OTPVerifyDTOFromJson(Map<String, dynamic> json) => OTPVerifyDTO(
  otp: json['otp'] as String,
  verificationToken: json['verificationToken'] as String,
  phoneNumber: json['phoneNumber'] as String,
);

Map<String, dynamic> _$OTPVerifyDTOToJson(OTPVerifyDTO instance) =>
    <String, dynamic>{
      'otp': instance.otp,
      'verificationToken': instance.verificationToken,
      'phoneNumber': instance.phoneNumber,
    };
