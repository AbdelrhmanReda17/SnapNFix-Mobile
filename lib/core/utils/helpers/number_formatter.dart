import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NumberFormatter {
  /// Converts any number to its localized representation.
  /// For Arabic locale, it will convert Western numerals (0-9) to Arabic numerals (٠-٩).
  /// For all other locales, it will keep the Western numerals.
  static String localizeNumber(dynamic number, AppLocalizations localization) {
    // If not Arabic locale, return the number as is
    if (localization.localeName != 'ar') {
      return number.toString();
    }

    final numStr = number.toString();
    final buffer = StringBuffer();

    for (int i = 0; i < numStr.length; i++) {
      final char = numStr[i];
      if (RegExp(r'[0-9]').hasMatch(char)) {
        switch (char) {
          case '0':
            buffer.write('٠');
            break;
          case '1':
            buffer.write(localization.number1);
            break;
          case '2':
            buffer.write(localization.number2);
            break;
          case '3':
            buffer.write(localization.number3);
            break;
          case '4':
            buffer.write(localization.number4);
            break;
          case '5':
            buffer.write(localization.number5);
            break;
          case '6':
            buffer.write(localization.number6);
            break;
          case '7':
            buffer.write(localization.number7);
            break;
          case '8':
            buffer.write(localization.number8);
            break;
          case '9':
            buffer.write(localization.number9);
            break;
          default:
            buffer.write(char);
        }
      } else {
        buffer.write(char);
      }
    }

    return buffer.toString();
  }
}
