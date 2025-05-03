import 'package:snapnfix/modules/authentication/data/models/tokens_model.dart';
import 'package:snapnfix/modules/authentication/domain/entities/session.dart';

import 'user_model.dart';

class SessionModel extends Session {
  const SessionModel({required super.user, required super.tokens});

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    final user = UserModel.fromJson(json['user']);
    final tokens = TokensModel.fromJson(json['tokens']);
    return SessionModel(user: user, tokens: tokens);
  }

  Map<String, dynamic> toJson() => {
    'user': (user as UserModel).toJson(),
    'tokens': (tokens as TokensModel).toJson(),
  };
}
