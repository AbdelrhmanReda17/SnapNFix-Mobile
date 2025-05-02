import 'package:json_annotation/json_annotation.dart';

part 'complete_profile_dto.g.dart';

@JsonSerializable()
class CompleteProfileDTO {
  final String firstName;
  final String lastName;
  final String password;
  String? confirmPassword;
  String? deviceId;
  String? deviceName;
  String? deviceType;
  String? platform;

  CompleteProfileDTO({
    required this.firstName,
    required this.lastName,
    required this.password,
  }) : deviceId = null,
       deviceName = null,
       deviceType = null,
       platform = null,
        confirmPassword = password;

  CompleteProfileDTO.withDeviceInfo({
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.deviceId,
    required this.deviceName,
    required this.deviceType,
    required this.platform,
  }) : confirmPassword = password;

  factory CompleteProfileDTO.fromJson(Map<String, dynamic> json) =>
      _$CompleteProfileDTOFromJson(json);
  Map<String, dynamic> toJson() => _$CompleteProfileDTOToJson(this);
}
