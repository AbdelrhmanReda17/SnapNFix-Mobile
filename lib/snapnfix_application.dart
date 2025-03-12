import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class SnapNFixApplication extends StatelessWidget {
  const SnapNFixApplication({super.key});
  final _currentLocale = const Locale('en', '');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SnapNFix',
      supportedLocales: const [Locale('en', ''), Locale('ar', '')],
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _currentLocale,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(title: Text(AppLocalizations.of(context)!.hello)),
            body: Center(child: Text(AppLocalizations.of(context)!.welcome)),
          );
        },
      ),
    );
  }
}
