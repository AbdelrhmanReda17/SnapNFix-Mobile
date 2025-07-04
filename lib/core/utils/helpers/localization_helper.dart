import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocalizationHelper {
  /// Get localized message for a given key
  /// This is a utility function that can be used to translate error/success message keys
  /// to their localized strings when you have access to context
  static String getLocalizedMessage(BuildContext context, String? messageKey) {
    debugPrint('LocalizationHelper getLocalizedMessage: $messageKey');
    if (messageKey == null || messageKey.isEmpty) return '';

    final localization = AppLocalizations.of(context)!;

    switch (messageKey) {
      // Report error messages
      case 'error_please_provide_image':
        return localization.errorPleaseProvideImage;
      case 'error_submit_report_failed':
        return localization.errorSubmitReportFailed;
      case 'no_internet':
      case 'error_no_internet_connection':
        return localization.errorNoInternetConnection;
      case 'error_report_submission_failed':
        return localization.errorReportSubmissionFailed;
      case 'error_report_saved_offline':
        return localization.errorReportSavedOffline;
      case 'error_fast_report_failed':
        return localization.errorFastReportFailed;
      case 'error_get_reports_failed':
        return localization.errorGetReportsFailed;
      case 'error_get_user_reports_failed':
        return localization.errorGetUserReportsFailed;
      case 'error_get_statistics_failed':
        return localization.errorGetStatisticsFailed;
      case 'error_get_pending_reports_failed':
        return localization.errorGetPendingReportsFailed;
      case 'error_unexpected_occurred':
        return localization.errorUnexpectedOccurred;
      case 'error_clear_reports_failed':
        return localization.errorClearReportsFailed;
      case 'error_delete_report_failed':
        return localization.errorDeleteReportFailed;
      case 'error_initialize_storage_failed':
        return localization.errorInitializeStorageFailed;
      case 'error_mark_report_synced_failed':
        return localization.errorMarkReportSyncedFailed;
      case 'error_save_report_offline_failed':
        return localization.errorSaveReportOfflineFailed;
      case 'error_storage_not_initialized':
        return localization.errorStorageNotInitialized;
      case 'failed_to_edit_profile':
        return localization.failedToEditProfile;
      case 'success_report_saved_offline':
        return localization.successReportSavedOffline;
      case 'success_report_submitted_with_id':
        return localization.successReportSubmittedWithId;
      case 'error_load_areas_failed':
        return localization.errorLoadAreasFailed;
      case 'error_load_area_health_failed':
        return localization.errorLoadAreaHealthFailed;
      case 'error_load_area_issues_failed':
        return localization.errorLoadAreaIssuesFailed;
      case 'error_subscription_failed':
        return localization.errorSubscriptionFailed;
      case 'error_subscribe_area_failed':
        return localization.errorSubscribeAreaFailed;
      case 'error_unsubscription_failed':
        return localization.errorUnsubscriptionFailed;
      case 'error_unsubscribe_area_failed':
        return localization.errorUnsubscribeAreaFailed;
      case 'error_load_subscribed_areas_failed':
        return localization.errorLoadSubscribedAreasFailed;

      // Location permission messages
      case 'location_permission_required_title':
        return localization.locationPermissionRequiredTitle;
      case 'location_permission_required_message':
        return localization.locationPermissionRequiredMessage;
      case 'open_settings':
        return localization.openSettings;

      // Session timeout messages
      case 'session_timeout_message':
        return localization.sessionTimeoutMessage;

      default:
        // If the message is not a known key, return it as is (might be already localized)
        return messageKey;
    }
  }

  /// Check if a string is a localization key
  static bool isLocalizationKey(String? message) {
    if (message == null || message.isEmpty) return false;
    return message.startsWith('error_') ||
        message.startsWith('success_') ||
        message.startsWith('warning_') ||
        message.startsWith('info_') ||
        message.startsWith('location_') ||
        message.startsWith('session_');
  }
}
