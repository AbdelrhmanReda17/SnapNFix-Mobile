import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:snapnfix/presentation/navigation/router_configuration.dart';
import 'package:snapnfix/presentation/navigation/routes.dart';

@lazySingleton
class NavigationService {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void showSessionExpiredSnackBar() {
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.white),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'Your session has expired. Please log in again.',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.orange,
        duration: const Duration(seconds: 4),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void showErrorSnackBar(String message) {
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(
              child: Text(message, style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // Add method to navigate to user reports
  void navigateToUserReports() {
    debugPrint('Navigating to user reports');
    try {
      RouterConfiguration.router.go(Routes.userReports);
    } catch (e) {
      debugPrint('Error navigating to user reports: $e');
    }
  }

  void handleNotificationNavigation(Map<String, dynamic> data) {
    // final notificationType = data['type'] as String?;

    // switch (notificationType) {
    //   case 'snap_report_status_changed':
    //     navigateToUserReports();
    //     break;
    //   case 'report_update':
    //     navigateToUserReports();
    //     break;
    //   // Add other notification types as needed
    //   default:
    //     // Handle other notification types or do nothing
    //     break;
    // }
    navigateToUserReports();
  }
}
