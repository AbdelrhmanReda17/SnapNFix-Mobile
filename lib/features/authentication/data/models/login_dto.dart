import 'package:json_annotation/json_annotation.dart';
part 'login_dto.g.dart';

@JsonSerializable()
class LoginDTO{
  @JsonKey(name: 'EmailOrPhone')
  final String emailOrPhone;
  final String password;

  LoginDTO({
    required this.emailOrPhone,
    required this.password,
  });

  factory LoginDTO.fromJson(Map<String, dynamic> json) => _$LoginDTOFromJson(json);
  Map<String, dynamic> toJson() => _$LoginDTOToJson(this);
}
