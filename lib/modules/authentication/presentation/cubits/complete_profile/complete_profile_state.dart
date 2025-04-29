part of 'complete_profile_cubit.dart';

@freezed
class CompleteProfileState with _$CompleteProfileState {
  const factory CompleteProfileState.initial({
    @Default(UserGender.notSpecified) UserGender gender,
    DateTime? dateOfBirth,
  }) = _Initial;
  const factory CompleteProfileState.loading() = _Loading;
  const factory CompleteProfileState.success(Session session) = _Success;
  const factory CompleteProfileState.error(ApiErrorModel error) = _Error;
}

enum CompleteProfileStatus { initial, loading, success, error }
