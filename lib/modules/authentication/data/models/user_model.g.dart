// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      email: json['email'] as String?,
      profileImage: json['profileImage'] as String?,
      birthDate: json['birthDate'] == null
          ? null
          : DateTime.parse(json['birthDate'] as String),
      gender: $enumDecodeNullable(_$UserGenderEnumMap, json['gender']),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'profileImage': instance.profileImage,
      'birthDate': instance.birthDate?.toIso8601String(),
      'gender': _$UserGenderEnumMap[instance.gender],
    };

const _$UserGenderEnumMap = {
  UserGender.male: 'male',
  UserGender.female: 'female',
  UserGender.notSpecified: 'notSpecified',
};
