import 'package:snapnfix/modules/authentication/index.dart';
import 'package:snapnfix/core/index.dart';

class VerifyOtpUseCase {
  final BaseAuthenticationRepository _repository;

  VerifyOtpUseCase(this._repository);

  Future<Result<AuthenticationResult, ApiError>> call({
    required String code,
    required OtpPurpose purpose,
  }) async {
    return await _repository.verifyOTP(code: code, purpose: purpose);
  }
}
