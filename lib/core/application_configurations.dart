// fetch all data from shared preferences and store it in this class
import 'package:snapnfix/core/application_constants.dart';
import 'package:snapnfix/core/helpers/shared_pref_helper.dart';
import 'package:snapnfix/core/helpers/shared_pref_keys.dart';

class ApplicationConfigurations {
  static late bool hasViewedOnboarding;
  static late String userToken;
  static late String language;
  static late bool isDarkMode;

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

  static awaitLanguage() async {
    language =
        await SharedPrefHelper.getSecuredString(SharedPrefKeys.language) ?? "en";
    if (language.isEmpty ||
        language == "null" ||
        ApplicationConstants.availableLanguages[language] == null) {
      language = "en";
    }
  }

  static awaitDarkMode() async {
    isDarkMode =
        await SharedPrefHelper.getBool(SharedPrefKeys.isDarkMode) ?? false;
  }

  static init() async {
    await awaitFirstTimeOnboardingScreen();
    await awaitUserToken();
    await awaitLanguage();
    await awaitDarkMode();
  }
}
