import 'package:snapnfix/core/infrastructure/networking/api_result.dart';
import 'package:snapnfix/modules/authentication/domain/entities/authentication_result.dart';
import 'package:snapnfix/modules/authentication/domain/repositories/base_authentication_repository.dart';

class RequestOTPUseCase {
  final BaseAuthenticationRepository _repository;

  RequestOTPUseCase(this._repository);

  Future<ApiResult<AuthenticationResult>> call({
    required String phoneNumber,
    bool isRegister = false,
  }) async {
    return await _repository.requestOTP(
      phoneNumber: phoneNumber,
      isRegister: isRegister,
    );
  }
}
