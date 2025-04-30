import 'package:snapnfix/core/infrastructure/networking/api_result.dart';
import 'package:snapnfix/modules/authentication/domain/entities/authentication_result.dart';
import 'package:snapnfix/modules/authentication/domain/repositories/base_authentication_repository.dart';

class ForgotPasswordUseCase {
  final BaseAuthenticationRepository _repository;

  ForgotPasswordUseCase(this._repository);

  Future<ApiResult<AuthenticationResult>> call({required String emailOrPhoneNumber}) async {
    return await _repository.forgotPassword(emailOrPhoneNumber: emailOrPhoneNumber);
  }
}