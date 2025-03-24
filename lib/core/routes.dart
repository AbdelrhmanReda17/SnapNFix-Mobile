import 'package:flutter/widgets.dart';
import 'package:snapnfix/features/authentication/presentation/screens/login_screen.dart';
import 'package:snapnfix/features/authentication/presentation/screens/sign_up_screen.dart';
import 'package:snapnfix/features/home/presentation/screens/home_screen.dart';
import 'package:snapnfix/features/map/presentation/screens/map_screen.dart';
import 'package:snapnfix/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:snapnfix/features/reports/presentation/screens/add_report_screen.dart';
import 'package:snapnfix/features/reports/presentation/screens/user_reports_screen.dart';
import 'package:snapnfix/features/settings/presentation/screens/settings_dart.dart';

class Routes {
  static const MapEntry<String, Widget> onBoardingScreen = MapEntry(
    '/onBoardingScreen',
    OnboardingScreen(),
  );
  static const MapEntry<String, Widget> loginScreen = MapEntry(
    '/loginScreen',
    LoginScreen(),
  );
  static const MapEntry<String, Widget> signUpScreen = MapEntry(
    '/signUpScreen',
    SignUpScreen(),
  );
  static const MapEntry<String, Widget> homeScreen = MapEntry(
    '/homeScreen',
    HomeScreen(),
  );
  static const MapEntry<String, Widget> mapScreen = MapEntry(
    '/mapScreen',
    MapScreen(),
  );
  static const MapEntry<String, Widget> userReportsScreen = MapEntry(
    '/userReportsScreen',
    UserReportsScreen(),
  );
  static const MapEntry<String, Widget> settingsScreen = MapEntry(
    '/settingsScreen',
    SettingsScreen(),
  );
  static const MapEntry<String, Widget> addReportScreen = MapEntry(
    '/addReportScreen',
    AddReportScreen(),
  );
}
