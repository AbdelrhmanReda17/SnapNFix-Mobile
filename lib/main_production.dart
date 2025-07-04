import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:snapnfix/core/dependency_injection/dependency_injection.dart';
import 'package:snapnfix/firebase_options.dart';
import 'package:snapnfix/snapnfix_application.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => debugPrint('✅ Firebase initialized successfully'))
      .catchError(
        (error) => debugPrint('❌ Error initializing Firebase: $error'),
      );
  await configureDependencies();
  await ScreenUtil.ensureScreenSize();
  
  const sentryDsn = String.fromEnvironment('SENTRY_DSN');
  
  if (sentryDsn.isNotEmpty) {
    await SentryFlutter.init(
      (options) {
        options.dsn = sentryDsn;
        options.environment = 'production';
        options.release = 'snapnfix@1.0.3+1';
        options.tracesSampleRate = 1.0;
        options.attachScreenshot = true;
        options.screenshotQuality = SentryScreenshotQuality.medium;
        options.attachViewHierarchy = true;
        options.enableAutoPerformanceTracing = true;
        options.captureFailedRequests = true;
        options.debug = false;
        options.diagnosticLevel = SentryLevel.warning;
        options.enableUserInteractionTracing = true;
        options.enableAutoNativeBreadcrumbs = true;
      },
      appRunner: () => runApp(SnapNFixApplication()),
    );
    debugPrint('✅ Sentry initialized successfully for production');
  } else {
    debugPrint('⚠️ Sentry DSN not found, running without crash reporting');
    runApp(SnapNFixApplication());
  }
}
