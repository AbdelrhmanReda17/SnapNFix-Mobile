import 'package:snapnfix/core/infrastructure/networking/api_result.dart';
import 'package:snapnfix/modules/authentication/domain/repositories/base_authentication_repository.dart';

class ResetPasswordUseCase {
  final BaseAuthenticationRepository _repository;

  ResetPasswordUseCase(this._repository);

  Future<ApiResult<bool>> call({
    required String newPassword,
    required String confirmPassword,
  }) async {
    return await _repository.resetPassword(
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
  }
}
