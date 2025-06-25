import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snapnfix/core/dependency_injection/dependency_injection.dart';
import 'package:snapnfix/modules/index.dart';
import 'package:snapnfix/presentation/navigation/configuration/route_configuration.dart';

import 'package:snapnfix/presentation/navigation/routes.dart';

class AuthenticationRoutes {
  static final loginRoute = RouteConfiguration(
    path: Routes.login,
    name: 'login',
    transitionType: PageTransitionType.none,
    builder:
        (context, state) => BlocProvider(
          create: (context) => getIt<LoginCubit>(),
          child: const LoginScreen(),
        ),
  );

  static final registerRoute = RouteConfiguration(
    path: Routes.register,
    name: 'register',
    transitionType: PageTransitionType.none,
    builder:
        (context, state) => BlocProvider(
          create: (context) => getIt<RegisterCubit>(),
          child: const RegisterScreen(),
        ),
  );

  static final completeProfileRoute = RouteConfiguration(
    path: Routes.completeProfile,
    name: 'completeProfile',
    transitionType: PageTransitionType.none,
    builder: (context, state) {
      final extra = state.extra as Map<String, dynamic>?;
      return BlocProvider(
        create: (context) => getIt<CompleteProfileCubit>(),
        child: CompleteProfileScreen(
          phoneNumber: extra?['phoneNumber'],
          password: extra?['password'],
        ),
      );
    },
  );

  static final resetPasswordRoute = RouteConfiguration(
    path: Routes.resetPassword,
    name: 'resetPassword',
    transitionType: PageTransitionType.none,
    builder:
        (context, state) => BlocProvider(
          create: (context) => getIt<ResetPasswordCubit>(),
          child: const ResetPasswordScreen(),
        ),
  );

  static final otpRoute = RouteConfiguration(
    path: Routes.otp,
    name: 'otp',
    transitionType: PageTransitionType.none,
    builder: (context, state) {
      final extra = state.extra as Map<String, dynamic>?;
      return BlocProvider(
        create: (context) => getIt<OtpCubit>(),
        child: OtpScreen(
          emailOrPhoneNumber: extra?['emailOrPhoneNumber'],
          password: extra?['password'],
          purpose: extra?['purpose'],
        ),
      );
    },
  );

  static final forgotPasswordRoute = RouteConfiguration(
    path: Routes.forgotPassword,
    name: 'forgotPassword',
    transitionType: PageTransitionType.none,
    builder:
        (context, state) => BlocProvider(
          create: (context) => getIt<ForgotPasswordCubit>(),
          child: const ForgotPasswordScreen(),
        ),
  );

  static final routes = [
    loginRoute,
    registerRoute,
    forgotPasswordRoute,
    completeProfileRoute,
    resetPasswordRoute,
    otpRoute,
  ];
}
