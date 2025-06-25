import 'package:json_annotation/json_annotation.dart';
part 'reset_password_request.g.dart';

@JsonSerializable()
class ResetPasswordRequest {
  final String newPassword;
  final String confirmPassword;

  ResetPasswordRequest({
    required this.newPassword,
    required this.confirmPassword,
  });

  factory ResetPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordRequestToJson(this);
}
