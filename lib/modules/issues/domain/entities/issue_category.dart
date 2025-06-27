import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum IssueCategory {
  garbage('Garbage'),
  defectiveManhole('Defective Manhole'),
  pothole('Pothole'),
  nonDefectiveManhole('Non-Defective Manhole');

  final String displayName;
  const IssueCategory(this.displayName);

  String getLocalizedName(AppLocalizations localization) {
    switch (this) {
      case IssueCategory.garbage:
        return localization.garbage;
      case IssueCategory.defectiveManhole:
        return localization.defectiveManhole;
      case IssueCategory.pothole:
        return localization.pothole;
      case IssueCategory.nonDefectiveManhole:
          return localization.nonDefectiveManhole;
    }
  }

  @override
  String toString() => displayName;
}
