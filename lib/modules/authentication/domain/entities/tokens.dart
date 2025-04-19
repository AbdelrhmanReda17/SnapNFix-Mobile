import 'package:equatable/equatable.dart';

class Tokens extends Equatable {
  final String accessToken;
  final String refreshToken;
  final int expiresIn;
  final DateTime issuedAt;

  const Tokens({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
    required this.issuedAt,
  });

  bool get isExpired {
    final now = DateTime.now();
    final expiresAt = issuedAt.add(Duration(seconds: expiresIn));
    return now.isAfter(expiresAt);
  }

  @override
  List<Object> get props => [accessToken, refreshToken, expiresIn, issuedAt];
}