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

  factory TokensModel.fromJson(Map<String, dynamic> json) {
    return TokensModel(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      expiresIn: json['expiresIn'] as int,
      issuedAt: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    'accessToken': accessToken,
    'refreshToken': refreshToken,
    'expiresIn': expiresIn,
    'issuedAt': issuedAt.toIso8601String(),
  };
}