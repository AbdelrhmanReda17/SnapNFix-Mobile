part of 'edit_profile_cubit.dart';

@freezed
class EditProfileState<T> with _$EditProfileState<T> {
  const factory EditProfileState.initial() = _Initial;

  const factory EditProfileState.loading() = Loading;
  const factory EditProfileState.success(T data) = Success<T>;
  const factory EditProfileState.error({required ApiError error}) = Error;
}
