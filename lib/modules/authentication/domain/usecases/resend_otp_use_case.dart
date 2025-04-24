import 'package:snapnfix/core/infrastructure/networking/api_result.dart';
import 'package:snapnfix/modules/authentication/domain/repositories/base_authentication_repository.dart';

class ResendOtpUseCase {
  final BaseAuthenticationRepository _repository;

  ResendOtpUseCase(this._repository);

  Future<ApiResult<void>> call() async {
    return await _repository.resendOtp();
  }
}
