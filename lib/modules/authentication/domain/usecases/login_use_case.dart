import 'package:snapnfix/modules/authentication/index.dart';
import 'package:snapnfix/core/index.dart';

class LoginUseCase {
  final BaseAuthenticationRepository _repository;

  LoginUseCase(this._repository);

  Future<Result<AuthenticationResult, ApiError>> call({
    required String phoneOrEmail,
    required String password,
  }) async {
    return await _repository.login(
      phoneOrEmail: phoneOrEmail,
      password: password,
    );
  }
}
