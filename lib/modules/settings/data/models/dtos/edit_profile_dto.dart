import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
part 'edit_profile_dto.g.dart';

@JsonSerializable()
class EditProfileDTO {
  final String? name;
  final String? phoneNumber;
  final String? email;
  final String? gender;
  final DateTime? dateOfBirth;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final File? profileImage;

  EditProfileDTO({
    this.name,
    this.phoneNumber,
    this.email,
    this.gender,
    this.dateOfBirth,
    this.profileImage,
  });

  factory EditProfileDTO.fromJson(Map<String, dynamic> json) =>
      _$EditProfileDTOFromJson(json);
  Map<String, dynamic> toJson() => _$EditProfileDTOToJson(this);
}
