import 'package:equatable/equatable.dart';

class Tokens extends Equatable {
  final String accessToken;
  final String refreshToken;
  final DateTime expiresAt;
  final DateTime? issuedAt;

  const Tokens({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresAt,
    this.issuedAt,
  });

  bool get isExpired {
    return DateTime.now().isAfter(expiresAt);
  }

  @override
  List<Object> get props => [accessToken, refreshToken, expiresAt];
}
