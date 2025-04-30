import 'package:json_annotation/json_annotation.dart';

part 'otp_verify_dto.g.dart';

@JsonSerializable()
class OTPVerifyDTO {
  final String otp;
  final String verificationToken;
  final String phoneNumber;

  OTPVerifyDTO({
    required this.otp,
    required this.verificationToken,
    required this.phoneNumber,
  });

  factory OTPVerifyDTO.fromJson(Map<String, dynamic> json) =>
      _$OTPVerifyDTOFromJson(json);

  Map<String, dynamic> toJson() => _$OTPVerifyDTOToJson(this);
}
