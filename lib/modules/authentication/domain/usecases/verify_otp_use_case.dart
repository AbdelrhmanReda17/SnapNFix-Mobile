import 'package:snapnfix/core/infrastructure/networking/api_result.dart';
import 'package:snapnfix/modules/authentication/domain/entities/session.dart';
import 'package:snapnfix/modules/authentication/domain/repositories/base_authentication_repository.dart';

class VerifyOtpUseCase {
  final BaseAuthenticationRepository _repository;

  VerifyOtpUseCase(this._repository);

  Future<ApiResult<Session>> call({
    required String code,
  }) async {
    return await _repository.verifyOtp(code: code);
  }
}
