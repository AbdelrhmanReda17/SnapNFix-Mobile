import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:snapnfix/core/application_configurations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/dependency_injection/dependency_injection.dart';
import 'package:snapnfix/core/theming/application_themes.dart';

class SnapNFixApplication extends StatelessWidget {
  const SnapNFixApplication({super.key});

  @override
  Widget build(BuildContext context) {
    final appConfigs = ApplicationConfigurations.instance;

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: ListenableBuilder(
        listenable: appConfigs,
        builder: (context, _) {
          return MaterialApp.router(
            title: 'SnapNFix',
            supportedLocales: AppLocalizations.supportedLocales,
            debugShowCheckedModeBanner: false,
            themeMode: appConfigs.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            theme:
                appConfigs.isDarkMode
                    ? ApplicationThemes.darkTheme
                    : ApplicationThemes.lightTheme,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            locale: Locale(appConfigs.language),
            routerConfig: getIt<GoRouter>(),
          );
        },
      ),
    );
  }
}
