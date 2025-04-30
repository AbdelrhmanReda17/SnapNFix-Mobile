import 'package:json_annotation/json_annotation.dart';

part 'register_respone_dto.g.dart';

@JsonSerializable()
class RegisterResponeDTO {
  @JsonKey(name: 'userId')
  final String userId;
  @JsonKey(name: 'verificationToken')
  final String verificationToken;

  const RegisterResponeDTO({
    required this.userId,
    required this.verificationToken,
  });

  factory RegisterResponeDTO.fromJson(Map<String, dynamic> json) {
    return _$RegisterResponeDTOFromJson(json);
  }

  Map<String, dynamic> toJson() => _$RegisterResponeDTOToJson(this);
}
