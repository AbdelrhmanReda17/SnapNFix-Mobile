import 'package:injectable/injectable.dart';
import 'package:snapnfix/modules/authentication/domain/usecases/complete_profile_use_case.dart';
import 'package:snapnfix/modules/authentication/domain/usecases/login_use_case.dart';
import 'package:snapnfix/modules/authentication/domain/usecases/request_otp_use_case.dart';
import 'package:snapnfix/modules/authentication/domain/usecases/resend_otp_use_case.dart';
import 'package:snapnfix/modules/authentication/domain/usecases/reset_password_use_case.dart';
import 'package:snapnfix/modules/authentication/domain/usecases/social_sign_in_use_case.dart';
import 'package:snapnfix/modules/authentication/domain/usecases/verify_otp_use_case.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/complete_profile/complete_profile_cubit.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/forget_password/forgot_password_cubit.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/login/login_cubit.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/otp/otp_cubit.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/register/register_cubit.dart';
import 'package:snapnfix/modules/authentication/presentation/cubits/reset_password/reset_password_cubit.dart';

@module
abstract class AuthenticationPresentationModule {
  @injectable
  LoginCubit provideLoginCubit(
    LoginUseCase loginUseCase,
    SocialSignInUseCase socialSignInUseCase,
  ) => LoginCubit(
    loginUseCase: loginUseCase,
    socialSignInUseCase: socialSignInUseCase,
  );

  @injectable
  RegisterCubit provideRegisterCubit(RequestOTPUseCase requestOTPUseCase) =>
      RegisterCubit(requestOTPUseCase);

  @injectable
  OtpCubit provideOtpCubit(
    VerifyOtpUseCase verifyOtpUseCase,
    ResendOtpUseCase resendOtpUseCase,
  ) => OtpCubit(
    verifyOtpUseCase: verifyOtpUseCase,
    resendOtpUseCase: resendOtpUseCase,
  );

  @injectable
  CompleteProfileCubit provideCompleteProfileCubit(
    CompleteProfileUseCase completeProfileUseCase,
  ) => CompleteProfileCubit(completeProfileUseCase: completeProfileUseCase);

  @injectable
  ForgotPasswordCubit provideForgotPasswordCubit(
    RequestOTPUseCase requestOtpUseCase,
  ) => ForgotPasswordCubit(forgotPasswordUseCase: requestOtpUseCase);

  @injectable
  ResetPasswordCubit provideResendOtpCubit(
    ResetPasswordUseCase resetPasswordUseCase,
  ) => ResetPasswordCubit(resetPasswordUseCase: resetPasswordUseCase);
}
