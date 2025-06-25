import 'package:snapnfix/modules/authentication/index.dart';
import 'package:snapnfix/core/index.dart';

class RequestOTPUseCase {
  final BaseAuthenticationRepository _repository;

  RequestOTPUseCase(this._repository);

  Future<Result<AuthenticationResult, ApiError>> call({
    required String phoneNumber,
    required OtpPurpose purpose,
  }) async {
    return await _repository.requestOTP(
      phoneNumber: phoneNumber,
      purpose: purpose,
    );
  }
}
