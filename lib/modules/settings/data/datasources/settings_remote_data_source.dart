import 'package:snapnfix/core/infrastructure/networking/error/api_error.dart';
import 'package:snapnfix/core/infrastructure/networking/responses/api_response.dart';
import 'package:snapnfix/core/utils/result.dart';
import 'package:snapnfix/core/infrastructure/networking/api_service.dart';
import 'package:snapnfix/modules/settings/data/models/edit_profile_request.dart';

abstract class BaseSettingsRemoteDataSource {
  Future<Result<bool, ApiError>> editProfile(
    EditProfileRequest editProfileDTO,
  );
}

class SettingsRemoteDataSource implements BaseSettingsRemoteDataSource {
  final ApiService _apiService;

  SettingsRemoteDataSource(this._apiService);

  Future<Result<T, ApiError>> _handleApiCall<T>({
    required Future<ApiResponse<T>> Function() apiCall,
  }) async {
    try {
      final response = await apiCall();
      return Result.success(response.data as T);
    } catch (error) {
      ApiError apiError;
      if (error is Map<String, dynamic>) {
        apiError = ApiError.fromJson(error);
      } else {
        apiError = ApiError(message: error.toString());
      }
      return Result.failure(apiError);
    }
  }

  @override
  Future<Result<bool, ApiError>> editProfile(
    EditProfileRequest editProfileDTO,
  ) async {
    try {
      return await _handleApiCall<bool>(
        apiCall: () => _apiService.editProfile(
          editProfileDTO.toJson(),
        ),
      );
    } catch (error) {
      return Result.failure(
        ApiError(
          message: 'Failed to edit the profile: ${error.toString()}',
          code: error is ApiError ? error.code : null,
        ),
      );
    }
  }
}
