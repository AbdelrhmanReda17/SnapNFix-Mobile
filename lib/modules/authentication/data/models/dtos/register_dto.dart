import 'package:json_annotation/json_annotation.dart';

part 'register_dto.g.dart';

@JsonSerializable()
class RegisterDTO {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String password;
  final String confirmPassword;

  RegisterDTO({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.password,
    required this.confirmPassword,
  });

  factory RegisterDTO.fromJson(Map<String, dynamic> json) =>
      _$RegisterDTOFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterDTOToJson(this);
}
