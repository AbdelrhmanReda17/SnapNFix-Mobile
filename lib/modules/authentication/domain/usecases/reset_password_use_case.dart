import 'package:snapnfix/modules/authentication/index.dart';
import 'package:snapnfix/core/index.dart';

class ResetPasswordUseCase {
  final BaseAuthenticationRepository _repository;

  ResetPasswordUseCase(this._repository);

  Future<Result<bool, ApiError>> call({
    required String newPassword,
    required String confirmPassword,
  }) async {
    return await _repository.resetPassword(
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
  }
}
