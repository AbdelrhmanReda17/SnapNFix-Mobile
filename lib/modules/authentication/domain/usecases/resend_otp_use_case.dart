import 'package:snapnfix/modules/authentication/index.dart';
import 'package:snapnfix/core/index.dart';

class ResendOtpUseCase {
  final BaseAuthenticationRepository _repository;

  ResendOtpUseCase(this._repository);

  Future<Result<bool, ApiError>> call({required OtpPurpose purpose}) async {
    return await _repository.resendOTP(purpose: purpose);
  }
}
