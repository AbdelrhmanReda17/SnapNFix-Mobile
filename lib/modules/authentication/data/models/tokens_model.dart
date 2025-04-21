import 'package:json_annotation/json_annotation.dart';
import 'package:snapnfix/modules/authentication/domain/entities/tokens.dart';

part 'tokens_model.g.dart';

@JsonSerializable()
class TokensModel extends Tokens {
  const TokensModel({
    required super.accessToken,
    required super.refreshToken,
    required super.expiresIn,
    required super.issuedAt,
  });

  factory TokensModel.fromJson(Map<String, dynamic> json) =>
      _$TokensModelFromJson(json);

  Map<String, dynamic> toJson() => _$TokensModelToJson(this);
}
