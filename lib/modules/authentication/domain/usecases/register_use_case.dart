import 'package:snapnfix/modules/authentication/index.dart';
import 'package:snapnfix/core/index.dart';

class CompleteProfileUseCase {
  final BaseAuthenticationRepository _repository;

  CompleteProfileUseCase(this._repository);

  Future<Result<Session, ApiError>> call({
    required String firstName,
    required String lastName,
    required String password,
    UserGender? gender,
    DateTime? dateOfBirth,
  }) async {
    return await _repository.register(
      firstName: firstName,
      lastName: lastName,
      password: password,
    );
  }
}
