import 'package:json_annotation/json_annotation.dart';
part 'login_dto.g.dart';

@JsonSerializable()
class LoginDTO {
  final String emailOrPhoneNumber;
  final String password;
  String? deviceId;
  String? deviceName;
  String? deviceType;
  String? platform;
  LoginDTO({required this.emailOrPhoneNumber, required this.password})
    : deviceId = null,
      deviceName = null,
      deviceType = null,
      platform = null;

  LoginDTO.withDeviceInfo({
    required this.emailOrPhoneNumber,
    required this.password,
    required this.deviceId,
    required this.deviceName,
    required this.deviceType,
    required this.platform,
  });

  void setDeviceInfo({
    required String deviceId,
    required String deviceName,
    required String deviceType,
    required String platform,
  }) {
    this.deviceId = deviceId;
    this.deviceName = deviceName;
    this.deviceType = deviceType;
    this.platform = platform;
  }

  factory LoginDTO.fromJson(Map<String, dynamic> json) =>
      _$LoginDTOFromJson(json);
  Map<String, dynamic> toJson() => _$LoginDTOToJson(this);
}
