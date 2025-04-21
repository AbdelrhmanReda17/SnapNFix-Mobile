import 'package:flutter/widgets.dart';
import 'package:snapnfix/modules/authentication/presentation/screens/login_screen.dart';
import 'package:snapnfix/modules/authentication/presentation/screens/register_screen.dart';
import 'package:snapnfix/modules/onboarding/screens/onboarding_screen.dart';
import 'package:snapnfix/modules/reports/presentation/screens/submit_report_screen.dart';
import 'package:snapnfix/modules/settings/presentation/screens/change_password.dart';
import 'package:snapnfix/modules/settings/presentation/screens/edit_profile.dart';
import 'package:snapnfix/modules/settings/presentation/screens/settings_dart.dart';

import 'package:snapnfix/presentation/screens/home_screen.dart';
import 'package:snapnfix/presentation/screens/temp_screen.dart';

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
    TempScreen(),
  );
  static const MapEntry<String, Widget> userReportsScreen = MapEntry(
    '/userReportsScreen',
    TempScreen(),
  );
  static const MapEntry<String, Widget> settingsScreen = MapEntry(
    '/settingsScreen',
     SettingsScreen(),
  );
  static const MapEntry<String, Widget> submitReportScreen = MapEntry(
    '/submitReportScreen',
    SubmitReportScreen(),
  );
  static const MapEntry<String, Widget> changePassowrd = MapEntry(
    '/changePassword',
    ChangePassword(),
  );
  static const MapEntry<String, Widget> editProfile = MapEntry(
    '/editProfile',
    EditProfile(),
  );
}
