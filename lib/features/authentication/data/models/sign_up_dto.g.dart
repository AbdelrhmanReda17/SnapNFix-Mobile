// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpDTO _$SignUpDTOFromJson(Map<String, dynamic> json) => SignUpDTO(
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  phone: json['PhoneNumber'] as String,
  password: json['password'] as String,
  passwordConfirmation: json['ConfirmPassword'] as String,
);

Map<String, dynamic> _$SignUpDTOToJson(SignUpDTO instance) => <String, dynamic>{
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'PhoneNumber': instance.phone,
  'password': instance.password,
  'ConfirmPassword': instance.passwordConfirmation,
};
