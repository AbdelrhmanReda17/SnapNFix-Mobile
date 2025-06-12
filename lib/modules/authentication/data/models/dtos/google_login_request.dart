import 'package:json_annotation/json_annotation.dart';

part 'google_login_request.g.dart';

@JsonSerializable()
class GoogleLoginRequest {
  final String idToken;
  String? deviceId;
  String? deviceType;
  String? deviceName;
  String? platform;

  GoogleLoginRequest({required this.idToken});

  GoogleLoginRequest.withDeviceInfo({
    required this.idToken,
    this.deviceId,
    this.deviceType,
    this.deviceName,
    this.platform,
  });

  factory GoogleLoginRequest.fromJson(Map<String, dynamic> json) =>
      _$GoogleLoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleLoginRequestToJson(this);
}
