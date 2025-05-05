import 'package:equatable/equatable.dart';
import 'user.dart';
import 'tokens.dart';

class Session extends Equatable {
  final User user;
  final Tokens tokens;

  const Session({required this.user, required this.tokens});

  @override
  List<Object?> get props => [user, tokens];
}
