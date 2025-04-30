// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_respone_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterResponeDTO _$RegisterResponeDTOFromJson(Map<String, dynamic> json) =>
    RegisterResponeDTO(
      userId: json['userId'] as String,
      verificationToken: json['verificationToken'] as String,
    );

Map<String, dynamic> _$RegisterResponeDTOToJson(RegisterResponeDTO instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'verificationToken': instance.verificationToken,
    };
