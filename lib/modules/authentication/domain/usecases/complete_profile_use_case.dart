import 'package:snapnfix/core/infrastructure/networking/api_result.dart';
import 'package:snapnfix/modules/authentication/domain/entities/session.dart';
import 'package:snapnfix/modules/authentication/domain/entities/user_gender.dart';
import 'package:snapnfix/modules/authentication/domain/repositories/base_authentication_repository.dart';

class CompleteProfileUseCase {
  final BaseAuthenticationRepository _repository;

  CompleteProfileUseCase(this._repository);

  Future<ApiResult<Session>> call({
    required String firstName,
    required String lastName,
    UserGender? gender,
    DateTime? dateOfBirth,
  }) async {
    return await _repository.completeProfile(
      firstName: firstName,
      lastName: lastName,
      gender: gender,
      dateOfBirth: dateOfBirth,
    );
  }
}
