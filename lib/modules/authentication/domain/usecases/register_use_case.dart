import 'package:snapnfix/core/infrastructure/networking/api_result.dart';
import 'package:snapnfix/modules/authentication/domain/entities/session.dart';
import 'package:snapnfix/modules/authentication/domain/repositories/base_authentication_repository.dart';

class RegisterUseCase {
  final BaseAuthenticationRepository _repository;

  RegisterUseCase(this._repository);

  Future<ApiResult<Session>> call({
    required String phoneNumber,
    required String password,
    required String confirmPassword,
  }) async {
    return await _repository.register(
      phoneNumber: phoneNumber,
      password: password,
      confirmPassword: confirmPassword,
    );
  }
}
