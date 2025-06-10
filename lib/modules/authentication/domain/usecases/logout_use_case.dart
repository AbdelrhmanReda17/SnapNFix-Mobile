import 'package:snapnfix/core/infrastructure/networking/api_result.dart';
import 'package:snapnfix/modules/authentication/domain/repositories/base_authentication_repository.dart';

class LogoutUseCase {
  final BaseAuthenticationRepository _repository;

  LogoutUseCase(this._repository);

  Future<ApiResult<void>> call() async {
    return await _repository.logout();
  }
}
