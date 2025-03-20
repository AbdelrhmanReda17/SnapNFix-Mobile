part of 'sign_up_cubit.dart';

@freezed
class SignUpState<T> with _$SignUpState<T> {
  const factory SignUpState.initial() = _Initial;
  const factory SignUpState.loading() = Loading;
  const factory SignUpState.success(T data) = Success<T>;
  const factory SignUpState.error({required String error}) = Error;
}