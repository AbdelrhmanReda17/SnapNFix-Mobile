import 'package:json_annotation/json_annotation.dart';
part 'sign_up_dto.g.dart';

@JsonSerializable()
class SignUpDTO {
  final String firstName;
  final String lastName;
  @JsonKey(name: 'PhoneNumber')
  final String phone;
  final String password;
  @JsonKey(name: 'ConfirmPassword')
  final String passwordConfirmation;

  SignUpDTO({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.password,
    required this.passwordConfirmation,
  });

  factory SignUpDTO.fromJson(Map<String, dynamic> json) =>
      _$SignUpDTOFromJson(json);
  Map<String, dynamic> toJson() => _$SignUpDTOToJson(this);
}
