import 'package:flutter/widgets.dart';
import 'package:snapnfix/modules/authentication/presentation/screens/login_screen.dart';
import 'package:snapnfix/modules/authentication/presentation/screens/register_screen.dart';
import 'package:snapnfix/modules/onboarding/screens/onboarding_screen.dart';

import 'package:snapnfix/presentation/screens/home_screen.dart';

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
    '/registerScreen',
    RegisterScreen(),
  );
  static const MapEntry<String, Widget> homeScreen = MapEntry(
    '/homeScreen',
    HomeScreen(),
  );
  static const MapEntry<String, Widget> mapScreen = MapEntry(
    '/mapScreen',
    HomeScreen(),
  );
  static const MapEntry<String, Widget> userReportsScreen = MapEntry(
    '/userReportsScreen',
    HomeScreen(),
  );
  static const MapEntry<String, Widget> settingsScreen = MapEntry(
    '/settingsScreen',
    HomeScreen(),
  );
  static const MapEntry<String, Widget> addReportScreen = MapEntry(
    '/addReportScreen',
    HomeScreen(),
  );
  static const MapEntry<String, Widget> changePassowrd = MapEntry(
    '/changePassword',
    HomeScreen(),
  );
  static const MapEntry<String, Widget> editProfile = MapEntry(
    '/editProfile',
    HomeScreen(),
  );
}
