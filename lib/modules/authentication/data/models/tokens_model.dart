import 'package:json_annotation/json_annotation.dart';
import 'package:snapnfix/modules/authentication/domain/entities/tokens.dart';

part 'tokens_model.g.dart';

@JsonSerializable()
class TokensModel extends Tokens {
  @JsonKey(name: 'token')
  final String accessToken;

  @JsonKey(name: 'refreshToken')
  final String refreshToken;

  @JsonKey(
    name: 'expiresAt',
    fromJson: _dateTimeFromString,
    toJson: _dateTimeToString,
  )
  final DateTime expiresAt;

  TokensModel({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresAt,
  }) : super(
         accessToken: accessToken,
         refreshToken: refreshToken,
         expiresAt: expiresAt,
         issuedAt: DateTime.now(),
       );

  factory TokensModel.fromJson(Map<String, dynamic> json) =>
      _$TokensModelFromJson(json);

  Map<String, dynamic> toJson() => _$TokensModelToJson(this);

  static DateTime _dateTimeFromString(String date) => DateTime.parse(date);
  static String _dateTimeToString(DateTime date) => date.toIso8601String();

  @override
  String toString() {
    return 'TokensModel{accessToken: $accessToken, refreshToken: $refreshToken, expiresAt: $expiresAt}';
  }
}
