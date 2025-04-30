import 'package:equatable/equatable.dart';
import 'user.dart';
import 'tokens.dart';

class Session extends Equatable {
  final User user;
  final Tokens? tokens;
  final String? verificationToken;

  const Session({required this.user, this.tokens, this.verificationToken});

  @override
  List<Object?> get props => [user, tokens, verificationToken];
}
