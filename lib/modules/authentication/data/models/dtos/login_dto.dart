import 'package:json_annotation/json_annotation.dart';
part 'login_dto.g.dart';

@JsonSerializable()
class LoginDTO {
  final String emailOrPhoneNumber;
  final String password;

  LoginDTO({required this.emailOrPhoneNumber, required this.password});

  factory LoginDTO.fromJson(Map<String, dynamic> json) =>
      _$LoginDTOFromJson(json);
  Map<String, dynamic> toJson() => _$LoginDTOToJson(this);
}
