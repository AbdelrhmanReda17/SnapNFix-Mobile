import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snapnfix/modules/authentication/domain/entities/user_gender.dart';
part "edit_profile_request.g.dart";

@JsonSerializable()
class EditProfileRequest {
  final String? firstName;
  final String? lastName;
  final UserGender? gender;
  final String? birthDate;

  @JsonKey(includeToJson: false)
  final String? phoneNumber;
  @JsonKey(includeToJson: false)
  final String? email;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final File? profileImage;

  EditProfileRequest({
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.email,
    this.gender,
    this.birthDate,
    this.profileImage,
  });

  factory EditProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$EditProfileRequestFromJson(json);
  Map<String, dynamic> toJson() => _$EditProfileRequestToJson(this);

}
