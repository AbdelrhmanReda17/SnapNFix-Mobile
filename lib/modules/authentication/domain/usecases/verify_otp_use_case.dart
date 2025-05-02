import 'package:snapnfix/core/infrastructure/networking/api_result.dart';
import 'package:snapnfix/modules/authentication/domain/entities/authentication_result.dart';
import 'package:snapnfix/modules/authentication/domain/repositories/base_authentication_repository.dart';

class VerifyOtpUseCase {
  final BaseAuthenticationRepository _repository;

  VerifyOtpUseCase(this._repository);

  Future<ApiResult<AuthenticationResult>> call({
    required String code,
    required OtpPurpose purpose,
  }) async {
    return await _repository.verifyOTP(
      code: code,
      purpose: purpose,
    );
  }
}
