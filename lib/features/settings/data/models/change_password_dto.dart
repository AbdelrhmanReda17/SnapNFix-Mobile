import 'package:freezed_annotation/freezed_annotation.dart';
part 'change_password_dto.g.dart';

@JsonSerializable()
class ChangePasswordDTO {
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;

  ChangePasswordDTO({
    required this.oldPassword,
    required this.newPassword,
    required this.confirmPassword,
  });

  factory ChangePasswordDTO.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordDTOFromJson(json);
  Map<String, dynamic> toJson() => _$ChangePasswordDTOToJson(this);
}
