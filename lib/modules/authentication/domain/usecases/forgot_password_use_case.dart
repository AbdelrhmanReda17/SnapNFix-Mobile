import 'package:snapnfix/core/infrastructure/networking/api_result.dart';
import 'package:snapnfix/modules/authentication/domain/repositories/base_authentication_repository.dart';

class ForgotPasswordUseCase {
  final BaseAuthenticationRepository _repository;

  ForgotPasswordUseCase(this._repository);

  Future<ApiResult<void>> call({required String emailOrPhoneNumber}) async {
    return await _repository.forgotPassword(emailOrPhoneNumber: emailOrPhoneNumber);
  }
}