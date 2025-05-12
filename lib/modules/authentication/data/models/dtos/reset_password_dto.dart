import 'package:freezed_annotation/freezed_annotation.dart';

part 'reset_password_dto.g.dart';

@JsonSerializable()
class ResetPasswordDTO {
  String newPassword;
  String confirmPassword;

  ResetPasswordDTO({required this.newPassword, required this.confirmPassword});

  factory ResetPasswordDTO.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordDTOToJson(this);
}
