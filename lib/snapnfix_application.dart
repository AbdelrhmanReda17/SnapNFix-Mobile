import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:snapnfix/core/helpers/constants.dart';
import 'package:snapnfix/core/routing/app_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/routing/routes.dart';
import 'package:snapnfix/core/theming/colors.dart';

class SnapNFixApplication extends StatelessWidget {
  final AppRouter appRouter;
  const SnapNFixApplication({super.key, required this.appRouter});
  final _currentLocale = const Locale('en', '');
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MaterialApp(
        title: 'SnapNFix',
        supportedLocales: const [Locale('en', ''), Locale('ar', '')],

        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: ColorsManager.primaryColor,
          ),
          primaryColor: ColorsManager.primaryColor,
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'Poppins',
        ),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: _currentLocale,
        onGenerateRoute: appRouter.generateRoute,
        initialRoute: firstTimeUser
    ? Routes.onBoardingScreen
    : (isLoggedInUser ? Routes.homeScreen : Routes.loginScreen),
      ),
    );
  }
}
