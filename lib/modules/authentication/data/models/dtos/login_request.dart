import 'package:json_annotation/json_annotation.dart';

part 'login_request.g.dart';

@JsonSerializable()
class LoginRequest {
  final String emailOrPhoneNumber;
  final String password;
  String? deviceId;
  String? deviceType;
  String? deviceName;
  String? platform;
  String? fcmToken;

  LoginRequest({required this.emailOrPhoneNumber, required this.password});

  LoginRequest.withDeviceInfo({
    required this.emailOrPhoneNumber,
    required this.password,
    this.deviceId,
    this.deviceType,
    this.deviceName,
    this.platform,
    this.fcmToken,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);
  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}
