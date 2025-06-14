import 'package:json_annotation/json_annotation.dart';

part 'facebook_login_request.g.dart';

@JsonSerializable()
class FacebookLoginRequest {
  final String idToken;
  String? deviceId;
  String? deviceType;
  String? deviceName;
  String? platform;
  String? fcmToken;

  FacebookLoginRequest({required this.idToken});

  FacebookLoginRequest.withDeviceInfo({
    required this.idToken,
    this.deviceId,
    this.deviceType,
    this.deviceName,
    this.platform,
    this.fcmToken,
  });

  factory FacebookLoginRequest.fromJson(Map<String, dynamic> json) =>
      _$FacebookLoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$FacebookLoginRequestToJson(this);
}
