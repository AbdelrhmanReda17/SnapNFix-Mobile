// fetch all data from shared preferences and store it in this class
import 'package:snapnfix/core/helpers/shared_pref_helper.dart';
import 'package:snapnfix/core/helpers/shared_pref_keys.dart';

class ApplicationConfigurations {
  static late bool hasViewedOnboarding;
  static late String userToken;

  static awaitFirstTimeOnboardingScreen() async {
    hasViewedOnboarding = await SharedPrefHelper.getBool(
      SharedPrefKeys.hasViewedOnboarding,
    );
  }

  static awaitUserToken() async {
    userToken = await SharedPrefHelper.getSecuredString(
      SharedPrefKeys.userToken,
    );
  }

  static init() async {
    await awaitFirstTimeOnboardingScreen();
    await awaitUserToken();
  }
}
