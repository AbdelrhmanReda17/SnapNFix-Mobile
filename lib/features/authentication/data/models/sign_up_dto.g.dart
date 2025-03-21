// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpDTO _$SignUpDTOFromJson(Map<String, dynamic> json) => SignUpDTO(
  phone: json['phone'] as String,
  password: json['password'] as String,
  passwordConfirmation: json['password_confirmation'] as String,
);

Map<String, dynamic> _$SignUpDTOToJson(SignUpDTO instance) => <String, dynamic>{
  'phone': instance.phone,
  'password': instance.password,
  'password_confirmation': instance.passwordConfirmation,
};
