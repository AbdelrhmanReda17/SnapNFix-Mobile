// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:snapnfix/core/infrastructure/networking/api_result.dart';
// import 'package:snapnfix/modules/authentication/domain/entities/authentication_result.dart';
// import 'package:snapnfix/modules/authentication/domain/providers/social_authentication_provider.dart';
// import 'package:snapnfix/modules/authentication/domain/usecases/social_sign_in_use_case.dart';
// import 'package:snapnfix/core/infrastructure/networking/api_error_model.dart';
// import 'package:snapnfix/modules/authentication/domain/entities/session.dart';

// part 'social_authentication_state.dart';
// part 'social_authentication_cubit.freezed.dart';

// class SocialAuthenticationCubit extends Cubit<SocialAuthenticationState> {
//   final SocialSignInUseCase _socialSignInUseCase;

//   SocialAuthenticationCubit({required SocialSignInUseCase socialSignInUseCase})
//     : _socialSignInUseCase = socialSignInUseCase,
//       super(const SocialAuthenticationState.initial());

//   Future<void> signInWithGoogle() async {
//     await _socialSignIn(SocialAuthenticationProvider.google);
//   }

//   Future<void> signInWithFacebook() async {
//     await _socialSignIn(SocialAuthenticationProvider.facebook);
//   }

//   Future<void> _socialSignIn(SocialAuthenticationProvider provider) async {
//     emit(const SocialAuthenticationState.loading());
//     ApiResult<AuthenticationResult> result;
//     if (provider == SocialAuthenticationProvider.google) {
//       result = await _socialSignInUseCase.callGoogleSignIn();
//     } else {
//       result = await _socialSignInUseCase.callFacebookSignIn();
//     }

//     result.when(
//       success: (authResult) {
//         authResult.whenOrNull(
//           authenticated: (session) {
//             emit(SocialAuthenticationState.success(session));
//           },
//         );
//       },
//       failure: (error) {
//         emit(SocialAuthenticationState.error(error));
//       },
//     );
//   }
// }
