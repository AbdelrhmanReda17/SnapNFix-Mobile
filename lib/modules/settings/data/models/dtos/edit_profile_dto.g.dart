// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_profile_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditProfileDTO _$EditProfileDTOFromJson(Map<String, dynamic> json) =>
    EditProfileDTO(
      name: json['name'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      email: json['email'] as String?,
      gender: json['gender'] as String?,
      dateOfBirth:
          json['dateOfBirth'] == null
              ? null
              : DateTime.parse(json['dateOfBirth'] as String),
    );

Map<String, dynamic> _$EditProfileDTOToJson(EditProfileDTO instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'gender': instance.gender,
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
    };
