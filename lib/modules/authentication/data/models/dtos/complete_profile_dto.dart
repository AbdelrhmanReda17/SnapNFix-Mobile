import 'package:json_annotation/json_annotation.dart';

part 'complete_profile_dto.g.dart';

@JsonSerializable()
class CompleteProfileDTO {
  final String firstName;
  final String lastName;
  final String password;
  String confirmPassword;


  CompleteProfileDTO({
    required this.firstName,
    required this.lastName,
    required this.password,
  }) : confirmPassword = password;

  CompleteProfileDTO.withDeviceInfo({
    required this.firstName,
    required this.lastName,
    required this.password,
  }) : confirmPassword = password;

  factory CompleteProfileDTO.fromJson(Map<String, dynamic> json) =>
      _$CompleteProfileDTOFromJson(json);
  Map<String, dynamic> toJson() => _$CompleteProfileDTOToJson(this);
}
