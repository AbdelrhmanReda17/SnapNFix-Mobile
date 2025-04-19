import 'package:snapnfix/modules/authentication/domain/repositories/base_authentication_repository.dart';

class LogoutUseCase {
  final BaseAuthenticationRepository _repository;

  LogoutUseCase(this._repository);

  Future<void> call() async {
    await _repository.logout();
  }
}
