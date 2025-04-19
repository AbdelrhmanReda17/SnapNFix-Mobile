import 'package:snapnfix/core/networking/api_error_handler.dart';
import 'package:snapnfix/core/networking/api_result.dart';
import 'package:snapnfix/core/networking/api_service.dart';
import 'package:snapnfix/features/settings/data/models/edit_profile_dto.dart';

class EditProfileRepository {
  final ApiService _apiService;

  EditProfileRepository(this._apiService);

  Future<ApiResult<String>> editProfile(
    EditProfileDTO changeProfileDTO,
  ) async {
    try {
      // final response = await _apiService.ChangeProfile(changeProfileDTO);
      return ApiResult.success(data: 'Profile updated successfully');
    } catch (error) {
      return ApiResult.failure(
        error: ApiErrorHandler(error).apiErrorModel.message,
      );
    }
  }
}
