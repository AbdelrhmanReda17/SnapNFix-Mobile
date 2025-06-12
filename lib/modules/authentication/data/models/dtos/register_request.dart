import 'package:json_annotation/json_annotation.dart';

part 'register_request.g.dart';

@JsonSerializable()
class RegisterRequest {
  final String firstName;
  final String lastName;
  final String password;
  String confirmPassword;
  String? deviceId;
  String? deviceType;
  String? deviceName;
  String? platform;

  RegisterRequest({
    required this.firstName,
    required this.lastName,
    required this.password,
  }) : confirmPassword = password;

  RegisterRequest.withDeviceInfo({
    required this.firstName,
    required this.lastName,
    required this.password,
    this.deviceId,
    this.deviceType,
    this.deviceName,
    this.platform,
  }) : confirmPassword = password;

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}
