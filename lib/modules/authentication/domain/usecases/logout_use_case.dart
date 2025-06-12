import 'package:snapnfix/modules/authentication/index.dart';
import 'package:snapnfix/core/index.dart';

class LogoutUseCase {
  final BaseAuthenticationRepository _repository;

  LogoutUseCase(this._repository);

  Future<Result<void, ApiError>> call() async {
    return await _repository.logout();
  }
}
