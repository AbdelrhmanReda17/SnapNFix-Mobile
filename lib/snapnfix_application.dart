import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:snapnfix/core/application_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/theming/colors.dart';
import 'package:snapnfix/features/settings/presentation/logic/cubit/settings_cubit.dart';

class SnapNFixApplication extends StatelessWidget {
  final ApplicationRouter appRouter;
  const SnapNFixApplication({super.key, required this.appRouter});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit(),
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return ScreenUtilInit(
            designSize: const Size(375, 812),
            minTextAdapt: true,
            child: MaterialApp.router(
              title: 'SnapNFix',
              supportedLocales: AppLocalizations.supportedLocales,
              debugShowCheckedModeBanner: false,
              themeMode: state.isDarkMode ? ThemeMode.dark : ThemeMode.light,
              theme:
                  state.isDarkMode
                      ? ThemeData.dark().copyWith(
                        colorScheme: ColorScheme.fromSeed(
                          seedColor: ColorsManager.primaryColor,
                        ),
                        scaffoldBackgroundColor: ColorsManager.quinaryColor,
                      )
                      : ThemeData(
                        colorScheme: ColorScheme.fromSeed(
                          seedColor: ColorsManager.primaryColor,
                        ),
                        primaryColor: ColorsManager.primaryColor,
                        scaffoldBackgroundColor: Colors.white,
                        fontFamily: 'Poppins',
                        useMaterial3: true,
                      ),
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              locale: Locale(state.language),
              routerConfig: appRouter.router,
            ),
          );
        },
      ),
    );
  }
}
