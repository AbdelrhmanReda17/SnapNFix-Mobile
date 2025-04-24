import 'package:snapnfix/core/infrastructure/networking/api_result.dart';
import 'package:snapnfix/modules/authentication/domain/entities/session.dart';
import 'package:snapnfix/modules/authentication/domain/repositories/base_authentication_repository.dart';

class LoginUseCase {
  final BaseAuthenticationRepository _repository;

  LoginUseCase(this._repository);

  Future<ApiResult<Session>> call({
    required String phoneOrEmail,
    required String password,
  }) async {
    return await _repository.login(
      phoneOrEmail: phoneOrEmail,
      password: password,
    );
  }
}
