import 'package:json_annotation/json_annotation.dart';
part 'resend_otp_request.g.dart';

@JsonSerializable()
class ResendOtpRequest {
  ResendOtpRequest();

  factory ResendOtpRequest.fromJson(Map<String, dynamic> json) =>
      _$ResendOtpRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ResendOtpRequestToJson(this);
}
