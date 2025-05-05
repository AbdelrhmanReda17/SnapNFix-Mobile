// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complete_profile_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompleteProfileDTO _$CompleteProfileDTOFromJson(Map<String, dynamic> json) =>
    CompleteProfileDTO(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      password: json['password'] as String,
    )..confirmPassword = json['confirmPassword'] as String;

Map<String, dynamic> _$CompleteProfileDTOToJson(CompleteProfileDTO instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'password': instance.password,
      'confirmPassword': instance.confirmPassword,
    };
