import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
part "edit_profile_request.g.dart";

@JsonSerializable()
class EditProfileRequest {
  final String? name;
  final String? phoneNumber;
  final String? email;
  final String? gender;
  final DateTime? dateOfBirth;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final File? profileImage;

  EditProfileRequest({
    this.name,
    this.phoneNumber,
    this.email,
    this.gender,
    this.dateOfBirth,
    this.profileImage,
  });

  factory EditProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$EditProfileRequestFromJson(json);
  Map<String, dynamic> toJson() => _$EditProfileRequestToJson(this);
}
