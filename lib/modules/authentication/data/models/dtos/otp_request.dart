import 'package:json_annotation/json_annotation.dart';

part 'otp_request.g.dart';

@JsonSerializable()
class OtpRequest {
  final String phoneNumber;
  const OtpRequest({required this.phoneNumber});

  factory OtpRequest.fromJson(Map<String, dynamic> json) =>
      _$OtpRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OtpRequestToJson(this);
}
