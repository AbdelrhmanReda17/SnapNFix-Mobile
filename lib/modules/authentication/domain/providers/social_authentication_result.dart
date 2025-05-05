import 'package:freezed_annotation/freezed_annotation.dart';

part 'social_authentication_result.freezed.dart';

@freezed
class SocialAuthenticationResult with _$SocialAuthenticationResult {
  const factory SocialAuthenticationResult.success({
    required String idToken,
  }) = SocialAuthenticationSuccess;

  const factory SocialAuthenticationResult.cancelled() =
      SocialAuthenticationCancelled;

  const factory SocialAuthenticationResult.failure({
    required String errorMessage,
  }) = SocialAuthenticationFailure;
}
